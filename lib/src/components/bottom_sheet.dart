import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';
import 'buttons.dart';
import 'card.dart';
import 'divider.dart';

enum Ux4gBottomSheetFooterAlignment { left, centered, right, justified }

class Ux4gBottomSheet extends StatelessWidget {
  final VoidCallback onDismiss;
  final String? headerTitle;
  final String? headerSubtleText;
  final IconData? headerIcon;
  final bool showCloseButton;
  final String? description;
  final Widget content;
  final Ux4gCardFooterType footerType;
  final Ux4gBottomSheetFooterAlignment footerAlignment;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback? onPrimaryClick;
  final VoidCallback? onSecondaryClick;
  final bool showDividers;
  final bool isDraggable;
  final Color? containerColor;
  final Color? scrimColor;

  const Ux4gBottomSheet({
    super.key,
    required this.onDismiss,
    this.headerTitle,
    this.headerSubtleText,
    this.headerIcon,
    this.showCloseButton = true,
    this.description,
    required this.content,
    this.footerType = Ux4gCardFooterType.none,
    this.footerAlignment = Ux4gBottomSheetFooterAlignment.left,
    this.primaryButtonText = 'Confirm',
    this.secondaryButtonText = 'Cancel',
    this.onPrimaryClick,
    this.onSecondaryClick,
    this.showDividers = true,
    this.isDraggable = true,
    this.containerColor,
    this.scrimColor,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    String? subtitle,
    IconData? icon,
    String? description,
    bool showCloseButton = true,
    bool isDraggable = true,
    bool isDismissible = true,
    Ux4gCardFooterType footerType = Ux4gCardFooterType.none,
    Ux4gBottomSheetFooterAlignment footerAlignment =
        Ux4gBottomSheetFooterAlignment.left,
    String primaryButtonText = 'Confirm',
    String secondaryButtonText = 'Cancel',
    VoidCallback? onPrimaryClick,
    VoidCallback? onSecondaryClick,
    bool showDividers = true,
    Color? containerColor,
    Color? scrimColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: isDraggable,
      barrierColor: scrimColor,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Ux4gBottomSheet(
          onDismiss: () => Navigator.of(context).pop(),
          headerTitle: title,
          headerSubtleText: subtitle,
          headerIcon: icon,
          showCloseButton: showCloseButton,
          description: description,
          content: content,
          footerType: footerType,
          footerAlignment: footerAlignment,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryClick: onPrimaryClick,
          onSecondaryClick: onSecondaryClick,
          showDividers: showDividers,
          isDraggable: isDraggable,
          containerColor: containerColor,
          scrimColor: scrimColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color:
              containerColor ??
              (ux4gColors?.surface ?? materialTheme.colorScheme.surface),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Ux4gRadius.radius24),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Ux4gBottomSheetLayout(
            headerTitle: headerTitle,
            headerSubtleText: headerSubtleText,
            headerIcon: headerIcon,
            showCloseButton: showCloseButton,
            description: description,
            showDividers: showDividers,
            footerType: footerType,
            footerAlignment: footerAlignment,
            primaryButtonText: primaryButtonText,
            secondaryButtonText: secondaryButtonText,
            onPrimaryClick: onPrimaryClick ?? onDismiss,
            onSecondaryClick: onSecondaryClick ?? onDismiss,
            onCloseClick: onDismiss,
            isDraggable: isDraggable,
            content: content,
          ),
        ),
      ),
    );
  }
}

class Ux4gBottomSheetLayout extends StatelessWidget {
  final String? headerTitle;
  final String? headerSubtleText;
  final IconData? headerIcon;
  final bool showCloseButton;
  final String? description;
  final bool showDividers;
  final Ux4gCardFooterType footerType;
  final Ux4gBottomSheetFooterAlignment footerAlignment;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryClick;
  final VoidCallback onSecondaryClick;
  final VoidCallback onCloseClick;
  final bool isDraggable;
  final Widget content;

