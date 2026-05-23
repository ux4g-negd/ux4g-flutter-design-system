#!/usr/bin/env python3
"""Generate professional component docs with left navigation and detail pane.

Order in detail pane:
1) Overview
2) All Parameters table
3) Usage with copy button
"""

from __future__ import annotations

import datetime
import html
import json
import posixpath
import re
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[1]
BARREL_FILE = ROOT / "lib" / "ux4g_flutter_design_system.dart"
COMPONENTS_DIR = ROOT / "lib" / "src" / "components"
OUTPUT_FILE = ROOT / "docs" / "component-library.html"

EXPORT_RE = re.compile(r"export\s+'src/components/(?P<path>[^']+)'\s*;")
CLASS_DECL_RE = re.compile(
  r"class\s+(?P<name>[A-Z][A-Za-z0-9_]*)(?:\s*<[^>]+>)?\s*(?:extends\s+(?P<extends>[A-Za-z0-9_<>]+))?",
    re.DOTALL,
)
EXPORT_ANY_RE = re.compile(r"export\s+'(?P<path>[^']+)'\s*;")
CTOR_RE_TEMPLATE = r"{name}\s*\((?P<params>.*?)\)\s*(?::|\{{|=>)"
PARAM_RE = re.compile(
    r"(?P<required>required\s+)?"
    r"(?P<type>[A-Za-z_][A-Za-z0-9_<>,?.\s\[\]]*?)\s+"
    r"(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
    r"\s*(?:=\s*(?P<default>[^,\)]+))?\s*(?:,|$)",
    re.DOTALL,
)
CLASS_LINE_RE_TEMPLATE = r"class\s+{name}\b"

CATEGORY_RULES = [
    ("biometric", "Biometric"),
    ("input", "Inputs"),
    ("search", "Inputs"),
    ("dropdown", "Inputs"),
    ("checkbox", "Inputs"),
    ("toggle", "Inputs"),
    ("slider", "Inputs"),
    ("otp", "Inputs"),
    ("button", "Buttons"),
    ("chip", "Data Display"),
    ("badge", "Data Display"),
    ("card", "Data Display"),
    ("tag", "Data Display"),
    ("avatar", "Data Display"),
    ("timeline", "Data Display"),
    ("progress", "Progress"),
    ("step", "Progress"),
    ("toast", "Feedback"),
    ("modal", "Feedback"),
    ("sheet", "Feedback"),
    ("tooltip", "Feedback"),
    ("banner", "Feedback"),
    ("carousel", "Navigation"),
    ("pagination", "Navigation"),
    ("header", "Navigation"),
]


def clean_spaces(value: str) -> str:
    return " ".join(value.replace("\n", " ").split())


def infer_category(file_name: str, class_name: str) -> str:
    token = f"{file_name.lower()} {class_name.lower()}"
    for key, value in CATEGORY_RULES:
        if key in token:
            return value
    return "Components"


def split_words(stem: str) -> list[str]:
    return [w for w in stem.replace("-", "_").split("_") if w]


def pick_primary_class(path: Path, source: str) -> str | None:
    widgets: list[str] = []
    for m in CLASS_DECL_RE.finditer(source):
        cls = m.group("name")
        ext = (m.group("extends") or "").strip()
        if ext in {"StatelessWidget", "StatefulWidget"}:
            widgets.append(cls)

    if not widgets:
        return None

    tokens = split_words(path.stem.lower())

    def score(cls: str) -> tuple[int, int, int, int]:
        lower = cls.lower()
        token_score = sum(1 for t in tokens if t in lower)
        starts_ux = 1 if cls.startswith("Ux4g") else 0
        exactish = 1 if lower.endswith("".join(tokens)) else 0
        shortness = -len(cls)
        return (token_score, starts_ux, exactish, shortness)

    return max(widgets, key=score)


def parse_params(source: str, class_name: str) -> list[dict]:
    ctor_start_re = re.compile(rf"(?:const\s+)?{re.escape(class_name)}\s*\(")
    start_match = ctor_start_re.search(source)
    if not start_match:
        return []

    open_paren = source.find("(", start_match.start())
    if open_paren == -1:
        return []

    depth = 0
    close_paren = -1
    for i in range(open_paren, len(source)):
        ch = source[i]
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                close_paren = i
                break

    if close_paren == -1:
        return []

    block = source[open_paren + 1 : close_paren]
    named = re.search(r"\{(?P<named>.*)\}", block, re.DOTALL)
    if named:
        block = named.group("named")

    # Collect field types from class body, so `this.foo` can be typed correctly.
    class_start_re = re.compile(CLASS_LINE_RE_TEMPLATE.format(name=re.escape(class_name)))
    class_match = class_start_re.search(source)
    field_types: dict[str, str] = {}
    if class_match:
      body_slice = source[class_match.start() : close_paren + 1]
      for fm in re.finditer(r"(?:final|late\s+final|late)\s+([^;\n]+?)\s+([A-Za-z_][A-Za-z0-9_]*)\s*;", body_slice):
        field_types[fm.group(2)] = clean_spaces(fm.group(1))

    parts = [p.strip() for p in block.split(",") if p.strip()]
    out = []
    for part in parts:
      raw = part
      required = False
      default = "-"
      if raw.startswith("required "):
        required = True
        raw = raw[len("required ") :].strip()

      if "=" in raw:
        left, right = raw.split("=", 1)
        raw = left.strip()
        default = clean_spaces(right.strip())

      if raw.startswith("this.") or raw.startswith("super."):
        name = raw.split(".", 1)[1].strip()
        if name:
          out.append(
            {
              "name": name,
              "type": field_types.get(name, "dynamic"),
              "required": required,
              "default": default,
            }
          )
        continue

      m = re.match(r"(?P<type>[A-Za-z_][A-Za-z0-9_<>,?.\s\[\]]*?)\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)$", raw)
      if m:
        out.append(
          {
            "name": m.group("name"),
            "type": clean_spaces(m.group("type")),
            "required": required,
            "default": default,
          }
        )

    return out


def extract_overview(
    source: str,
    class_name: str,
    category: str,
    param_count: int,
    required_count: int,
    optional_count: int,
) -> str:
    class_line_re = re.compile(CLASS_LINE_RE_TEMPLATE.format(name=re.escape(class_name)))
    m = class_line_re.search(source)
    if m:
        before = source[: m.start()].splitlines()
        comment_lines = []
        for line in reversed(before):
            stripped = line.strip()
            if stripped.startswith("///"):
                comment_lines.append(stripped[3:].strip())
                continue
            if stripped == "":
                if comment_lines:
                    break
                continue
            break
        if comment_lines:
            comment_lines.reverse()
            text = " ".join(comment_lines)
            text = re.sub(r"\[[^\]]+\]", "", text)
            text = clean_spaces(text)
            if "```" in text:
                text = text.split("```", 1)[0].strip()
            if "Quick usage" in text:
                text = text.split("Quick usage", 1)[0].strip()
            if len(text) > 260:
                text = text[:257].rstrip() + "..."
            if text:
                return text

    return (
        f"{class_name} is a {category} component in UX4G Flutter Design System. "
        f"It has {param_count} constructor parameters ({required_count} required, {optional_count} optional)."
    )


