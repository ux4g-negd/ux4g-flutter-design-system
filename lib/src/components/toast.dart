import 'dart:async';
import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';

enum Ux4gToastCategory { info, success, warning, error, slot }

enum Ux4gToastLayout { full, stacked }

class Ux4gToastData {
  final Ux4gToastCategory category;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionClick;
  final bool showCloseButton;

  const Ux4gToastData({
    required this.category,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionClick,
    this.showCloseButton = true,
  });
}

class Ux4gToastHostState extends ChangeNotifier {
  Ux4gToastData? _currentToast;
  Ux4gToastData? get currentToast => _currentToast;

  Timer? _timer;

  void showToast({
    required Ux4gToastCategory category,
    required String title,
    String? subtitle,
    String? actionText,
    VoidCallback? onActionClick,
    bool showCloseButton = true,
    bool autoClose = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    _timer?.cancel();
    _currentToast = Ux4gToastData(
      category: category,
      title: title,
      subtitle: subtitle,
      actionText: actionText,
      onActionClick: onActionClick,
      showCloseButton: showCloseButton,
    );
    notifyListeners();

    if (autoClose) {
      _timer = Timer(duration, () {
        dismiss();
      });
    }
  }

  void dismiss() {
    _timer?.cancel();
    _currentToast = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class Ux4gToast extends StatelessWidget {
  final Ux4gToastCategory category;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionClick;
  final VoidCallback? onCloseClick;
  final bool showCloseButton;
  final Ux4gToastLayout? layout;

  const Ux4gToast({
    super.key,
    required this.category,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionClick,
    this.onCloseClick,
    this.showCloseButton = true,
    this.layout,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();

    final screenWidth = MediaQuery.of(context).size.width;
    final resolvedLayout =
        layout ??
        (screenWidth < 600 ? Ux4gToastLayout.stacked : Ux4gToastLayout.full);
    final style = _getToastStyle(category, ux4gColors, materialTheme);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(Ux4gRadius.radius4),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: resolvedLayout == Ux4gToastLayout.full
              ? Ux4gSpace.space16
              : Ux4gSpace.space12,
          vertical: resolvedLayout == Ux4gToastLayout.full
              ? Ux4gSpace.space8
              : Ux4gSpace.space12,
        ),
        child: resolvedLayout == Ux4gToastLayout.full
            ? _FullLayout(
                style: style,
                title: title,
                subtitle: subtitle,
                actionText: actionText,
                onActionClick: onActionClick,
                onCloseClick: onCloseClick,
                showCloseButton: showCloseButton,
              )
            : _StackedLayout(
                style: style,
                title: title,
                subtitle: subtitle,
                actionText: actionText,
                onActionClick: onActionClick,
                onCloseClick: onCloseClick,
                showCloseButton: showCloseButton,
              ),
      ),
    );
  }

  _ToastStyle _getToastStyle(
    Ux4gToastCategory category,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
  ) {
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final info = ux4gColors?.info ?? Colors.blue;
    final success = ux4gColors?.success ?? Colors.green;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;

    switch (category) {
      case Ux4gToastCategory.info:
        return _ToastStyle(
          backgroundColor: Color.lerp(surface, info, 0.12)!,
          iconColor: info,
          actionColor: info,
          icon: Icons.info_outline,
        );
      case Ux4gToastCategory.success:
        return _ToastStyle(
          backgroundColor: Color.lerp(surface, success, 0.12)!,
          iconColor: success,
          actionColor: success,
          icon: Icons.check_circle_outline,
        );
      case Ux4gToastCategory.warning:
        return _ToastStyle(
          backgroundColor: Color.lerp(surface, warning, 0.12)!,
          iconColor: warning,
          actionColor: warning,
          icon: Icons.warning_amber_rounded,
        );
      case Ux4gToastCategory.error:
        return _ToastStyle(
          backgroundColor: Color.lerp(surface, error, 0.12)!,
          iconColor: error,
          actionColor: error,
          icon: Icons.error_outline,
        );
      case Ux4gToastCategory.slot:
        return _ToastStyle(
          backgroundColor: Color.lerp(surface, primary, 0.12)!,
          iconColor: primary,
          actionColor: primary,
          icon: Icons.settings_outlined,
        );
    }
  }
}

class _FullLayout extends StatelessWidget {
  final _ToastStyle style;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionClick;
  final VoidCallback? onCloseClick;
  final bool showCloseButton;

