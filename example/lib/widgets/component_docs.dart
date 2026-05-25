import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A styled showcase wrapper used in every Widgetbook use-case.
///
/// Shows:
///  • Component name + badge chip
///  • Description paragraph
///  • "Preview" tab – the live widget
///  • "Code" tab   – a syntax-highlighted snippet with a copy button
///  • Optional "Props" list
class ComponentDocs extends StatefulWidget {
  const ComponentDocs({
    super.key,
    required this.name,
    required this.description,
    required this.child,
    this.code,
    this.props = const [],
    this.center = true,
  });

  final String name;
  final String description;
  final Widget child;
  final String? code;
  final List<PropRow> props;
  final bool center;

  @override
  State<ComponentDocs> createState() => _ComponentDocsState();
}

class _ComponentDocsState extends State<ComponentDocs>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _tab = TabController(
      length: _getTabCount(),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant ComponentDocs oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newCount = _getTabCount();
    if (_tab.length != newCount) {
      _tab.dispose();
      _tab = TabController(length: newCount, vsync: this);
    }
  }

  int _getTabCount() {
    int count = 1; // Preview always exists
    if (widget.code != null) count++;
    if (widget.props.isNotEmpty) count++;
    return count;
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _copy() async {
    if (widget.code == null) return;
    await Clipboard.setData(ClipboardData(text: widget.code!));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final tabs = [
      const Tab(icon: Icon(Icons.visibility_outlined, size: 16), text: 'Preview'),
      if (widget.code != null)
        const Tab(icon: Icon(Icons.code_outlined, size: 16), text: 'Code'),
      if (widget.props.isNotEmpty)
        const Tab(icon: Icon(Icons.tune_outlined, size: 16), text: 'Props'),
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1117) : const Color(0xFFF8F9FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 10),
                          _Chip(label: 'Component', color: scheme.primary),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.description,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? Colors.white60
                              : const Color(0xFF475569),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Tab bar + content ─────────────────────────────────────────
            _Card(
              isDark: isDark,
              child: Column(
                children: [
                  // Tab bar
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E2130)
                          : const Color(0xFFEEF2F7),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            controller: _tab,
                            tabs: tabs,
                            labelColor: scheme.primary,
                            unselectedLabelColor:
                                isDark ? Colors.white38 : Colors.black38,
                            labelStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                            unselectedLabelStyle:
                                const TextStyle(fontSize: 13),
                            indicator: UnderlineTabIndicator(
                              borderSide:
                                  BorderSide(color: scheme.primary, width: 2.5),
                            ),
                            indicatorSize: TabBarIndicatorSize.label,
                            dividerColor: Colors.transparent,
                          ),
                        ),
                        if (widget.code != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _copied
                                  ? Row(
                                      key: const ValueKey('copied'),
                                      children: [
                                        Icon(Icons.check_circle,
                                            size: 16,
                                            color: Colors.green.shade400),
                                        const SizedBox(width: 4),
                                        Text('Copied!',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green.shade400,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                  : TextButton.icon(
                                      key: const ValueKey('copy'),
                                      onPressed: _copy,
                                      icon: const Icon(Icons.copy_outlined,
                                          size: 14),
                                      label: const Text('Copy',
                                          style: TextStyle(fontSize: 12)),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Tab views
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      controller: _tab,
                      children: [
                        // ── Preview ─────────────────────────────────────
                        _PreviewPane(child: widget.child, center: widget.center, isDark: isDark),

                        // ── Code ────────────────────────────────────────
                        if (widget.code != null)
                          _CodePane(code: widget.code!, isDark: isDark),

                        // ── Props ────────────────────────────────────────
                        if (widget.props.isNotEmpty)
                          _PropsPane(props: widget.props, isDark: isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Preview pane ──────────────────────────────────────────────────────────────

class _PreviewPane extends StatelessWidget {
  const _PreviewPane({required this.child, required this.center, required this.isDark});
  final Widget child;
  final bool center;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161925) : const Color(0xFFF1F5F9),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: center ? Center(child: child) : child,
      ),
    );
  }
}

// ── Code pane ─────────────────────────────────────────────────────────────────

class _CodePane extends StatelessWidget {
  const _CodePane({required this.code, required this.isDark});
  final String code;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D1117) : const Color(0xFF1E2130),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SelectableText(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Color(0xFFE2E8F0),
            height: 1.65,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ── Props pane ────────────────────────────────────────────────────────────────

class PropRow {
  const PropRow({
    required this.name,
    required this.type,
    required this.description,
    this.defaultValue = '—',
    this.required = false,
  });
  final String name;
  final String type;
  final String description;
  final String defaultValue;
  final bool required;
}

class _PropsPane extends StatelessWidget {
  const _PropsPane({required this.props, required this.isDark});
  final List<PropRow> props;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF161925) : Colors.white;
    final headerBg = isDark ? const Color(0xFF1E2130) : const Color(0xFFF1F5F9);
    final border = isDark ? const Color(0xFF2D3348) : const Color(0xFFE2E8F0);
    final textColor = isDark ? Colors.white70 : const Color(0xFF334155);
    final monoColor = isDark ? const Color(0xFF7DD3FC) : const Color(0xFF0369A1);
    final requiredColor = const Color(0xFFF87171);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 600),
            child: Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: border, width: 0.5),
                bottom: BorderSide(color: border, width: 0.5),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2.5),
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(4.5),
                3: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: headerBg),
                  children: ['Prop', 'Type', 'Description', 'Default']
                      .map((h) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            child: Text(h,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: textColor)),
                          ))
                      .toList(),
                ),
                ...props.map((p) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: p.name,
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: monoColor),
                                ),
                                if (p.required)
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: requiredColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text(p.type,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: isDark
                                      ? const Color(0xFF86EFAC)
                                      : const Color(0xFF15803D))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text(p.description,
                              style: TextStyle(fontSize: 12, color: textColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Text(p.defaultValue,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color:
                                      isDark ? Colors.white38 : Colors.black38)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Card container ─────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  const _Card({required this.child, required this.isDark});
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161925) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? const Color(0xFF2D3348)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

// ── Chip badge ─────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