def extract_usage_from_example(example_source: str, class_name: str) -> str | None:
    token = f"{class_name}("
    idx = example_source.find(token)
    if idx == -1:
        return None

    start = idx + len(class_name)
    if start >= len(example_source) or example_source[start] != "(":
        return None

    depth = 0
    end = -1
    for i in range(start, len(example_source)):
        ch = example_source[i]
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                end = i
                break

    if end == -1:
        return None

    snippet = example_source[idx : end + 1]
    lines = snippet.splitlines()
    if len(lines) > 24:
        lines = lines[:24]
        if lines:
            lines[-1] = "  // ..."
            lines.append(")")
    return "\n".join(lines)


def sample_value(ptype: str) -> str:
    t = ptype.replace("?", "").strip()
    if "String" in t:
        return "'value'"
    if "bool" in t:
        return "false"
    if "int" in t:
        return "0"
    if "double" in t:
        return "0.0"
    if "Color" in t:
        return "Colors.blue"
    if "IconData" in t:
        return "Icons.star"
    if "VoidCallback" in t:
        return "() {}"
    if "ValueChanged" in t:
        return "(value) {}"
    if "Widget" in t:
        return "const SizedBox.shrink()"
    return "/* value */"


def usage_snippet(component: dict) -> str:
    required = [p for p in component["parameters"] if p["required"]]
    optional = [p for p in component["parameters"] if not p["required"]]
    lines = [f"{component['name']}("]
    for p in required:
        lines.append(f"  {p['name']}: {sample_value(p['type'])},")
    for p in optional[:3]:
        lines.append(f"  {p['name']}: {sample_value(p['type'])},")
    lines.append(")")
    return "\n".join(lines)


def parse_enums(source: str) -> dict[str, list[str]]:
    enums: dict[str, list[str]] = {}
    for m in re.finditer(r"enum\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*\{(?P<body>[^}]*)\}", source, re.DOTALL):
        enum_name = m.group("name")
        raw_body = m.group("body")
        values: list[str] = []
        for part in raw_body.split(","):
            candidate = part.strip()
            if not candidate:
                continue
            candidate = candidate.split("//", 1)[0].strip()
            candidate = candidate.split("(", 1)[0].strip()
            if candidate and re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", candidate):
                values.append(candidate)
        if values:
            enums[enum_name] = values
    return enums


def extract_customizations(source: str, params: list[dict], enum_map: dict[str, list[str]]) -> list[dict]:
  customizations: list[dict] = []
  enums = dict(enum_map)
  enums.update(parse_enums(source))

  # Enum-backed params provide explicit variant/size/type choices.
  for p in params:
    ptype = p["type"].replace("?", "").strip()
    if ptype in enums:
      customizations.append(
        {
          "param": p["name"],
          "kind": "enum",
          "type": ptype,
          "options": enums[ptype],
          "default": p["default"],
        }
      )

  for p in params:
    ptype = p["type"].replace("?", "").strip()
    if ptype == "bool":
      customizations.append(
        {
          "param": p["name"],
          "kind": "bool",
          "default": p["default"],
        }
      )

  style_type_tokens = (
    "Color",
    "TextStyle",
    "Border",
    "BorderRadius",
    "EdgeInsets",
    "IconData",
    "ShapeBorder",
    "BoxDecoration",
    "ButtonStyle",
  )
  style_name_tokens = (
    "style",
    "color",
    "icon",
    "radius",
    "padding",
    "margin",
    "border",
    "shape",
    "elevation",
  )

  for p in params:
    ptype = p["type"].replace("?", "").strip()
    pname = p["name"].lower()
    if any(tok in ptype for tok in style_type_tokens) or any(tok in pname for tok in style_name_tokens):
      customizations.append(
        {
          "param": p["name"],
          "kind": "style",
          "type": p["type"],
          "default": p["default"],
        }
      )

  seen: set[str] = set()
  deduped: list[dict] = []
  for item in customizations:
    key = f"{item.get('kind','')}::{item.get('param','')}::{item.get('type','')}"
    if key in seen:
      continue
    seen.add(key)
    deduped.append(item)
  return deduped


def build_global_enum_map(rel_paths: list[str]) -> dict[str, list[str]]:
  enum_map: dict[str, list[str]] = {}
  for rel in rel_paths:
    path = COMPONENTS_DIR / rel
    if not path.exists() or not path.is_file():
      continue
    source = path.read_text(encoding="utf-8")
    enum_map.update(parse_enums(source))
  return enum_map


def resolve_component_exports() -> list[str]:
  exports_src = BARREL_FILE.read_text(encoding="utf-8")
  root_rel_paths = [m.group("path") for m in EXPORT_RE.finditer(exports_src)]

  queue = list(root_rel_paths)
  seen: set[str] = set()
  resolved: list[str] = []

  while queue:
    rel = queue.pop(0)
    rel = str(PurePosixPath(rel))
    if rel in seen:
      continue
    seen.add(rel)

    path = COMPONENTS_DIR / rel
    if not path.exists() or not path.is_file():
      continue

    resolved.append(rel)
    source = path.read_text(encoding="utf-8")

    for match in EXPORT_ANY_RE.finditer(source):
      export_path = match.group("path")
      if export_path.startswith("src/components/"):
        child_rel = export_path[len("src/components/") :]
      else:
        parent = posixpath.dirname(rel)
        child_rel = posixpath.normpath(posixpath.join(parent, export_path))

      if child_rel.startswith("..") or not child_rel.endswith(".dart"):
        continue
      if child_rel not in seen:
        queue.append(child_rel)

  return resolved


def build_components() -> list[dict]:
  rel_paths = resolve_component_exports()
  example_file = ROOT / "example" / "lib" / "main.dart"
  example_source = example_file.read_text(encoding="utf-8") if example_file.exists() else ""
  enum_map = build_global_enum_map(rel_paths)

  # Components to exclude from documentation
  excluded_components = {
    'CameraCaptureScreen',
    'DeviceCheckCard',
    'DeviceCheckScreen',
    'FaceAlignmentOverlay',
    'IdentityConsentScreen',
  }

  comps: list[dict] = []
  for rel in rel_paths:
    path = COMPONENTS_DIR / rel
    if not path.exists() or not path.is_file():
      continue

    source = path.read_text(encoding="utf-8")
    cls = pick_primary_class(path, source)
    if not cls:
      continue

    # Skip excluded components
    if cls in excluded_components:
      continue

    params = parse_params(source, cls)
    required_count = len([p for p in params if p["required"]])
    optional_count = len(params) - required_count
    category = infer_category(path.name, cls)

    comp = {
      "name": cls,
      "file": path.relative_to(ROOT).as_posix(),
      "category": category,
      "parameters": params,
      "customizations": extract_customizations(source, params, enum_map),
      "overview": extract_overview(
        source,
        cls,
        category,
        len(params),
        required_count,
        optional_count,
      ),
    }
    comp["usage"] = extract_usage_from_example(example_source, cls) or usage_snippet(comp)
    comps.append(comp)

  comps.sort(key=lambda c: c["name"].lower())
  return comps


