import 'package:flutter/material.dart';

import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'avatar.dart';
import 'buttons.dart';
import 'divider.dart';

enum Ux4gModalAlignment { leftAligned, centered }

enum Ux4gModalLeadingItem { none, icon, avatar, image }

enum Ux4gModalHeaderImage { fullBleed, padded, none }

enum Ux4gModalFooterButtons {
  oneButton,
  twoButtons,
  oneButtonWithIcon,
  twoButtonsWithIcon,
}

enum Ux4gModalFooterAlign { left, right, center, split }

class Ux4gModal extends StatelessWidget {
  final VoidCallback onDismiss;
  final Widget? headerImageContent;
  final String? headerImageUrl;
  final double headerImageHeight;
  final Ux4gModalHeaderImage headerImageStyle;
  final Ux4gModalLeadingItem leadingItem;
  final IconData leadingIcon;
  final Color? leadingIconTint;
  final String? avatarInitials;
  final String? avatarImageUrl;
  final IconData? avatarIcon;
  final Ux4gAvatarSize avatarSize;
  final Ux4gAvatarSize avatarInlineSize;
  final Color? avatarContainerColor;
  final Color? avatarContentColor;
  final String? leadingImageUrl;
  final Widget? leadingImageContent;
  final bool showHeader;
  final String headerTitle;
  final bool showDescription;
  final String descriptionText;
  final bool showDividers;
  final bool showSubtitle;
  final String subtitleText;
  final bool showBody;
  final String bodyText;
  final Widget? bodyContent;
  final bool showFooter;
  final Ux4gModalFooterButtons footerButtons;
  final Ux4gModalFooterAlign footerAlign;
  final bool isDestructive;
  final String primaryButtonText;
  final String secondaryButtonText;
  final IconData leadingActionIcon;
  final VoidCallback? onPrimaryClick;
  final VoidCallback? onSecondaryClick;
  final VoidCallback? onLeadingIconPressed;
  final Ux4gModalAlignment alignment;
  final bool showCloseButton;
  final Color? backgroundColor;
  final double cornerRadius;

  const Ux4gModal({
    super.key,
    required this.onDismiss,
    this.headerImageContent,
    this.headerImageUrl,
    this.headerImageHeight = 160,
    this.headerImageStyle = Ux4gModalHeaderImage.fullBleed,
    this.leadingItem = Ux4gModalLeadingItem.none,
    this.leadingIcon = Icons.info_outline,
    this.leadingIconTint,
    this.avatarInitials,
    this.avatarImageUrl,
    this.avatarIcon,
    this.avatarSize = Ux4gAvatarSize.l,
    this.avatarInlineSize = Ux4gAvatarSize.s,
    this.avatarContainerColor,
    this.avatarContentColor,
    this.leadingImageUrl,
    this.leadingImageContent,
    this.showHeader = true,
    this.headerTitle = 'Header',
    this.showDescription = false,
    this.descriptionText = 'Write description here',
    this.showDividers = true,
    this.showSubtitle = true,
    this.subtitleText = 'Subtitle',
    this.showBody = true,
    this.bodyText =
        'A modal is a design element that pops up over the main content of a webpage. It demands the user\'s attention by temporarily disabling interaction with the rest of the page until the user addresses the content within the modal.',
    this.bodyContent,
    this.showFooter = true,
    this.footerButtons = Ux4gModalFooterButtons.twoButtons,
    this.footerAlign = Ux4gModalFooterAlign.right,
    this.isDestructive = false,
    this.primaryButtonText = 'Button',
    this.secondaryButtonText = 'Button',
    this.leadingActionIcon = Icons.info_outline,
    this.onPrimaryClick,
    this.onSecondaryClick,
    this.onLeadingIconPressed,
    this.alignment = Ux4gModalAlignment.leftAligned,
    this.showCloseButton = true,
    this.backgroundColor,
    this.cornerRadius = Ux4gRadius.radius16,
  });

