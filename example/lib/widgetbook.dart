import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stories/avatar_stories.dart';
import 'stories/badge_stories.dart';
import 'stories/button_stories.dart';
import 'stories/utils_stories.dart';
import 'stories/data_stories.dart';
import 'stories/display_stories.dart';
import 'stories/feedback_stories.dart';
import 'stories/form_stories.dart';
import 'stories/identity_stories.dart';
import 'stories/layout_stories.dart';
import 'stories/navigation_stories.dart';
import 'stories/overlay_stories.dart';
import 'stories/biometric_stories.dart';
import 'stories/progress_stories.dart';
import 'stories/pattern_stories.dart';
import 'stories/consent_stories.dart';

void main() {
  runApp(const UX4GWidgetbook());
}

class UX4GWidgetbook extends StatelessWidget {
  const UX4GWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // ── No wrapper needed here as MaterialThemeAddon handles the theme ─────
      appBuilder: (context, child) => child,

      home: const _Ux4gWelcomePage(),
      header: const _SidebarLogo(),

      directories: [
        WidgetbookCategory(
          name: 'Quick Guide',
          isInitiallyExpanded: false,
          children: [quickGuideComponent],
        ),

        // ── Components ────────────────────────────────────────────────────────
        WidgetbookCategory(
          name: 'Components',
          isInitiallyExpanded: false,
          children: [
            // Buttons
            buttonComponent,
            iconButtonComponent,

            // Display
            badgeComponent,
            tagComponent,
            cardComponent,
            dividerComponent,

            // Avatar
            WidgetbookFolder(
              name: 'Avatar',
              isInitiallyExpanded: false,
              children: [
                avatarComponent,
                profileAvatarComponent,
                statusAvatarComponent,
                avatarGroupComponent,
              ],
            ),

            // Form
            inputFieldComponent,
            textAreaComponent,
            searchFieldComponent,
            checkboxComponent,
            toggleComponent,
            sliderComponent,
            otpInputComponent,
            radioButtonComponent,
            WidgetbookFolder(
              name: 'Dropdown',
              isInitiallyExpanded: false,
              children: [actionDropdownComponent, selectionDropdownComponent],
            ),
            datePickerComponent,
            timePickerComponent,
            fileUploadComponent,
            aadhaarInputFieldComponent,
            panInputFieldComponent,

            // Progress & Loader
            WidgetbookFolder(
              name: 'Linear Progress',
              isInitiallyExpanded: false,
              children: [
                linearProgressComponent,
                animatedLinearProgressComponent,
              ],
            ),
            WidgetbookFolder(
              name: 'Circular Progress',
              isInitiallyExpanded: false,
              children: [
                circularProgressComponent,
                animatedCircularProgressComponent,
                halfCircleProgressComponent,
                animatedHalfCircleProgressComponent,
              ],
            ),
            loaderComponent,

            // Navigation & Feedback
            WidgetbookFolder(
              name: 'Accordion',
              isInitiallyExpanded: false,
              children: [accordionComponent, accordionGroupComponent],
            ),
            statusBannerComponent,
            emptyStateComponent,
            WidgetbookFolder(
              name: 'Chips',
              isInitiallyExpanded: false,
              children: [
                choiceChipComponent,
                filterChipComponent,
                inputChipComponent,
                inputChipFieldComponent,
              ],
            ),
            paginationComponent,

            // Data
            stepperComponent,
            capsuleStepperComponent,
            resultRowComponent,
            socialLinkComponent,
            WidgetbookFolder(
              name: 'Social Links',
              isInitiallyExpanded: false,
              children: [socialLinkGroupComponent, socialLinkListComponent],
            ),
            journeyTimelineComponent,
            statusPipelineComponent,
            carouselComponent,
            slotGridComponent,

            // Layout
            appHeaderComponent,

            // Overlay
            modalComponent,
            bottomSheetComponent,
            toastComponent,
            WidgetbookFolder(
              name: 'Tooltip',
              isInitiallyExpanded: false,
              children: [tooltipComponent, richTooltipComponent],
            ),

            // Feedback
            WidgetbookFolder(
              name: 'Feedback Form',
              isInitiallyExpanded: false,
              children: [
                feedbackFormComponent,
                feedbackFormNpsComponent,
                feedbackFormCsatComponent,
              ],
            ),

            // Biometric
            biometricComponent,
          ],
        ),

        // ── Utils ──────────────────────────────────────────────────────────
        WidgetbookCategory(
          name: 'Utils',
          isInitiallyExpanded: false,
          children: [
            WidgetbookFolder(
              name: 'Theme',
              isInitiallyExpanded: false,
              children: [themeColorComponent],
            ),
            WidgetbookFolder(
              name: 'Dimensions',
              isInitiallyExpanded: false,
              children: [
                dimensionsSpacingComponent,
                dimensionsRadiusComponent,
                dimensionsBorderComponent,
              ],
            ),
          ],
        ),

        // ── Patterns ───────────────────────────────────────────────────────
        WidgetbookCategory(
          name: 'Patterns',
          isInitiallyExpanded: false,
          children: [
            WidgetbookFolder(
              name: 'Identity and Access',
              isInitiallyExpanded: false,
              children: [
                WidgetbookFolder(
                  name: 'SignIn',
                  isInitiallyExpanded: false,
                  children: [
                    signInDefaultComponent,
                    signInWithMobileComponent,
                    signInEnterOtpComponent,
                    signInAadhaarComponent,
                    signInSuccessComponent,
                  ],
                ),
                WidgetbookFolder(
                  name: 'OTP Verification',
                  isInitiallyExpanded: false,
                  children: [
                    otpVerifyMobileComponent,
                    otpVerifyVoiceComponent,
                    otpVerifyAttemptWarningComponent,
                    otpVerifyLastAttemptComponent,
                    otpVerifyAccountLockedComponent,
                    otpVerifiedSuccessComponent,
                  ],
                ),
                WidgetbookFolder(
                  name: 'Session Time-out Dialog',
                  isInitiallyExpanded: false,
                  children: [sessionExpiringDialogComponent],
                ),
                WidgetbookFolder(
                  name: 'Auth errors & lockout',
                  isInitiallyExpanded: false,
                  children: [
                    authIncorrectOtpComponent,
                    authOtpAttemptWarningComponent,
                    authOtpLastAttemptComponent,
                    authOtpAccountLockedComponent,
                    authOtpRetryUnlockedComponent,
                    authOtpSuspiciousActivityComponent,
                  ],
                ),
                WidgetbookFolder(
                  name: 'Aadhaar Authentication Gate',
                  isInitiallyExpanded: false,
                  children: [
                    aadhaarVerifyMethodComponent,
                    aadhaarOtpEnterComponent,
                    aadhaarFaceAuthPermissionComponent,
                    aadhaarVerifiedSuccessComponent,
                    aadhaarVerificationFailedComponent,
                    aadhaarAccountLockedComponent,
                    operatorAssistedAuthComponent,
                  ],
                ),
                WidgetbookFolder(
                  name: 'SignUp',
                  isInitiallyExpanded: false,
                  children: [
                    signUpStep1Component,
                    signUpStep2Component,
                    signUpStep3Component,
                    signUpStep4Component,
                    signUpStep5Component,
                  ],
                ),
              ],
            ),
            WidgetbookFolder(
              name: 'Consent and Declaration',
              isInitiallyExpanded: false,
              children: [
                WidgetbookFolder(
                  name: 'Consent Capture',
                  isInitiallyExpanded: false,
                  children: [
                    consentCaptureComponent,
                    consentCaptureWithWarningComponent,
                    consentManagementComponent,
                  ],
                ),
                WidgetbookFolder(
                  name: 'Data Sharing Consent',
                  isInitiallyExpanded: false,
                  children: [
                    dataSharingConsentComponent,
                    dataSharingConsentManagementComponent,
                  ],
                ),
              ],
            ),
          ],
        ),
      ],

