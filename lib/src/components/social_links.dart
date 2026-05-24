import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../foundation/colors.dart';

enum SocialLinkSize {
  xs(16),
  s(20),
  m(24),
  l(32),
  xl(40),
  xxl(48);

  final double size;

  const SocialLinkSize(this.size);
}

/// Available social media icons from assets
enum SocialMediaIcon {
  android('Android_White.svg', 'Android_color.svg'),
  apple('Apple_White.svg', 'Apple_color.svg'),
  behance('Behane_white.svg', 'Behane_color.svg'),
  dribbble('Dribbbe_White.svg', 'Dribbbe_color.svg'),
  figma('Figma_White.svg', 'Figma_color.svg'),
  github('Github_White.svg', 'Github_color.svg'),
  gmail('Gmail_White.svg', 'Gmail_color.svg'),
  googleMeet('Google Meet_White.svg', 'Google Meet_color.svg'),
  googlePlay('Google Play_White.svg', 'Google Play_color.svg'),
  google('Google_White.svg', 'Google_color.svg'),
  instagram('Instagram_White.svg', 'Instagram_color.svg'),
  medium('Medium_White.svg', 'Medium_color.svg'),
  microsoftTeams('Microsoft Teams_White.svg', 'Microsoft Teams_color.svg'),
  notion('Notion_White.svg', 'Notion_color.svg'),
  reddit('Reddit_White.svg', 'Reddit_color.svg'),
  skype('Skype_White.svg', 'Skype_color.svg'),
  slack('Slack_White.svg', 'Slack_color.svg'),
  social('Social_White.svg', 'Social_color.svg'),
  stackoverflow('StackOverflow_White.svg', 'StackOverflow_color.svg'),
  twitter('Twitter_White.svg', 'Twitter_color.svg'),
  vector('Vector_white.svg', 'Vector_color.svg'),
  whatsapp('WhatsApp_White.svg', 'WhatsApp_color.svg'),
  youtube('YouTube_White.svg', 'YouTube_color.svg'),
  zoom('Zoom_White.svg', 'Zoom_color.svg');

  final String whiteFilename;
  final String colorFilename;

  const SocialMediaIcon(this.whiteFilename, this.colorFilename);

  String getAssetPath({bool useColor = false}) {
    final filename = useColor ? colorFilename : whiteFilename;
    return 'packages/ux4g_flutter_design_system/assets/icons/$filename';
  }
}

class Ux4gSocialLink extends StatelessWidget {
  final SocialMediaIcon icon;
  final SocialLinkSize size;
  final Color? color;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double? containerSize;
  final Color? containerColor;
  final bool enableBackground;
  final bool useColoredIcon;

  const Ux4gSocialLink({
    super.key,
    required this.icon,
    this.size = SocialLinkSize.m,
    this.color,
    this.onPressed,
    this.tooltip,
    this.containerSize,
    this.containerColor,
    this.enableBackground = false,
    this.useColoredIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    
    final finalColor = color ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface);
    final finalBackgroundColor = containerColor ?? (ux4gColors?.primary ?? materialTheme.colorScheme.primary).withValues(alpha: 0.1);

    final assetPath = icon.getAssetPath(useColor: useColoredIcon);
    final shouldApplyColorFilter = !useColoredIcon || color != null;

    Widget iconWidget = SvgPicture.asset(
      assetPath,
      width: size.size,
      height: size.size,
      colorFilter: shouldApplyColorFilter 
          ? ColorFilter.mode(finalColor, BlendMode.srcIn)
          : null,
    );

    if (enableBackground && containerSize != null) {
      iconWidget = Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: finalBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
      );
    } else if (enableBackground) {
      final cSize = size.size + 16;
      iconWidget = Container(
        width: cSize,
        height: cSize,
        decoration: BoxDecoration(
          color: finalBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
      );
    }

    if (onPressed != null) {
      iconWidget = Tooltip(
        message: tooltip ?? icon.name,
        child: GestureDetector(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: iconWidget,
          ),
        ),
      );
    }

    return iconWidget;
  }
}

class Ux4gSocialLinkGroup extends StatelessWidget {
  final List<SocialMediaIcon> icons;
  final SocialLinkSize size;
  final Color? iconColor;
  final VoidCallback Function(SocialMediaIcon)? onIconPressed;
  final double spacing;
  final bool enableBackground;
  final Color? backgroundColor;

  const Ux4gSocialLinkGroup({
    super.key,
    required this.icons,
    this.size = SocialLinkSize.m,
    this.iconColor,
    this.onIconPressed,
    this.spacing = 12,
    this.enableBackground = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: icons.map((icon) {
        return Ux4gSocialLink(
          icon: icon,
          size: size,
          color: iconColor,
          onPressed: onIconPressed != null ? onIconPressed!(icon) : null,
          containerColor: backgroundColor,
          enableBackground: enableBackground,
        );
      }).toList(),
    );
  }
}

class Ux4gSocialLinkList extends StatelessWidget {
  final List<SocialMediaIcon> icons;
  final SocialLinkSize size;
  final Color? iconColor;
  final VoidCallback Function(SocialMediaIcon)? onIconPressed;
  final bool enableBackground;
  final Color? backgroundColor;
  final MainAxisAlignment alignment;
  final Axis direction;

  const Ux4gSocialLinkList({
    super.key,
    required this.icons,
    this.size = SocialLinkSize.m,
    this.iconColor,
    this.onIconPressed,
    this.enableBackground = false,
    this.backgroundColor,
    this.alignment = MainAxisAlignment.start,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final children = icons.map((icon) {
      return Ux4gSocialLink(
        icon: icon,
        size: size,
        color: iconColor,
        onPressed: onIconPressed != null ? onIconPressed!(icon) : null,
        containerColor: backgroundColor,
        enableBackground: enableBackground,
      );
    }).toList();

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: alignment,
        children: children,
      );
    } else {
      return Column(
        mainAxisAlignment: alignment,
        children: children,
      );
    }
  }
}