  static Future<void> show(BuildContext context, {required Ux4gModal modal}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => modal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Ux4gModalContent(
        onDismiss: onDismiss,
        headerImageContent: headerImageContent,
        headerImageUrl: headerImageUrl,
        headerImageHeight: headerImageHeight,
        headerImageStyle: headerImageStyle,
        leadingItem: leadingItem,
        leadingIcon: leadingIcon,
        leadingIconTint: leadingIconTint,
        avatarInitials: avatarInitials,
        avatarImageUrl: avatarImageUrl,
        avatarIcon: avatarIcon,
        avatarSize: avatarSize,
        avatarInlineSize: avatarInlineSize,
        avatarContainerColor: avatarContainerColor,
        avatarContentColor: avatarContentColor,
        leadingImageUrl: leadingImageUrl,
        leadingImageContent: leadingImageContent,
        showHeader: showHeader,
        headerTitle: headerTitle,
        showDescription: showDescription,
        descriptionText: descriptionText,
        showDividers: showDividers,
        showSubtitle: showSubtitle,
        subtitleText: subtitleText,
        showBody: showBody,
        bodyText: bodyText,
        bodyContent: bodyContent,
        showFooter: showFooter,
        footerButtons: footerButtons,
        footerAlign: footerAlign,
        isDestructive: isDestructive,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        leadingActionIcon: leadingActionIcon,
        onPrimaryClick: onPrimaryClick,
        onSecondaryClick: onSecondaryClick,
        onLeadingIconPressed: onLeadingIconPressed,
        alignment: alignment,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor ?? colors.surface,
        cornerRadius: cornerRadius,
      ),
    );
  }
}

class Ux4gModalContent extends StatelessWidget {
  final VoidCallback onDismiss;
  final Widget? headerImageContent;
  final String? headerImageUrl;
  final double headerImageHeight;
  final Ux4gModalHeaderImage headerImageStyle;
  final Ux4gModalLeadingItem leadingItem;
  final IconData leadingIcon;
  final Color? leadingIconTint;
  final String? avatarInitials;
  final String? avatarImageUrl;
  final IconData? avatarIcon;
  final Ux4gAvatarSize avatarSize;
  final Ux4gAvatarSize avatarInlineSize;
  final Color? avatarContainerColor;
  final Color? avatarContentColor;
  final String? leadingImageUrl;
  final Widget? leadingImageContent;
  final bool showHeader;
  final String headerTitle;
  final bool showDescription;
  final String descriptionText;
  final bool showDividers;
  final bool showSubtitle;
  final String subtitleText;
  final bool showBody;
  final String bodyText;
  final Widget? bodyContent;
  final bool showFooter;
  final Ux4gModalFooterButtons footerButtons;
  final Ux4gModalFooterAlign footerAlign;
  final bool isDestructive;
  final String primaryButtonText;
  final String secondaryButtonText;
  final IconData leadingActionIcon;
  final VoidCallback? onPrimaryClick;
  final VoidCallback? onSecondaryClick;
  final VoidCallback? onLeadingIconPressed;
  final Ux4gModalAlignment alignment;
  final bool showCloseButton;
  final Color backgroundColor;
  final double cornerRadius;