      addons: [
        // Device viewport sizes
        ViewportAddon([
          Viewports.none,
          IosViewports.iPhone13,
          IosViewports.iPhoneSE,
          AndroidViewports.samsungGalaxyS20,
          IosViewports.iPad,
        ]),
        // Light / Dark theme
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: Ux4gTheme.themeData(isDark: false),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: Ux4gTheme.themeData(isDark: true),
            ),
          ],
        ),
        // Text scale accessibility
        TextScaleAddon(min: 0.75, max: 2.0),
        // Alignment helper
        AlignmentAddon(),
      ],
    );
  }
}

// ── Sidebar Logo ──────────────────────────────────────────────────────────

class _SidebarLogo extends StatelessWidget {
  const _SidebarLogo();

  static const _primary = Color(0xFF6A4EFF);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // ignore: invalid_use_of_internal_member
          final state = WidgetbookState.of(context);
          state.path = null;
          state.notifyListeners();
        },
        child: Row(
          children: [
            SvgPicture.asset('assets/ux4g_logo.svg', height: 34, width: 34),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'UX4G',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color(0xFF1A1A2E),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Design System',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF9090A0)
                        : const Color(0xFF5A5A7A),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Ux4gWelcomePage extends StatelessWidget {
  const _Ux4gWelcomePage();

  static const _primary = Color(0xFF6A4EFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Explicitly define colors based on theme brightness to ensure they flip
    final bg = isDark ? const Color(0xFF121212) : Colors.white;
    final onSurface = isDark ? Colors.white : const Color(0xFF111827);
    final subtle = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Logo ─────────────────────────────────────────────────────────
                SvgPicture.asset('assets/ux4g_logo.svg', height: 22),

                const SizedBox(height: 24),

                // Version badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: _primary.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    'v3.0 beta  ·  Flutter Component Library',
                    style: TextStyle(
                      color: isDark ? const Color(0xFFA594FF) : _primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Headline
                Text(
                  'UX4G Design System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -0.8,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Government-grade UI foundations for trusted public digital experiences.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subtle, fontSize: 16, height: 1.6),
                ),

                const SizedBox(height: 32),

                // Stats row
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: const [
                    _StatPill('50+ Components'),
                    _StatPill('1K+ Design Tokens'),
                    _StatPill('10 Categories'),
                  ],
                ),

                const SizedBox(height: 48),

                // Feature cards
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.account_tree_outlined,
                          title: 'Scalable Architecture',
                          description:
                              'A structured system of foundations, patterns, and components '
                              'that scales across products and service teams.',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.palette_outlined,
                          title: 'Token-Driven Design',
                          description:
                              'Color, typography, spacing, and elevation governed through '
                              'reusable tokens that keep every experience aligned.',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.code_rounded,
                          title: 'Developer Friendly',
                          description:
                              'Production-ready components with code snippets, live knobs, '
                              'and Props documentation in every story.',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Getting started
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: isDark ? 0.12 : 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _primary.withValues(alpha: 0.18)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: isDark ? const Color(0xFFA594FF) : _primary,
                        size: 20,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Getting Started',
                              style: TextStyle(
                                color: onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Select any component from the left sidebar. '
                              'Use the Preview, Code, and Props tabs to explore.',
                              style: TextStyle(
                                color: subtle,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Footer
                Text(
                  'UX4G Design System  ·  v3.0 beta  ·  ux4g.gov.in',
                  style: TextStyle(
                    color: isDark ? Colors.white38 : const Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  final String label;
  const _StatPill(this.label);

  static const _primary = Color(0xFF6A4EFF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: _primary.withValues(alpha: isDark ? 0.15 : 0.07),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: _primary.withValues(alpha: isDark ? 0.35 : 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDark ? const Color(0xFFA594FF) : _primary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title, description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  static const _primary = Color(0xFF6A4EFF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final onSurface = isDark ? Colors.white : const Color(0xFF111827);
    final subtle = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final border = isDark ? Colors.white12 : const Color(0xFFE5E7EB);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isDark ? const Color(0xFFA594FF) : _primary,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(color: subtle, fontSize: 13, height: 1.55),
          ),
        ],
      ),
    );
  }
}
