#!/usr/bin/env python3
"""Generate Storybook-style component documentation for UX4G Flutter package.

This script scans lib/src/components and creates a static HTML documentation page
with quick-start guidance, component catalog, and parameter tables.
"""

from __future__ import annotations

import datetime
import html
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
COMPONENTS_DIR = ROOT / "lib" / "src" / "components"
BARREL_FILE = ROOT / "lib" / "ux4g_flutter_design_system.dart"
OUTPUT_FILE = ROOT / "docs" / "storybook-style-components.html"
EXPORT_RE = re.compile(r"export\s+'src/components/(?P<path>[^']+)'\s*;")

CLASS_RE = re.compile(r"class\s+([A-Z][A-Za-z0-9_]*)\b")
CLASS_DECL_RE = re.compile(
  r"class\s+(?P<name>[A-Z][A-Za-z0-9_]*)\s*(?:extends\s+(?P<extends>[A-Za-z0-9_<>]+))?",
  re.DOTALL,
)
CTOR_RE_TEMPLATE = r"{name}\s*\(\s*\{{(?P<params>.*?)\}}\s*\)"
PARAM_RE = re.compile(
    r"(?P<required>required\s+)?"
    r"(?P<type>[A-Za-z_][A-Za-z0-9_<>,?.\s\[\]]*?)\s+"
    r"(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
    r"\s*(?:=\s*(?P<default>[^,]+))?\s*(?:,|$)",
    re.DOTALL,
)

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


def infer_category(file_name: str, class_name: str) -> str:
    token = f"{file_name.lower()} {class_name.lower()}"
    for key, value in CATEGORY_RULES:
        if key in token:
            return value
    return "Components"


def clean_spaces(text: str) -> str:
    return " ".join(text.replace("\n", " ").split())


def parse_component_file(path: Path) -> list[dict]:
    source = path.read_text(encoding="utf-8")
    classes = CLASS_RE.findall(source)
    widget_classes = set()
    for m in CLASS_DECL_RE.finditer(source):
        ext = (m.group("extends") or "").strip()
        if ext in {"StatelessWidget", "StatefulWidget"}:
            widget_classes.add(m.group("name"))

    components: list[dict] = []

    for cls in sorted(set(classes)):
        if cls not in widget_classes:
            continue

        ctor_re = re.compile(CTOR_RE_TEMPLATE.format(name=re.escape(cls)), re.DOTALL)
        ctor_match = ctor_re.search(source)
        params_block = ctor_match.group("params") if ctor_match else ""

        params = []
        for match in PARAM_RE.finditer(params_block):
            raw_type = clean_spaces(match.group("type"))
            raw_name = match.group("name")
            raw_default = match.group("default")
            params.append(
                {
                    "name": raw_name,
                    "type": raw_type,
                    "required": bool(match.group("required")),
                    "default": clean_spaces(raw_default) if raw_default else "-",
                }
            )

        required_count = len([p for p in params if p["required"]])
        optional_count = len(params) - required_count

        components.append(
            {
                "name": cls,
                "file": path.relative_to(ROOT).as_posix(),
                "category": infer_category(path.name, cls),
                "parameters": params,
                "required_count": required_count,
                "optional_count": optional_count,
            }
        )

    return components


def scan_components() -> list[dict]:
    all_components: list[dict] = []
    barrel_src = BARREL_FILE.read_text(encoding="utf-8")
    exported_paths = [
        COMPONENTS_DIR / m.group("path")
        for m in EXPORT_RE.finditer(barrel_src)
    ]

    for path in sorted(exported_paths):
        if not path.exists():
            continue
        all_components.extend(parse_component_file(path))

    # Keep only unique class names in case of duplicates.
    dedup = {}
    for comp in all_components:
        dedup[comp["name"]] = comp

    return sorted(dedup.values(), key=lambda c: c["name"].lower())


def esc(value: str) -> str:
    return html.escape(value, quote=True)