  const Ux4gBottomSheetLayout({
    super.key,
    this.headerTitle,
    this.headerSubtleText,
    this.headerIcon,
    this.showCloseButton = true,
    this.description,
    this.showDividers = true,
    this.footerType = Ux4gCardFooterType.none,
    this.footerAlignment = Ux4gBottomSheetFooterAlignment.left,
    this.primaryButtonText = 'Confirm',
    this.secondaryButtonText = 'Cancel',
    required this.onPrimaryClick,
    required this.onSecondaryClick,
    required this.onCloseClick,
    required this.isDraggable,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final hasHeader =
        headerTitle != null ||
        headerSubtleText != null ||
        headerIcon != null ||
        showCloseButton;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isDraggable) ...[
          const SizedBox(height: 12),
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color:
                  (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
        if (hasHeader)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Ux4gSpace.space16,
                  vertical: Ux4gSpace.space12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (headerIcon != null) ...[
                      Icon(
                        headerIcon,
                        size: 24,
                        color:
                            ux4gColors?.onSurface ??
                            materialTheme.colorScheme.onSurface,
                      ),
                      const SizedBox(width: Ux4gSpace.space12),
                    ],
                    Expanded(
                      child: Text(
                        headerTitle ?? '',
                        style:
                            (ux4gTypography?.tS_strong ??
                                    materialTheme.textTheme.titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ) ??
                                    const TextStyle())
                                .copyWith(
                                  color:
                                      ux4gColors?.onSurface ??
                                      materialTheme.colorScheme.onSurface,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (headerSubtleText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          headerSubtleText!,
                          style:
                              (ux4gTypography?.lS_default ??
                                      materialTheme.textTheme.labelSmall ??
                                      const TextStyle())
                                  .copyWith(
                                    color:
                                        (ux4gColors?.onSurface ??
                                                materialTheme
                                                    .colorScheme
                                                    .onSurface)
                                            .withValues(alpha: 0.5),
                                  ),
                        ),
                      ),
                    if (showCloseButton)
                      IconButton(
                        onPressed: onCloseClick,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color:
                              ux4gColors?.onSurface ??
                              materialTheme.colorScheme.onSurface,
                        ),
                      ),
                  ],
                ),
              ),
              if (description != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: headerIcon != null ? 52 : Ux4gSpace.space16,
                    right: Ux4gSpace.space16,
                    bottom: Ux4gSpace.space12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description!,
                      style:
                          (ux4gTypography?.bS_default ??
                                  materialTheme.textTheme.bodySmall ??
                                  const TextStyle())
                              .copyWith(
                                color:
                                    (ux4gColors?.onSurface ??
                                            materialTheme.colorScheme.onSurface)
                                        .withValues(alpha: 0.6),
                              ),
                    ),
                  ),
                ),
              if (showDividers)
                Ux4gDivider(
                  color:
                      (ux4gColors?.onSurface ??
                              materialTheme.colorScheme.onSurface)
                          .withValues(alpha: 0.1),
                ),
            ],
          ),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Ux4gSpace.space16,
              vertical: Ux4gSpace.space16,
            ),
            child: Align(alignment: Alignment.centerLeft, child: content),
          ),
        ),
        if (footerType != Ux4gCardFooterType.none)
          Column(
            children: [
              if (showDividers)
                Ux4gDivider(
                  color:
                      (ux4gColors?.onSurface ??
                              materialTheme.colorScheme.onSurface)
                          .withValues(alpha: 0.1),
                ),
              _BottomSheetFooterRow(
                footerType: footerType,
                footerAlignment: footerAlignment,
                primaryButtonText: primaryButtonText,
                secondaryButtonText: secondaryButtonText,
                onPrimaryClick: onPrimaryClick,
                onSecondaryClick: onSecondaryClick,
              ),
            ],
          ),
      ],
    );
  }
}

class _BottomSheetFooterRow extends StatelessWidget {
  final Ux4gCardFooterType footerType;
  final Ux4gBottomSheetFooterAlignment footerAlignment;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryClick;
  final VoidCallback onSecondaryClick;

  const _BottomSheetFooterRow({
    required this.footerType,
    required this.footerAlignment,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryClick,
    required this.onSecondaryClick,
  });

  @override
  Widget build(BuildContext context) {
    final arrangement = switch (footerAlignment) {
      Ux4gBottomSheetFooterAlignment.left => MainAxisAlignment.start,
      Ux4gBottomSheetFooterAlignment.centered => MainAxisAlignment.center,
      Ux4gBottomSheetFooterAlignment.right => MainAxisAlignment.end,
      Ux4gBottomSheetFooterAlignment.justified =>
        MainAxisAlignment.spaceBetween,
    };
    final isJustified =
        footerAlignment == Ux4gBottomSheetFooterAlignment.justified;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Ux4gSpace.space16,
        vertical: Ux4gSpace.space16,
      ),
      child: Row(
        mainAxisAlignment: arrangement,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (footerType == Ux4gCardFooterType.primaryAndSecondary ||
              footerType == Ux4gCardFooterType.secondaryOnly)
            if (isJustified)
              Expanded(
                child: Ux4gOutlineButton(
                  onPressed: onSecondaryClick,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Ux4gSpace.space20,
                    vertical: Ux4gSpace.space12,
                  ),
                  child: Text(secondaryButtonText),
                ),
              )
            else
              Ux4gOutlineButton(
                onPressed: onSecondaryClick,
                padding: const EdgeInsets.symmetric(
                  horizontal: Ux4gSpace.space20,
                  vertical: Ux4gSpace.space12,
                ),
                child: Text(secondaryButtonText),
              ),
          if (footerType == Ux4gCardFooterType.primaryAndSecondary)
            SizedBox(
              width: isJustified ? Ux4gSpace.space12 : Ux4gSpace.space12,
            ),
          if (footerType == Ux4gCardFooterType.primaryAndSecondary ||
              footerType == Ux4gCardFooterType.primaryOnly)
            if (isJustified)
              Expanded(
                child: Ux4gButton(
                  onPressed: onPrimaryClick,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Ux4gSpace.space20,
                    vertical: Ux4gSpace.space12,
                  ),
                  child: Text(primaryButtonText),
                ),
              )
            else
              Ux4gButton(
                onPressed: onPrimaryClick,
                padding: const EdgeInsets.symmetric(
                  horizontal: Ux4gSpace.space20,
                  vertical: Ux4gSpace.space12,
                ),
                child: Text(primaryButtonText),
              ),
        ],
      ),
    );
  }
}