  const _FullLayout({
    required this.style,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionClick,
    this.onCloseClick,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Row(
      children: [
        Icon(style.icon, size: 20, color: style.iconColor),
        const SizedBox(width: Ux4gSpace.space12),
        Expanded(
          child: Row(
            children: [
              Text(
                title,
                style:
                    (ux4gTypography?.bS_strong ??
                            materialTheme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(color: onSurface),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(width: Ux4gSpace.space8),
                Expanded(
                  child: Text(
                    subtitle!,
                    style:
                        (ux4gTypography?.bS_default ??
                                materialTheme.textTheme.bodySmall)
                            ?.copyWith(color: onSurface.withValues(alpha: 0.6)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionText != null && onActionClick != null)
          GestureDetector(
            onTap: onActionClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Ux4gSpace.space16,
              ),
              child: Text(
                actionText!,
                style:
                    (ux4gTypography?.lM_strong ??
                            materialTheme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(color: style.actionColor),
              ),
            ),
          ),
        if (showCloseButton && onCloseClick != null)
          GestureDetector(
            onTap: onCloseClick,
            child: Icon(Icons.close, size: 20, color: onSurface),
          ),
      ],
    );
  }
}

class _StackedLayout extends StatelessWidget {
  final _ToastStyle style;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionClick;
  final VoidCallback? onCloseClick;
  final bool showCloseButton;

  const _StackedLayout({
    required this.style,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionClick,
    this.onCloseClick,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(style.icon, size: 20, color: style.iconColor),
            const SizedBox(width: Ux4gSpace.space8),
            Expanded(
              child: Text(
                title,
                style:
                    (ux4gTypography?.bS_strong ??
                            materialTheme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(color: onSurface),
              ),
            ),
            if (showCloseButton && onCloseClick != null)
              GestureDetector(
                onTap: onCloseClick,
                child: Icon(Icons.close, size: 20, color: onSurface),
              ),
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 28, top: 2),
            child: Text(
              subtitle!,
              style:
                  (ux4gTypography?.bS_default ??
                          materialTheme.textTheme.bodySmall)
                      ?.copyWith(color: onSurface.withValues(alpha: 0.6)),
            ),
          ),
        if (actionText != null && onActionClick != null)
          GestureDetector(
            onTap: onActionClick,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 28, top: 6),
              child: Text(
                actionText!,
                style:
                    (ux4gTypography?.lM_strong ??
                            materialTheme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(color: style.actionColor),
              ),
            ),
          ),
      ],
    );
  }
}

class _ToastStyle {
  final Color backgroundColor;
  final Color iconColor;
  final Color actionColor;
  final IconData icon;

  const _ToastStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.actionColor,
    required this.icon,
  });
}

class Ux4gToastHost extends StatelessWidget {
  final Ux4gToastHostState hostState;
  final bool isBottom;

  const Ux4gToastHost({
    super.key,
    required this.hostState,
    this.isBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: hostState,
      builder: (context, child) {
        final data = hostState.currentToast;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: Offset(0, isBottom ? 1 : -1),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
          child: data == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(Ux4gSpace.space16),
                  child: Ux4gToast(
                    category: data.category,
                    title: data.title,
                    subtitle: data.subtitle,
                    actionText: data.actionText,
                    onActionClick: data.onActionClick,
                    onCloseClick: () => hostState.dismiss(),
                    showCloseButton: data.showCloseButton,
                  ),
                ),
        );
      },
    );
  }
}