def build_html(components: list[dict]) -> str:
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")

    toc_links = "\n".join(
        (
            f'<a class="toc-link" href="#{esc(c["name"])}">'
            f'<span class="toc-title">{esc(c["name"])}</span>'
            f'<span class="toc-meta">{c["required_count"]} required / {c["optional_count"]} optional</span>'
            "</a>"
        )
        for c in components
    )

    cards = []
    for c in components:
        if c["parameters"]:
            rows = []
            for p in c["parameters"]:
                badge = (
                    '<span class="badge req">Required</span>'
                    if p["required"]
                    else '<span class="badge opt">Optional</span>'
                )
                rows.append(
                    "<tr>"
                    f"<td><code>{esc(p['name'])}</code></td>"
                    f"<td><code>{esc(p['type'])}</code></td>"
                    f"<td>{badge}</td>"
                    f"<td><code>{esc(p['default'])}</code></td>"
                    "</tr>"
                )
            table = (
                "<table><thead><tr><th>Parameter</th><th>Type</th><th>Required</th><th>Default</th></tr></thead>"
                f"<tbody>{''.join(rows)}</tbody></table>"
            )
        else:
            table = '<p class="empty">No named constructor parameters detected automatically.</p>'

        cards.append(
            f"""
<section class="component" id="{esc(c['name'])}">
  <div class="component-head">
    <h3>{esc(c['name'])}</h3>
    <div class="pills">
      <span class="pill">{esc(c['category'])}</span>
      <span class="pill">{c['required_count']} required</span>
      <span class="pill">{c['optional_count']} optional</span>
    </div>
  </div>
  <p class="source">Source: <a href="../{esc(c['file'])}">{esc(c['file'])}</a></p>
  {table}
</section>
"""
        )

    return f"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>UX4G Flutter Component Documentation</title>
  <style>
    :root {{
      --bg: #0e141b;
      --panel: #141d26;
      --panel-2: #1a2631;
      --text: #e7eff7;
      --muted: #9eb3c7;
      --accent: #54b7ff;
      --border: #2a3a4a;
      --req: #ff6b6b;
      --opt: #72d28c;
    }}
    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      font-family: "Segoe UI", "Noto Sans", sans-serif;
      color: var(--text);
      background:
        radial-gradient(1200px 600px at 100% -10%, #1a3857 0, transparent 60%),
        radial-gradient(900px 500px at -10% 20%, #0f2f45 0, transparent 55%),
        var(--bg);
    }}
    .layout {{ display: grid; grid-template-columns: 320px 1fr; min-height: 100vh; }}
    .sidebar {{ border-right: 1px solid var(--border); background: rgba(20, 29, 38, 0.9); padding: 20px; position: sticky; top: 0; height: 100vh; overflow: auto; }}
    .brand h1 {{ margin: 0 0 6px; font-size: 20px; }}
    .brand p {{ margin: 0; color: var(--muted); font-size: 13px; }}
    .toc {{ margin-top: 18px; display: grid; gap: 8px; }}
    .toc-link {{ display: block; padding: 10px; border: 1px solid var(--border); border-radius: 10px; color: inherit; text-decoration: none; background: linear-gradient(180deg, rgba(84,183,255,0.08), rgba(84,183,255,0.01)); }}
    .toc-link:hover {{ border-color: var(--accent); }}
    .toc-title {{ display: block; font-size: 13px; font-weight: 600; }}
    .toc-meta {{ display: block; font-size: 11px; color: var(--muted); margin-top: 2px; }}
    .content {{ padding: 28px; max-width: 1100px; }}
    .hero {{ background: linear-gradient(180deg, rgba(84,183,255,0.14), rgba(84,183,255,0.04)); border: 1px solid var(--border); border-radius: 16px; padding: 22px; }}
    .hero h2 {{ margin-top: 0; font-size: 30px; }}
    .hero p {{ color: var(--muted); }}
    .grid-2 {{ display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-top: 16px; }}
    .panel {{ background: var(--panel); border: 1px solid var(--border); border-radius: 12px; padding: 16px; }}
    .panel h3 {{ margin-top: 0; font-size: 16px; color: var(--accent); }}
    pre {{ margin: 0; white-space: pre-wrap; font-size: 12px; background: #0f1720; border: 1px solid var(--border); border-radius: 10px; padding: 12px; }}
    code {{ color: #bce3ff; }}
    .section-title {{ margin: 30px 0 14px; font-size: 22px; }}
    .component {{ margin-bottom: 18px; background: var(--panel); border: 1px solid var(--border); border-radius: 14px; padding: 16px; }}
    .component-head {{ display: flex; gap: 12px; justify-content: space-between; align-items: center; flex-wrap: wrap; }}
    .component-head h3 {{ margin: 0; font-size: 20px; }}
    .source {{ font-size: 12px; color: var(--muted); }}
    .source a {{ color: var(--accent); }}
    .pills {{ display: flex; gap: 8px; flex-wrap: wrap; }}
    .pill {{ font-size: 11px; border: 1px solid var(--border); border-radius: 999px; padding: 3px 9px; color: var(--muted); }}
    table {{ width: 100%; border-collapse: collapse; margin-top: 10px; }}
    th, td {{ padding: 9px; border-bottom: 1px solid var(--border); font-size: 13px; text-align: left; vertical-align: top; }}
    th {{ color: var(--accent); font-weight: 600; }}
    .badge {{ display: inline-block; padding: 3px 8px; border-radius: 999px; font-size: 11px; font-weight: 700; }}
    .badge.req {{ color: #fff; background: var(--req); }}
    .badge.opt {{ color: #102016; background: var(--opt); }}
    .empty {{ color: var(--muted); font-size: 13px; }}
    .footer {{ margin-top: 32px; color: var(--muted); font-size: 12px; }}
    @media (max-width: 980px) {{
      .layout {{ grid-template-columns: 1fr; }}
      .sidebar {{ position: static; height: auto; }}
      .grid-2 {{ grid-template-columns: 1fr; }}
    }}
  </style>
</head>
<body>
  <div class="layout">
    <aside class="sidebar">
      <div class="brand">
        <h1>UX4G Flutter Docs</h1>
        <p>Storybook-style component reference</p>
      </div>
      <nav class="toc">
        <a class="toc-link" href="#quick-start"><span class="toc-title">Quick Start</span><span class="toc-meta">Install and use package</span></a>
        <a class="toc-link" href="#components"><span class="toc-title">Components</span><span class="toc-meta">{len(components)} detected</span></a>
        {toc_links}
      </nav>
    </aside>
    <main class="content">
      <section class="hero" id="quick-start">
        <h2>Quick Start Guide</h2>
        <p>Integrate UX4G Flutter components quickly with the same structure as your UX4G Storybook docs: setup, what is included, and component API details.</p>
        <div class="grid-2">
          <article class="panel">
            <h3>Install via pubspec</h3>
            <pre><code>dependencies:
  ux4g_flutter_design_system:
    path: ../ux4g-flutter-design-system</code></pre>
          </article>
          <article class="panel">
            <h3>Wrap app with theme</h3>
            <pre><code>MaterialApp(
  theme: Ux4gTheme.themeData(isDark: false),
  darkTheme: Ux4gTheme.themeData(isDark: true),
)</code></pre>
          </article>
        </div>
        <div class="grid-2">
          <article class="panel">
            <h3>Example usage</h3>
            <pre><code>Ux4gButton(
  onPressed: () {{}},
  text: 'Get Started',
)</code></pre>
          </article>
          <article class="panel">
            <h3>What is included</h3>
            <ul>
              <li>Foundations: colors, typography, spacing, icons</li>
              <li>Components: forms, feedback, navigation, data display</li>
              <li>Biometric flow and helper utilities</li>
            </ul>
          </article>
        </div>
      </section>

      <h2 class="section-title" id="components">Components</h2>
      {''.join(cards)}

      <p class="footer">Generated on {esc(ts)} from source files under lib/src/components.</p>
    </main>
  </div>
</body>
</html>
"""


def main() -> None:
    components = scan_components()
    OUTPUT_FILE.write_text(build_html(components), encoding="utf-8")
    print(f"Generated: {OUTPUT_FILE}")
    print(f"Components: {len(components)}")


if __name__ == "__main__":
    main()