  const Ux4gModalContent({
    super.key,
    required this.onDismiss,
    this.headerImageContent,
    this.headerImageUrl,
    this.headerImageHeight = 160,
    this.headerImageStyle = Ux4gModalHeaderImage.fullBleed,
    this.leadingItem = Ux4gModalLeadingItem.none,
    this.leadingIcon = Icons.info_outline,
    this.leadingIconTint,
    this.avatarInitials,
    this.avatarImageUrl,
    this.avatarIcon,
    this.avatarSize = Ux4gAvatarSize.l,
    this.avatarInlineSize = Ux4gAvatarSize.s,
    this.avatarContainerColor,
    this.avatarContentColor,
    this.leadingImageUrl,
    this.leadingImageContent,
    this.showHeader = true,
    this.headerTitle = 'Header',
    this.showDescription = false,
    this.descriptionText = 'Write description here',
    this.showDividers = true,
    this.showSubtitle = true,
    this.subtitleText = 'Subtitle',
    this.showBody = true,
    this.bodyText = '',
    this.bodyContent,
    this.showFooter = true,
    this.footerButtons = Ux4gModalFooterButtons.twoButtons,
    this.footerAlign = Ux4gModalFooterAlign.right,
    this.isDestructive = false,
    this.primaryButtonText = 'Button',
    this.secondaryButtonText = 'Button',
    this.leadingActionIcon = Icons.info_outline,
    this.onPrimaryClick,
    this.onSecondaryClick,
    this.onLeadingIconPressed,
    this.alignment = Ux4gModalAlignment.leftAligned,
    this.showCloseButton = true,
    required this.backgroundColor,
    this.cornerRadius = Ux4gRadius.radius16,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final isCentered = alignment == Ux4gModalAlignment.centered;
    final textAlign = isCentered ? TextAlign.center : TextAlign.start;
    final horizAlign = isCentered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final hasImage =
        headerImageStyle != Ux4gModalHeaderImage.none &&
        (headerImageContent != null || headerImageUrl != null);
    final primaryColor = isDestructive ? colors.error : colors.primary;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) _buildHeaderImage(context),
                  if (leadingItem == Ux4gModalLeadingItem.avatar &&
                      isCentered &&
                      showHeader)
                    Padding(
                      padding: const EdgeInsets.only(top: Ux4gSpace.space16),
                      child: Center(child: _buildAvatar(centered: true)),
                    ),
                  if (showHeader)
                    _buildHeaderSection(
                      context,
                      hasImage: hasImage,
                      textAlign: textAlign,
                      horizAlign: horizAlign,
                    ),
                  if (showSubtitle || showBody || bodyContent != null)
                    Padding(
                      padding: const EdgeInsets.all(Ux4gSpace.space16),
                      child: Column(
                        crossAxisAlignment: horizAlign,
                        children: [
                          if (showSubtitle)
                            Text(
                              subtitleText,
                              style: Ux4gTheme.typography(
                                context,
                              ).tS_strong.copyWith(color: colors.onSurface),
                              textAlign: textAlign,
                            ),
                          if (showBody) ...[
                            const SizedBox(height: Ux4gSpace.space8),
                            if (bodyContent != null)
                              bodyContent!
                            else
                              Text(
                                bodyText,
                                style: Ux4gTheme.typography(context).bM_default
                                    .copyWith(
                                      color: colors.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                textAlign: textAlign,
                              ),
                          ],
                        ],
                      ),
                    ),
                  if (showFooter)
                    Column(
                      children: [
                        if (showDividers)
                          Ux4gDivider(
                            color: colors.onSurface.withValues(alpha: 0.2),
                          ),
                        _Ux4gModalFooter(
                          footerButtons: footerButtons,
                          footerAlign: footerAlign,
                          isDestructive: isDestructive,
                          primaryColor: primaryColor,
                          primaryButtonText: primaryButtonText,
                          secondaryButtonText: secondaryButtonText,
                          leadingActionIcon: leadingActionIcon,
                          onPrimaryClick: onPrimaryClick ?? onDismiss,
                          onSecondaryClick: onSecondaryClick ?? onDismiss,
                          onLeadingIconClick: onLeadingIconPressed ?? () {},
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (showCloseButton &&
                headerImageStyle != Ux4gModalHeaderImage.padded)
              Positioned(
                top: Ux4gSpace.space16,
                right: Ux4gSpace.space16,
                child: hasImage
                    ? Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: colors.onSurface.withValues(alpha: 0.65),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: onDismiss,
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: colors.surface,
                          ),
                        ),
                      )
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: onDismiss,
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: colors.onSurface,
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    final image = _HeaderImageSlot(
      headerImageContent: headerImageContent,
      headerImageUrl: headerImageUrl,
    );

    if (headerImageStyle == Ux4gModalHeaderImage.padded) {
      return Padding(
        padding: const EdgeInsets.all(Ux4gSpace.space12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Ux4gRadius.radius12),
          child: SizedBox(
            width: double.infinity,
            height: headerImageHeight,
            child: image,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: headerImageHeight,
      child: image,
    );
  }

  Widget _buildHeaderSection(
    BuildContext context, {
    required bool hasImage,
    required TextAlign textAlign,
    required CrossAxisAlignment horizAlign,
  }) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);
    final isCentered = alignment == Ux4gModalAlignment.centered;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            Ux4gSpace.space16,
            Ux4gSpace.space16,
            // Reserve space for the close button (right: 16 + width: 32 + gap: 4)
            showCloseButton &&
                    headerImageStyle != Ux4gModalHeaderImage.padded
                ? Ux4gSpace.space16 + 36
                : Ux4gSpace.space16,
            Ux4gSpace.space16,
          ),
          child: Column(
            crossAxisAlignment: horizAlign,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: isCentered
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  if (leadingItem == Ux4gModalLeadingItem.icon) ...[
                    Icon(
                      leadingIcon,
                      size: 24,
                      color: leadingIconTint ?? colors.onSurface,
                    ),
                    const SizedBox(width: Ux4gSpace.space8),
                  ],
                  if (leadingItem == Ux4gModalLeadingItem.avatar &&
                      !isCentered) ...[
                    _buildAvatar(centered: false),
                    const SizedBox(width: Ux4gSpace.space8),
                  ],
                  if (leadingItem == Ux4gModalLeadingItem.image &&
                      (leadingImageContent != null ||
                          leadingImageUrl != null)) ...[
                    _buildLeadingImage(),
                    const SizedBox(width: Ux4gSpace.space8),
                  ],
                  Flexible(
                    child: Text(
                      headerTitle,
                      style: typography.tS_strong.copyWith(
                        color: colors.onSurface,
                      ),
                      textAlign: textAlign,
                    ),
                  ),
                ],
              ),
              if (showDescription) ...[
                const SizedBox(height: Ux4gSpace.space4),
                Text(
                  descriptionText,
                  style: typography.bS_default.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                  textAlign: textAlign,
                ),
              ],
            ],
          ),
        ),
        if (showDividers)
          Ux4gDivider(color: colors.onSurface.withValues(alpha: 0.2)),
      ],
    );
  }

  Widget _buildAvatar({required bool centered}) {
    return Ux4gAvatar(
      size: centered ? avatarSize : avatarInlineSize,
      initials: avatarInitials,
      imageUrl: avatarImageUrl,
      icon: avatarIcon,
      containerColor: avatarContainerColor,
      contentColor: avatarContentColor,
    );
  }

  Widget _buildLeadingImage() {
    if (leadingImageContent != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
        child: SizedBox(width: 40, height: 40, child: leadingImageContent),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
      child: Image.network(
        leadingImageUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _HeaderImageSlot extends StatelessWidget {
  final Widget? headerImageContent;
  final String? headerImageUrl;

  const _HeaderImageSlot({this.headerImageContent, this.headerImageUrl});

  @override
  Widget build(BuildContext context) {
    if (headerImageContent != null) {
      return SizedBox.expand(child: headerImageContent!);
    }

    return Image.network(headerImageUrl!, fit: BoxFit.cover);
  }
}

class _Ux4gModalFooter extends StatelessWidget {
  final Ux4gModalFooterButtons footerButtons;
  final Ux4gModalFooterAlign footerAlign;
  final bool isDestructive;
  final Color primaryColor;
  final String primaryButtonText;
  final String secondaryButtonText;
  final IconData leadingActionIcon;
  final VoidCallback onPrimaryClick;
  final VoidCallback onSecondaryClick;
  final VoidCallback onLeadingIconClick;

  const _Ux4gModalFooter({
    required this.footerButtons,
    required this.footerAlign,
    required this.isDestructive,
    required this.primaryColor,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.leadingActionIcon,
    required this.onPrimaryClick,
    required this.onSecondaryClick,
    required this.onLeadingIconClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final hasLeadingIcon =
        footerButtons == Ux4gModalFooterButtons.oneButtonWithIcon ||
        footerButtons == Ux4gModalFooterButtons.twoButtonsWithIcon;
    final hasSecondary =
        footerButtons == Ux4gModalFooterButtons.twoButtons ||
        footerButtons == Ux4gModalFooterButtons.twoButtonsWithIcon;

    final alignment = switch (footerAlign) {
      Ux4gModalFooterAlign.left => MainAxisAlignment.start,
      Ux4gModalFooterAlign.right => MainAxisAlignment.end,
      Ux4gModalFooterAlign.center => MainAxisAlignment.center,
      Ux4gModalFooterAlign.split => MainAxisAlignment.spaceBetween,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Ux4gSpace.space16,
        vertical: Ux4gSpace.space12,
      ),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasLeadingIcon) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onLeadingIconClick,
                icon: Icon(leadingActionIcon, size: 20, color: colors.primary),
              ),
            ),
            if (footerAlign != Ux4gModalFooterAlign.split)
              const SizedBox(width: Ux4gSpace.space8),
          ],
          if (hasSecondary) ...[
            if (footerAlign == Ux4gModalFooterAlign.split)
              Expanded(
                child: Ux4gOutlineButton(
                  onPressed: onSecondaryClick,
                  width: double.infinity,
                  borderRadius: Ux4gRadius.radius8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Ux4gSpace.space16,
                    vertical: Ux4gSpace.space12,
                  ),
                  child: Text(secondaryButtonText),
                ),
              )
            else
              Ux4gOutlineButton(
                onPressed: onSecondaryClick,
                borderRadius: Ux4gRadius.radius8,
                padding: const EdgeInsets.symmetric(
                  horizontal: Ux4gSpace.space16,
                  vertical: Ux4gSpace.space12,
                ),
                child: Text(secondaryButtonText),
              ),
            const SizedBox(width: Ux4gSpace.space8),
          ],
          if (footerAlign == Ux4gModalFooterAlign.split && hasSecondary)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Ux4gButton(
                  onPressed: onPrimaryClick,
                  width: double.infinity,
                  backgroundColor: primaryColor,
                  contentColor: isDestructive
                      ? colors.onError
                      : colors.onPrimary,
                  borderRadius: Ux4gRadius.radius8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Ux4gSpace.space16,
                    vertical: Ux4gSpace.space12,
                  ),
                  child: Text(primaryButtonText),
                ),
              ),
            )
          else
            Ux4gButton(
              onPressed: onPrimaryClick,
              backgroundColor: primaryColor,
              contentColor: isDestructive ? colors.onError : colors.onPrimary,
              borderRadius: Ux4gRadius.radius8,
              padding: const EdgeInsets.symmetric(
                horizontal: Ux4gSpace.space16,
                vertical: Ux4gSpace.space12,
              ),
              child: Text(primaryButtonText),
            ),
        ],
      ),
    );
  }
}