def build_html(components: list[dict]) -> str:
    payload = json.dumps(components)
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")

    return f"""<!doctype html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>UX4G Component Documentation</title>
  <style>
    :root {{
      --bg: #0c1117;
      --panel: #121a23;
      --text: #ecf2f9;
      --muted: #9db0c3;
      --line: #27374a;
      --brand: #2ea8ff;
    }}
    * {{ box-sizing: border-box; }}
    body {{ margin: 0; font-family: 'Segoe UI', Tahoma, sans-serif; background: var(--bg); color: var(--text); }}
    .app {{ display: grid; grid-template-columns: 320px 1fr; min-height: 100vh; }}
    .nav {{ background: #101820; border-right: 1px solid var(--line); padding: 16px; position: sticky; top: 0; height: 100vh; overflow: auto; }}
    .brand {{ padding: 8px 8px 14px; border-bottom: 1px solid var(--line); margin-bottom: 12px; }}
    .brand h1 {{ margin: 0; font-size: 18px; }}
    .brand p {{ margin: 6px 0 0; font-size: 12px; color: var(--muted); }}
    .search {{ width: 100%; border: 1px solid var(--line); border-radius: 10px; background: #0f1821; color: var(--text); padding: 9px 10px; margin: 8px 0 12px; }}
    .list {{ display: grid; gap: 8px; }}
    .item {{ text-align: left; width: 100%; background: #13202d; border: 1px solid var(--line); color: var(--text); border-radius: 10px; padding: 10px; cursor: pointer; }}
    .item:hover, .item.active {{ border-color: var(--brand); }}
    .item .n {{ display: block; font-size: 13px; font-weight: 600; }}
    .item .m {{ display: block; font-size: 11px; color: var(--muted); margin-top: 3px; }}

    .main {{ padding: 24px; }}
    .hero {{ border: 1px solid var(--line); background: #121e2b; border-radius: 14px; padding: 18px; margin-bottom: 16px; }}
    .hero h2 {{ margin: 0; font-size: 24px; }}
    .hero p {{ color: var(--muted); margin: 8px 0 0; }}

    .card {{ border: 1px solid var(--line); background: var(--panel); border-radius: 12px; padding: 14px; margin-bottom: 14px; }}
    .card h3 {{ margin: 0 0 10px; font-size: 15px; color: var(--brand); }}

    pre {{ margin: 0; background: #0c141d; border: 1px solid var(--line); border-radius: 10px; padding: 12px; font-size: 12px; overflow: auto; white-space: pre; line-height: 1.45; tab-size: 2; }}
    .copy-btn {{ position: absolute; top: 8px; right: 8px; background: #162535; color: var(--text); border: 1px solid var(--line); border-radius: 8px; padding: 6px 10px; cursor: pointer; font-size: 12px; transition: all 0.2s; }}
    .copy-btn:hover {{ background: #1a3a52; border-color: var(--brand); }}
    .copy-btn.copied {{ color: #60d394; border-color: #60d394; }}
    .copy-inline {{ margin-top: 6px; border: 1px solid var(--line); background: #162535; color: var(--text); border-radius: 8px; padding: 6px 10px; cursor: pointer; font-size: 12px; }}
    .copy-inline:hover {{ background: #1a3a52; border-color: var(--brand); }}
    .copy-inline.copied {{ color: #60d394; border-color: #60d394; }}

    .copy {{ margin-top: 8px; border: 1px solid var(--line); background: #162535; color: var(--text); border-radius: 8px; padding: 7px 10px; cursor: pointer; }}

    table {{ width: 100%; border-collapse: collapse; }}
    th, td {{ text-align: left; padding: 8px; border-bottom: 1px solid var(--line); font-size: 13px; vertical-align: top; }}
    th {{ color: var(--brand); font-weight: 600; }}
    .badge {{ display: inline-block; border-radius: 999px; padding: 2px 8px; font-size: 11px; font-weight: 700; }}
    .req {{ background: rgba(255, 107, 107, 0.2); color: #ff9f9f; border: 1px solid rgba(255,107,107,0.5); }}
    .opt {{ background: rgba(96, 211, 148, 0.2); color: #b2f0ca; border: 1px solid rgba(96,211,148,0.5); }}
    .muted {{ color: var(--muted); }}

    .group-header {{ display: flex; align-items: center; justify-content: space-between; gap: 8px; }}
    .group-toggle {{ background: none; border: none; color: var(--text); cursor: pointer; font-size: 12px; padding: 0; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; }}
    .group-toggle.expanded {{ transform: rotate(90deg); }}
    .group-children {{ display: none; margin-left: 12px; margin-top: 4px; gap: 4px; }}
    .group-children.expanded {{ display: grid; }}
    .child-item {{ background: #0f1821; border: 1px solid var(--line); color: var(--text); border-radius: 8px; padding: 8px; cursor: pointer; font-size: 12px; }}
    .child-item:hover, .child-item.active {{ border-color: var(--brand); }}

    @media (max-width: 980px) {{
      .app {{ grid-template-columns: 1fr; }}
      .nav {{ position: static; height: auto; }}
    }}
  </style>
</head>
<body>
  <div class=\"app\">
    <aside class=\"nav\">
      <div class=\"brand\">
        <h1>UX4G Components</h1>
      </div>
      <input id=\"search\" class=\"search\" placeholder=\"Search components\" />
      <div id=\"list\" class=\"list\"></div>
    </aside>

    <main class=\"main\">
      <section class=\"hero\">
        <h2 id=\"title\">Component Library</h2>
        <p id=\"subtitle\">Select a component from the left navigation.</p>
      </section>

      <section class=\"card\">
        <h3>Overview</h3>
        <p id=\"overview\" class=\"muted\"></p>
      </section>

      <section class=\"card\" id=\"detailsSection\">
        <h3 id=\"detailsHeading\">All Parameters</h3>
        <div id=\"detailsContent\"></div>
        <p class=\"muted\" id=\"source\"></p>
      </section>

      <section class=\"card\" style=\"margin-bottom:20px;\" id=\"usageSection\">
        <h3>How to Use</h3>
        <pre id=\"usage\"></pre>
        <button class=\"copy\" id=\"copyBtn\">Copy Code</button>
      </section>
    </main>
  </div>

  <script>
    const components = {payload};
    const quickGuide = {{
      isGuide: true,
      name: 'Quick Guide',
      category: 'Getting Started',
      file: '',
      overview:
        'Flutter package for the UX4G design system, with reusable foundations and UI components.',
      usage: `flutter pub add ux4g_flutter_design_system`,
      detailsHtml: `
        <h3 style="margin: 0 0 10px 0; color: var(--text);">Use this package as a library</h3>
        <hr style="border: 0; border-top: 1px solid var(--line); margin: 0 0 12px 0;" />
        
        <h4 style="margin: 14px 0 10px 0; color: var(--text);">Depend on it</h4>
        <p class="muted" style="margin: 0 0 10px 0;">Run this command:</p>
        <p class="muted" style="margin: 0 0 6px 0; font-weight: 600;">With Flutter:</p>
        <div style="position: relative; margin-bottom: 8px;">
          <pre>$ flutter pub add ux4g_flutter_design_system</pre>
          <button class="copy-btn" data-copy="$ flutter pub add ux4g_flutter_design_system">Copy</button>
        </div>
        <p class="muted" style="margin: 10px 0 6px 0;">This will add a line like this to your package's <code>pubspec.yaml</code> (and run an implicit <code>flutter pub get</code>):</p>
        <div style="position: relative; margin-bottom: 8px;">
          <pre>dependencies:
  ux4g_flutter_design_system: ^0.1.0</pre>
          <button class="copy-btn" data-copy="dependencies:
  ux4g_flutter_design_system: ^0.1.0">Copy</button>
        </div>
        <p class="muted" style="margin: 10px 0 0 0;">Alternatively, your editor might support <code>flutter pub get</code>. Check the docs for your editor to learn more.</p>
        
        <h4 style="margin: 20px 0 10px 0; color: var(--text);">Import it</h4>
        <p class="muted" style="margin: 0 0 10px 0;">Now in your Dart code, you can use:</p>
        <div style="position: relative;">
          <pre>import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';</pre>
          <button class="copy-btn" data-copy="import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';">Copy</button>
        </div>
      `,
      parameters: [],
    }};

    const themeDoc = {{
      isGuide: true,
      name: 'Theme',
      category: 'Utilities',
      file: '',
      overview: 'Access theme colors and typography from your widgets using Ux4gTheme.',
      usage: `import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';`,
      detailsHtml: `
        <h3 style="margin: 0 0 10px 0; color: var(--text);">Theme (Colors & Typography)</h3>
        <hr style="border: 0; border-top: 1px solid var(--line); margin: 0 0 12px 0;" />
        <p class="muted" style="margin: 0 0 10px 0;">Access theme colors and typography from your widgets using <code>Ux4gTheme</code>:</p>
        <pre>import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

@override
Widget build(BuildContext context) {{
  final colors = Ux4gTheme.colors(context);
  final typography = Ux4gTheme.typography(context);

  return Container(
    color: colors.surface,
    child: Text(
      'Welcome',
      style: typography.headingXL_default.copyWith(
        color: colors.primary,
      ),
    ),
  );
}}</pre>
        <p class="muted" style="margin: 12px 0 0 0;"><strong>Available in Theme:</strong></p>
        <ul class="muted" style="margin: 6px 0 0 0; padding-left: 20px; line-height: 1.6;">
          <li>Colors: primary, secondary, error, surface, background, onSurface, etc.</li>
          <li>Typography: heading sizes (headingXL, headingL, etc.) and line heights (default, tight, loose)</li>
        </ul>
      `,
      parameters: [],
    }};

    const dimensionDoc = {{
      isGuide: true,
      name: 'Dimensions',
      category: 'Utilities',
      file: '',
      overview: 'Use predefined spacing and radii for consistent layouts.',
      usage: `import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';`,
      detailsHtml: `
        <h3 style="margin: 0 0 10px 0; color: var(--text);">Dimensions</h3>
        <hr style="border: 0; border-top: 1px solid var(--line); margin: 0 0 12px 0;" />
        <p class="muted" style="margin: 0 0 10px 0;">Use predefined spacing and radii for consistent layouts:</p>
        <pre>import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

widget = Padding(
  padding: EdgeInsets.all(Ux4gDimensions.spacing16),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Ux4gRadius.radius12),
      color: colors.surface,
      boxShadow: const [
        BoxShadow(
          blurRadius: Ux4gDimensions.shadow2,
          offset: Offset(0, Ux4gDimensions.spacing2),
        ),
      ],
    ),
    padding: EdgeInsets.symmetric(
      horizontal: Ux4gDimensions.spacing12,
      vertical: Ux4gDimensions.spacing8,
    ),
    child: Text('Card Content'),
  ),
);</pre>
        <p class="muted" style="margin: 12px 0 0 0;"><strong>Available Dimensions:</strong></p>
        <ul class="muted" style="margin: 6px 0 0 0; padding-left: 20px; line-height: 1.6;">
          <li><code>Spacing:</code> spacing2, spacing4, spacing8, spacing12, spacing16, spacing20, spacing24, spacing32, etc.</li>
          <li><code>Radii:</code> radius4, radius6, radius8, radius12, radius16, radius24, radius32, radiusCircle</li>
          <li><code>Shadow:</code> shadow1, shadow2, shadow4, shadow8, shadow16</li>
        </ul>
      `,
      parameters: [],
    }};

    const utilsGroup = {{
      isGroup: true,
      name: 'Utils',
      category: 'Utilities',
      children: [themeDoc, dimensionDoc],
    }};

    const componentsGroup = {{
      isGroup: true,
      name: 'Components',
      category: 'Components',
      children: [...components],
    }};

    const entries = [quickGuide, componentsGroup, utilsGroup];

    const listEl = document.getElementById('list');
    const searchEl = document.getElementById('search');
    const titleEl = document.getElementById('title');
    const subtitleEl = document.getElementById('subtitle');
    const overviewEl = document.getElementById('overview');
    const usageEl = document.getElementById('usage');
    const detailsHeadingEl = document.getElementById('detailsHeading');
    const detailsContentEl = document.getElementById('detailsContent');
    const detailsSectionEl = document.getElementById('detailsSection');
    const sourceEl = document.getElementById('source');
    const copyBtn = document.getElementById('copyBtn');

    function sortEntriesForNav(items) {{
      const list = [...items];
      list.sort((a, b) => {{
        const aQuick = a.name.toLowerCase() === 'quick guide';
        const bQuick = b.name.toLowerCase() === 'quick guide';
        if (aQuick && !bQuick) return -1;
        if (!aQuick && bQuick) return 1;

        if (a.isGroup && !b.isGroup) return 1;
        if (!a.isGroup && b.isGroup) return -1;
        return a.name.localeCompare(b.name);
      }});
      return list;
    }}

    let selectedIndex = 0;
    let filtered = sortEntriesForNav(entries);
    let expandedGroups = new Set();

    function row(p) {{
      const badge = p.required
        ? '<span class="badge req">Required</span>'
        : '<span class="badge opt">Optional</span>';
      return `<tr><td><code>${{p.name}}</code></td><td><code>${{p.type}}</code></td><td>${{badge}}</td><td><code>${{p.default}}</code></td></tr>`;
    }}

    function buildParamTable(params) {{
      const body = params.length
        ? params.map((p) => row(p)).join('')
        : '<tr><td colspan="4" class="muted">No constructor parameters detected.</td></tr>';
      return `<table><thead><tr><th>Name</th><th>Type</th><th>Required/Optional</th><th>Default</th></tr></thead><tbody>${{body}}</tbody></table>`;
    }}

    function normalizeCodeSnippet(raw) {{
      if (!raw) return '';
      let text = String(raw).replace(/\\r\\n/g, '\\n').replace(/\\t/g, '  ');
      let lines = text.split('\\n').map((l) => l.replace(/[ \\t]+$/g, ''));

      while (lines.length && lines[0].trim() === '') lines.shift();
      while (lines.length && lines[lines.length - 1].trim() === '') lines.pop();
      if (!lines.length) return '';

      const firstIndent = ((lines[0].match(/^ */) || [''])[0]).length;
      const restNonEmpty = lines.slice(1).filter((l) => l.trim() !== '');

      // If the first line starts at column 0 (for example "Ux4gButton("),
      // dedent continuation lines independently so deep source indentation
      // from example files does not leak into docs.
      if (firstIndent === 0 && restNonEmpty.length > 0) {{
        const restMinIndent = Math.min(...restNonEmpty.map((l) => (l.match(/^ */) || [''])[0].length));
        lines = [
          lines[0].trim(),
          ...lines.slice(1).map((l) => (l.trim() === '' ? '' : l.slice(restMinIndent))),
        ];
      }} else {{
        const nonEmpty = lines.filter((l) => l.trim() !== '');
        const minIndent = Math.min(...nonEmpty.map((l) => (l.match(/^ */) || [''])[0].length));
        lines = lines.map((l) => (l.trim() === '' ? '' : l.slice(minIndent)));
      }}

      // Keep closing paren aligned when snippet is a constructor call.
      if (lines.length >= 2 && lines[0].endsWith('(') && lines[lines.length - 1].trim() === ')') {{
        lines[lines.length - 1] = ')';
      }}

      return lines.join('\\n');
    }}

    function normalizeCodeBlocks(container) {{
      if (!container) return;
      container.querySelectorAll('pre').forEach((pre) => {{
        pre.textContent = normalizeCodeSnippet(pre.textContent || '');
      }});
    }}

    function jsSampleValue(type) {{
      const t = (type || '').replace('?', '').trim();
      if (t.includes('String')) return "'value'";
      if (t === 'bool') return 'false';
      if (t.includes('int')) return '0';
      if (t.includes('double')) return '0.0';
      if (t.includes('Color')) return 'Colors.blue';
      if (t.includes('IconData')) return 'Icons.star';
      if (t.includes('VoidCallback')) return '() {{}}';
      if (t.includes('ValueChanged')) return '(value) {{}}';
      if (t.includes('Widget')) return 'const SizedBox.shrink()';
      return '/* value */';
    }}

    function buildPresetSnippet(component, paramName, valueExpr) {{
      const required = (component.parameters || []).filter((p) => p.required);
      const lines = [`${{component.name}}(`];
      required.forEach((p) => {{
        if (p.name === paramName) {{
          lines.push(`  ${{p.name}}: ${{valueExpr}},`);
        }} else {{
          lines.push(`  ${{p.name}}: ${{jsSampleValue(p.type)}},`);
        }}
      }});

      if (!required.some((p) => p.name === paramName)) {{
        lines.push(`  ${{paramName}}: ${{valueExpr}},`);
      }}

      lines.push(')');
      return lines.join('\\n');
    }}

    function optionDisplayLabel(name) {{
      const lower = (name || '').toLowerCase();
      if (lower === 'outline') return 'Outlined';
      if (lower === 'primary') return 'Primary';
      if (lower === 'secondary') return 'Secondary';
      if (lower === 'ghost') return 'Ghost';
      return name ? name.charAt(0).toUpperCase() + name.slice(1) : '';
    }}

    function renderCustomizationItem(component, item) {{
      if (item.kind === 'enum') {{
        const options = (item.options || []).map((opt) => `<code>${{item.type}}.${{opt}}</code>`).join(', ');
        const def = item.default && item.default !== '-' ? `<span class="muted">Default: <code>${{item.default}}</code></span>` : '<span class="muted">Default: <code>-</code></span>';
        const presetRows = (item.options || []).map((opt) => {{
          const expr = `${{item.type}}.${{opt}}`;
          const snippet = buildPresetSnippet(component, item.param, expr);
          const label = optionDisplayLabel(opt);
          return `<div style="margin-top: 8px;"><span class="muted">${{label}}:</span><pre style="margin-top: 4px;">${{snippet}}</pre><button class="copy-inline">Copy</button></div>`;
        }}).join('');
        return `<li><strong><code>${{item.param}}</code></strong> supports: ${{options}}<br/>${{def}}${{presetRows}}</li>`;
      }}
      if (item.kind === 'bool') {{
        const def = item.default && item.default !== '-' ? item.default : '-';
        const trueSnippet = buildPresetSnippet(component, item.param, 'true');
        const falseSnippet = buildPresetSnippet(component, item.param, 'false');
        return `<li><strong><code>${{item.param}}</code></strong> toggle: <code>true</code> / <code>false</code> (default: <code>${{def}}</code>)
          <div style="margin-top: 8px;"><span class="muted">True:</span><pre style="margin-top: 4px;">${{trueSnippet}}</pre><button class="copy-inline">Copy</button></div>
          <div style="margin-top: 8px;"><span class="muted">False:</span><pre style="margin-top: 4px;">${{falseSnippet}}</pre><button class="copy-inline">Copy</button></div>
        </li>`;
      }}
      const typeText = item.type ? ` (<code>${{item.type}}</code>)` : '';
      const def = item.default && item.default !== '-' ? `, default: <code>${{item.default}}</code>` : '';
      return `<li><strong><code>${{item.param}}</code></strong>${{typeText}} can be overridden for visual customization${{def}}.</li>`;
    }}

    function buildCustomizationSection(component) {{
      const params = component.parameters || [];
      const customizations = component.customizations || [];

      if (component.name === 'Ux4gBadge') {{
        const dotSnippet = normalizeCodeSnippet(`
          // Dot badge on an icon
          Ux4gBadge.dot(
            child: Icon(Icons.notifications),
          )
        `);
        const countSnippet = normalizeCodeSnippet(`
          // Count badge — truncates at 9+ (singleDigit) or 99+ (doubleDigit)
          Ux4gBadge.count(
            5,
            child: Icon(Icons.mail),
            limit: Ux4gBadgeLimit.singleDigit,
          )
          // Over-limit example
          Ux4gBadge.count(
            120,
            child: Icon(Icons.shopping_cart),
            limit: Ux4gBadgeLimit.doubleDigit,
          )
        `);
        const labelSnippet = normalizeCodeSnippet(`
          // Label badge with custom text
          Ux4gBadge.label(
            'NEW',
            child: Icon(Icons.star),
            containerColor: Colors.green,
            contentColor: Colors.white,
          )
        `);
        const iconSnippet = normalizeCodeSnippet(`
          // Icon badge
          Ux4gBadge.icon(
            Icons.check,
            child: Icon(Icons.person),
            containerColor: Colors.blue,
            contentColor: Colors.white,
          )
        `);
        const readyToUseSnippet = normalizeCodeSnippet(`
          // Ready-to-use asset badge
          Ux4gBadge.readyToUse(
            'assets/icons/badge_verified.png',
            child: Icon(Icons.person),
            contentColor: Colors.amber,
          )
        `);
        const standAloneSnippet = normalizeCodeSnippet(`
          // Standalone (no child widget) — renders the badge by itself
          Ux4gBadge.dot()
          Ux4gBadge.count(7)
          Ux4gBadge.label('BETA')
        `);
        const colorSnippet = normalizeCodeSnippet(`
          // Custom colors
          Ux4gBadge.count(
            3,
            containerColor: Colors.red,
            contentColor: Colors.white,
            alignment: Alignment.topLeft,
            child: Icon(Icons.notifications),
          )
        `);
        return `
          <div style="margin-top: 14px;">
            <h4 style="margin: 0 0 8px 0; color: var(--text);">Customization Options</h4>
            <ul class="muted" style="margin: 0; padding-left: 18px; line-height: 1.7;">
              <li>
                <strong>1. Dot Badge</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Simple colored dot, no content</div>
                <pre style="margin-top: 4px;">${{dotSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>2. Count Badge</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Numeric count with overflow limit (singleDigit → 9+, doubleDigit → 99+)</div>
                <pre style="margin-top: 4px;">${{countSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>3. Label Badge</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Text label with custom colors</div>
                <pre style="margin-top: 4px;">${{labelSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>4. Icon Badge</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Small circular badge with an icon inside</div>
                <pre style="margin-top: 4px;">${{iconSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>5. Ready-to-use Asset Badge</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Render a custom image/icon asset as a badge</div>
                <pre style="margin-top: 4px;">${{readyToUseSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>6. Standalone (no child)</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Badge rendered alone without wrapping a widget</div>
                <pre style="margin-top: 4px;">${{standAloneSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
              <li>
                <strong>7. Custom colors &amp; alignment</strong>
                <div class="muted" style="font-size:12px;margin-bottom:4px;">Override containerColor, contentColor and alignment</div>
                <pre style="margin-top: 4px;">${{colorSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
            </ul>
          </div>
        `;
      }}

      if (params.length === 0 || customizations.length === 0) {{
        return '';
      }}

      if (component.name === 'Ux4gAvatar') {{
        const profileDefaultSnippet = normalizeCodeSnippet(`
          Ux4gAvatar(
            size: Ux4gAvatarSize.m,
          )
        `);
        const profileTextSnippet = normalizeCodeSnippet(`
          Ux4gAvatar(
            size: Ux4gAvatarSize.m,
            initials: 'AK',
            icon: null,
          )
        `);
        const profileImageTickSnippet = normalizeCodeSnippet(`
          Ux4gProfileAvatar(
            size: Ux4gAvatarSize.m,
            imageUrl: 'https://picsum.photos/120',
            variant: Ux4gProfileBadge.verified,
          )
        `);
        const groupSnippet = normalizeCodeSnippet(`
          Ux4gAvatarGroup(
            size: Ux4gAvatarSize.s,
            maxLimit: 4,
            collapsed: true,
            items: const [
              Ux4gAvatarGroupItem(initials: 'AK'),
              Ux4gAvatarGroupItem(initials: 'RS'),
              Ux4gAvatarGroupItem(initials: 'TP'),
              Ux4gAvatarGroupItem(initials: 'MN'),
              Ux4gAvatarGroupItem(initials: 'KD'),
            ],
          )
        `);
        const statusSnippet = normalizeCodeSnippet(`
          Row(
            children: const [
              Ux4gStatusAvatar(initials: 'AK', variant: Ux4gStatusVariant.online),
              SizedBox(width: 8),
              Ux4gStatusAvatar(initials: 'RS', variant: Ux4gStatusVariant.busy),
            ],
          )
        `);

        return `
          <div style="margin-top: 14px;" class="avatar-customization-container">
            <h4 style="margin: 0 0 8px 0; color: var(--text);">Customization Options</h4>
            <ul class="muted" style="margin: 0; padding-left: 18px; line-height: 1.7;">
              <li>
                <strong>1. Base Avatar (Ux4gAvatar)</strong>
                <pre style="margin-top: 8px;">${{profileDefaultSnippet}}</pre><button class="copy-inline">Copy</button>
                <div style="margin-top: 8px;">With text initials</div>
                <pre style="margin-top: 4px;">${{profileTextSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>

              <li>
                <strong>2. Profile Avatar (Ux4gProfileAvatar)</strong>
                <pre style="margin-top: 8px;">${{profileImageTickSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>

              <li>
                <strong>3. Avatar Group (Ux4gAvatarGroup)</strong>
                <pre style="margin-top: 8px;">${{groupSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>

              <li>
                <strong>4. Status Avatar (Ux4gStatusAvatar)</strong>
                <pre style="margin-top: 8px;">${{statusSnippet}}</pre><button class="copy-inline">Copy</button>
              </li>
            </ul>
          </div>
        `;
      }}

      if (component.name === 'Ux4gButton') {{
        const primarySnippet = normalizeCodeSnippet(`
          Ux4gButton(
            onPressed: () {{}},
            text: 'Primary Button',
            variant: Ux4gButtonVariant.primary,
          )
        `);
        const outlinedSnippet = normalizeCodeSnippet(`
          Ux4gButton(
            onPressed: () {{}},
            text: 'Outlined Button',
            variant: Ux4gButtonVariant.outline,
          )
        `);
        const customSnippet = normalizeCodeSnippet(`
          Ux4gButton(
            onPressed: () {{}},
            text: 'Custom Button',
            backgroundColor: Colors.deepPurple,
            borderRadius: BorderRadius.circular(16),
          )
        `);

        return `
          <div style="margin-top: 14px;" class="button-customization-container">
            <h4 style="margin: 0 0 8px 0; color: var(--text);">Customization Options</h4>
            <button class="preview-toggle">Hide Preview</button>
            <ul class="muted" style="margin: 0; padding-left: 18px; line-height: 1.7;">
              <li>
                <strong>Primary</strong>
                <div class="preview-row"><span class="preview-label">Preview</span><button class="preview-btn primary">Primary Button</button></div>
                <div style="margin-top: 8px;"><pre style="margin-top: 4px;">${{primarySnippet}}</pre><button class="copy-inline">Copy</button></div>
              </li>
              <li>
                <strong>Outlined</strong>
                <div class="preview-row"><span class="preview-label">Preview</span><button class="preview-btn outlined">Outlined Button</button></div>
                <div style="margin-top: 8px;"><pre style="margin-top: 4px;">${{outlinedSnippet}}</pre><button class="copy-inline">Copy</button></div>
              </li>
              <li>
                <strong>Custom (Border Radius + Color)</strong>
                <div class="preview-row"><span class="preview-label">Preview</span><button class="preview-btn custom">Custom Button</button></div>
                <div style="margin-top: 8px;"><pre style="margin-top: 4px;">${{customSnippet}}</pre><button class="copy-inline">Copy</button></div>
              </li>
            </ul>
          </div>
        `;
      }}

      const items = customizations.map((item) => renderCustomizationItem(component, item)).join('');
      return `
        <div style="margin-top: 14px;">
          <h4 style="margin: 0 0 8px 0; color: var(--text);">Customization Options</h4>
          <ul class="muted" style="margin: 0; padding-left: 18px; line-height: 1.7;">${{items}}</ul>
        </div>
      `;
    }}

    function renderList() {{
      listEl.innerHTML = '';
      filtered.forEach((c, i) => {{
        if (c.isGroup) {{
          // Render group header
          const groupDiv = document.createElement('div');
          groupDiv.style.marginBottom = '4px';

          const toggleGroup = () => {{
            if (expandedGroups.has(i)) {{
              expandedGroups.delete(i);
            }} else {{
              expandedGroups.add(i);
            }}
            renderList();
          }};
          
          const groupBtn = document.createElement('button');
          groupBtn.className = 'item';
          groupBtn.style.display = 'flex';
          groupBtn.style.alignItems = 'center';
          groupBtn.style.gap = '8px';
          groupBtn.addEventListener('click', toggleGroup);
          
          const toggle = document.createElement('button');
          toggle.className = 'group-toggle' + (expandedGroups.has(i) ? ' expanded' : '');
          toggle.innerHTML = '▶';
          toggle.addEventListener('click', (e) => {{
            e.stopPropagation();
            toggleGroup();
          }});
          
          const label = document.createElement('span');
          label.innerHTML = `<span class="n">${{c.name}}</span><span class="m">${{c.category}}</span>`;
          
          groupBtn.appendChild(toggle);
          groupBtn.appendChild(label);
          groupDiv.appendChild(groupBtn);
          
          // Render children if expanded
          if (expandedGroups.has(i)) {{
            const childContainer = document.createElement('div');
            childContainer.className = 'group-children expanded';
            
            c.children.forEach((child, childIdx) => {{
              if (child.isGroup) {{
                // Nested group
                const nestedKey = `${{i}}-${{childIdx}}`;
                const nestedGroupDiv = document.createElement('div');
                nestedGroupDiv.style.marginBottom = '4px';
                nestedGroupDiv.style.marginLeft = '16px';
                
                const toggleNestedGroup = () => {{
                  if (expandedGroups.has(nestedKey)) {{
                    expandedGroups.delete(nestedKey);
                  }} else {{
                    expandedGroups.add(nestedKey);
                  }}
                  renderList();
                }};
                
                const nestedGroupBtn = document.createElement('button');
                nestedGroupBtn.className = 'item';
                nestedGroupBtn.style.display = 'flex';
                nestedGroupBtn.style.alignItems = 'center';
                nestedGroupBtn.style.gap = '8px';
                nestedGroupBtn.addEventListener('click', toggleNestedGroup);
                
                const nestedToggle = document.createElement('button');
                nestedToggle.className = 'group-toggle' + (expandedGroups.has(nestedKey) ? ' expanded' : '');
                nestedToggle.innerHTML = '▶';
                nestedToggle.addEventListener('click', (e) => {{
                  e.stopPropagation();
                  toggleNestedGroup();
                }});
                
                const nestedLabel = document.createElement('span');
                nestedLabel.innerHTML = `<span class="n">${{child.name}}</span><span class="m">${{child.category}}</span>`;
                
                nestedGroupBtn.appendChild(nestedToggle);
                nestedGroupBtn.appendChild(nestedLabel);
                nestedGroupDiv.appendChild(nestedGroupBtn);
                
                // Render nested group's children if expanded
                if (expandedGroups.has(nestedKey)) {{
                  const nestedChildContainer = document.createElement('div');
                  nestedChildContainer.className = 'group-children expanded';
                  nestedChildContainer.style.marginLeft = '16px';
                  
                  child.children.forEach((grandchild, grandchildIdx) => {{
                    const grandchildBtn = document.createElement('button');
                    grandchildBtn.className = 'child-item' + (selectedIndex === `${{i}}-${{childIdx}}-${{grandchildIdx}}` ? ' active' : '');
                    grandchildBtn.innerHTML = `<span style="font-weight: 600;">${{grandchild.name}}</span>`;
                    grandchildBtn.addEventListener('click', () => {{
                      selectedIndex = `${{i}}-${{childIdx}}-${{grandchildIdx}}`;
                      renderDetail();
                    }});
                    nestedChildContainer.appendChild(grandchildBtn);
                  }});
                  
                  nestedGroupDiv.appendChild(nestedChildContainer);
                }}
                
                childContainer.appendChild(nestedGroupDiv);
              }} else {{
                // Regular child item
                const childBtn = document.createElement('button');
                childBtn.className = 'child-item' + (selectedIndex === `${{i}}-${{childIdx}}` ? ' active' : '');
                childBtn.innerHTML = `<span style="font-weight: 600;">${{child.name}}</span>`;
                childBtn.addEventListener('click', () => {{
                  selectedIndex = `${{i}}-${{childIdx}}`;
                  renderDetail();
                }});
                childContainer.appendChild(childBtn);
              }}
            }});
            
            groupDiv.appendChild(childContainer);
          }}
          
          listEl.appendChild(groupDiv);
        }} else {{
          // Regular item
          const btn = document.createElement('button');
          btn.className = 'item' + (i === selectedIndex ? ' active' : '');
          btn.innerHTML = `<span class="n">${{c.name}}</span><span class="m">${{c.category}}</span>`;
          btn.addEventListener('click', () => {{
            selectedIndex = i;
            renderList();
            renderDetail();
          }});
          listEl.appendChild(btn);
        }}
      }});
    }}

    function renderDetail() {{
      let c = null;
      let groupIdxForToggle = null;
      
      if (typeof selectedIndex === 'string') {{
        const parts = selectedIndex.split('-').map(Number);
        if (parts.length === 2) {{
          // Format: groupIdx-childIdx
          const [groupIdx, childIdx] = parts;
          c = filtered[groupIdx].children[childIdx];
          groupIdxForToggle = selectedIndex;
        }} else if (parts.length === 3) {{
          // Format: groupIdx-nestedGroupIdx-grandchildIdx
          const [groupIdx, nestedGroupIdx, grandchildIdx] = parts;
          c = filtered[groupIdx].children[nestedGroupIdx].children[grandchildIdx];
        }}
      }} else {{
        c = filtered[selectedIndex];
      }}
      
      if (!c) return;
      
      // Handle nested group toggle
      if (c.isGroup && groupIdxForToggle) {{
        if (expandedGroups.has(groupIdxForToggle)) {{
          expandedGroups.delete(groupIdxForToggle);
        }} else {{
          expandedGroups.add(groupIdxForToggle);
        }}
        renderList();
        return;
      }}

      titleEl.textContent = c.name;
      subtitleEl.textContent = `${{c.category}} documentation`;
      overviewEl.textContent = c.overview || '';
      usageEl.textContent = c.usage || '';

      if (c.isGuide) {{
        detailsSectionEl.style.display = 'block';
        detailsHeadingEl.textContent = 'Guide Details';
        detailsContentEl.innerHTML = c.detailsHtml;
        normalizeCodeBlocks(detailsContentEl);
        sourceEl.textContent = '';
        document.getElementById('usageSection').style.display = 'none';
      }} else {{
        const hasParams = (c.parameters || []).length > 0;
        const customHtml = buildCustomizationSection(c);
        const isBadgeOnly = !hasParams && customHtml;
        detailsSectionEl.style.display = (hasParams || customHtml) ? 'block' : 'none';
        detailsHeadingEl.textContent = 'All Parameters';
        detailsHeadingEl.style.display = isBadgeOnly ? 'none' : '';
        detailsContentEl.innerHTML =
          (isBadgeOnly ? '' : buildParamTable(c.parameters || [])) +
          customHtml;
        normalizeCodeBlocks(detailsContentEl);
        sourceEl.textContent = `Source: ${{c.file}}`;
        document.getElementById('usageSection').style.display = isBadgeOnly ? 'none' : 'block';
      }}

      usageEl.textContent = normalizeCodeSnippet(c.usage || '');
    }}

    function applySearch() {{
      const q = searchEl.value.trim().toLowerCase();
      if (q === '') {{
        filtered = sortEntriesForNav(entries);
        expandedGroups.clear();
      }} else {{
        filtered = sortEntriesForNav(entries.map((c) => {{
          if (c.isGroup) {{
            // Check if the group itself matches
            const groupMatches = c.name.toLowerCase().includes(q) || c.category.toLowerCase().includes(q);
            
            // Filter children that match
            const matchingChildren = c.children.filter(child =>
              child.name.toLowerCase().includes(q) || 
              child.category.toLowerCase().includes(q) ||
              (child.file || '').toLowerCase().includes(q)
            );
            
            // If group matches OR has matching children, include it
            if (groupMatches || matchingChildren.length > 0) {{
              if (groupMatches) {{
                // Group name matches, show all children
                return c;
              }} else {{
                // Only some children match, return filtered group
                return {{ ...c, children: matchingChildren }};
              }}
            }}
            return null;
          }}
          // Regular item
          if (c.name.toLowerCase().includes(q) || c.category.toLowerCase().includes(q) || (c.file || '').toLowerCase().includes(q)) {{
            return c;
          }}
          return null;
        }}).filter(item => item !== null));
        
        // Auto-expand groups that have matching items
        filtered.forEach((c, i) => {{
          if (c.isGroup && c.children && c.children.length > 0) {{
            expandedGroups.add(i);
          }}
        }});
      }}
      selectedIndex = 0;
      renderList();
      renderDetail();
    }}

    copyBtn.addEventListener('click', async () => {{
      const original = copyBtn.textContent;
      try {{
        await navigator.clipboard.writeText(usageEl.textContent || '');
        copyBtn.textContent = 'Copied!';
      }} catch (_) {{
        copyBtn.textContent = 'Copy failed';
      }}
      setTimeout(() => (copyBtn.textContent = original), 1300);
    }});

    // Add copy button handlers for code blocks in details
    document.addEventListener('click', async (e) => {{
      if (e.target.classList.contains('copy-btn')) {{
        const btn = e.target;
        const text = btn.getAttribute('data-copy');
        const original = btn.textContent;
        try {{
          await navigator.clipboard.writeText(text);
          btn.textContent = 'Copied!';
          btn.classList.add('copied');
        }} catch (_) {{
          btn.textContent = 'Failed!';
        }}
        setTimeout(() => {{
          btn.textContent = original;
          btn.classList.remove('copied');
        }}, 1300);
      }}

      if (e.target.classList.contains('copy-inline')) {{
        const btn = e.target;
        const wrapper = btn.closest('div');
        const pre = wrapper ? wrapper.querySelector('pre') : null;
        const text = pre ? pre.textContent : '';
        const original = btn.textContent;
        try {{
          await navigator.clipboard.writeText(text || '');
          btn.textContent = 'Copied!';
          btn.classList.add('copied');
        }} catch (_) {{
          btn.textContent = 'Failed!';
        }}
        setTimeout(() => {{
          btn.textContent = original;
          btn.classList.remove('copied');
        }}, 1300);
      }}

      if (e.target.classList.contains('preview-toggle')) {{
        const btn = e.target;
        const container = btn.closest('.button-customization-container, .avatar-customization-container');
        if (!container) return;
        const previews = container.querySelectorAll('.preview-row');
        const shouldShow = btn.textContent.trim() === 'Show Preview';
        previews.forEach(p => p.style.display = shouldShow ? '' : 'none');
        btn.textContent = shouldShow ? 'Hide Preview' : 'Show Preview';
      }}
    }});

    searchEl.addEventListener('input', applySearch);
    renderList();
    renderDetail();
  </script>
</body>
</html>
"""


def main() -> None:
    components = build_components()
    OUTPUT_FILE.write_text(build_html(components), encoding="utf-8")
    print(f"Generated: {OUTPUT_FILE}")
    print(f"Components: {len(components)}")


if __name__ == "__main__":
    main()
