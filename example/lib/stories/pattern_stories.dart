import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import '../widgets/component_docs.dart';

// ── Asset paths (copied into example/assets/) ──────────────────────────
const _nationalEmblemPath = 'assets/national_amblam_logo.svg';
const _unionLogoPath = 'assets/Union.svg';
const _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

// ── Shared design tokens used across all SignIn patterns ───────────────
const _bg = Color(0xFFFAFAFA);
const _border = Color(0xFFE5E7EB);
const _titleColor = Ux4gPalette.gray900;
const _subtleText = Color(0xFF6B7280);
const _mutedText = Color(0xFF9CA3AF);

const _placeholderStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Color(0xFF9CA3AF),
  height: 1.3,
);

// ───────────────────────────────────────────────────────────────────────
// SignIn pattern variants
//
// Each screen lives in its own [WidgetbookComponent] so the SignIn folder
// renders as a flat list of patterns:
//
//   SignIn
//    ├── Sign in to your account
//    ├── Enter OTP
//    ├── Sign in with Aadhaar
//    └── Signed in success
//
// Each component keeps a single "Default" use case that renders the
// mobile mockup. This also keeps each component's "Code" tab focused
// on just that one screen's snippet.
// ───────────────────────────────────────────────────────────────────────

final signInDefaultComponent = WidgetbookComponent(
  name: 'Sign in to your account',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        // Right-side knob lets the user toggle layout variants without
        // cluttering the tree with multiple entries. Both variants share
        // the same intent ("sign in to your account") so they belong
        // together — different actual patterns (OTP, Aadhaar, Success)
        // remain separate components.
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard Username/Password layout and '
              'the card-style mobile-number layout.',
        );

        final code = switch (variant) {
          'Card style' => _signInCardCode,
          _ => _signInDefaultCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _SignInCardMockup(),
          _ => const _SignInMobileMockup(),
        };

        return ComponentDocs(
          name: 'Sign in to your account',
          description:
              'A government-grade sign-in pattern. Use the [Variant] knob '
              'on the right to toggle between the default Username/Password '
              'layout and the card-style mobile-number layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final signInWithMobileComponent = WidgetbookComponent(
  name: 'Sign in account with Mobile No',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        // Same knob pattern as the Username/Password component — toggles
        // between the flat layout and the soft-purple card layout.
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat mobile-number layout '
              'and the card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _signInWithMobileCardCode,
          _ => _signInWithMobileCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _SignInWithMobileCardMockup(),
          _ => const _SignInWithMobileMockup(),
        };

        return ComponentDocs(
          name: 'Sign in account with Mobile No',
          description:
              'Mobile-number sign-in pattern with a +91 prefix, an OTP '
              'send action, and an Aadhaar fallback. Use the [Variant] '
              'knob on the right to toggle between the flat layout and '
              'the card-style layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final signInEnterOtpComponent = WidgetbookComponent(
  name: 'Enter OTP',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat OTP layout and the '
              'card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _enterOtpCardCode,
          _ => _enterOtpCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _EnterOtpCardMockup(),
          _ => const _EnterOtpMobileMockup(),
        };

        return ComponentDocs(
          name: 'Enter OTP',
          description:
              'OTP verification screen with 6 single-digit input boxes, '
              'a built-in 60-second resend countdown, and a verify action. '
              'Use the [Variant] knob on the right to toggle between the '
              'flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final signInAadhaarComponent = WidgetbookComponent(
  name: 'Sign in with Aadhaar',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat Aadhaar layout and the '
              'card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _aadhaarCardCode,
          _ => _aadhaarCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _SignInAadhaarCardMockup(),
          _ => const _SignInAadhaarMobileMockup(),
        };

        return ComponentDocs(
          name: 'Sign in with Aadhaar',
          description:
              'Aadhaar-based authentication screen with a 12-digit Aadhaar '
              'input and a choice between OTP and Face Auth methods. '
              'Use the [Variant] knob on the right to toggle between the '
              'flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final signInSuccessComponent = WidgetbookComponent(
  name: 'Signed in success',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat success layout and the '
              'card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _signInSuccessCardCode,
          _ => _successCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _SignedInSuccessCardMockup(),
          _ => const _SignedInSuccessMobileMockup(),
        };

        return ComponentDocs(
          name: 'Signed in success',
          description:
              'Success confirmation screen shown after a successful sign-in. '
              'Includes a green check badge, a 3-second redirect countdown, '
              'and a 3-dot status indicator built with [Ux4gBadge.dot]. '
              'Use the [Variant] knob on the right to toggle between the '
              'flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// OTP Verification — sibling folder of SignIn
// ───────────────────────────────────────────────────────────────────────

final otpVerifyMobileComponent = WidgetbookComponent(
  name: 'Verify your mobile number',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat OTP verification layout '
              'and the card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _verifyMobileOtpCardCode,
          _ => _verifyMobileOtpCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyMobileOtpCardMockup(),
          _ => const _VerifyMobileOtpMockup(),
        };

        return ComponentDocs(
          name: 'Verify your mobile number',
          description:
              'Mobile-number OTP verification screen with 6 single-digit '
              'input boxes, a built-in 60-second resend countdown, a verify '
              'action, and a "Change mobile number" link. Use the [Variant] '
              'knob on the right to toggle between the flat layout and the '
              'card-style layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────
// OTP verified — success state shown right after a correct OTP, before
// the auto-redirect kicks in. Filled OTP boxes are tinted green via
// the design-system's success status, and a built-in
// "Verification successful" caption appears below.
// ─────────────────────────────────────────────────────────────────────
final otpVerifiedSuccessComponent = WidgetbookComponent(
  name: 'OTP verified — success',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style '
              'layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _otpVerifiedSuccessCardCode,
          _ => _otpVerifiedSuccessCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _OtpVerifiedSuccessCardMockup(),
          _ => const _OtpVerifiedSuccessMockup(),
        };

        return ComponentDocs(
          name: 'OTP verified — success',
          description:
              'Success confirmation shown immediately after a correct '
              'OTP — green check badge, filled OTP field tinted green '
              'via [Ux4gOtpInputStatus.success], and a built-in '
              '"Verification successful" caption. '
              'Use the [Variant] knob on the right to toggle between '
              'the flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────
// Verify mobile with account locked — terminal state after too many
// failed attempts. Shows a lock badge, disabled OTP boxes with a
// live "Locked for mm:ss" caption, an inline error banner, and a
// support phone number.
// ─────────────────────────────────────────────────────────────────────
final otpVerifyAccountLockedComponent = WidgetbookComponent(
  name: 'Verify mobile — account locked',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style '
              'layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _verifyAccountLockedCardCode,
          _ => _verifyAccountLockedCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyAccountLockedCardMockup(),
          _ => const _VerifyAccountLockedMockup(),
        };

        return ComponentDocs(
          name: 'Verify mobile — account locked',
          description:
              'Terminal lockout state shown after the user exhausts all '
              'OTP attempts. Includes a disabled OTP field, a live '
              '"Locked for mm:ss" caption from the design-system OTP '
              'component, an error banner, and a support phone link. '
              'Use the [Variant] knob on the right to toggle between the '
              'flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────
// Verify mobile with last-attempt warning — like the attempt-warning
// pattern but escalated to error styling for the *final* attempt.
// ─────────────────────────────────────────────────────────────────────
final otpVerifyLastAttemptComponent = WidgetbookComponent(
  name: 'Verify mobile with last-attempt warning',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style '
              'layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _verifyLastAttemptCardCode,
          _ => _verifyLastAttemptCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyMobileLastAttemptCardMockup(),
          _ => const _VerifyMobileLastAttemptMockup(),
        };

        return ComponentDocs(
          name: 'Verify mobile with last-attempt warning',
          description:
              'Mobile-number OTP verification on the *final* attempt — '
              'shows an error-styled banner warning the user that one '
              'more wrong entry will lock the account for 30 minutes. '
              'Use the [Variant] knob on the right to toggle between the '
              'flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────
// Verify mobile with attempt warning — adds an inline warning banner
// counting down failed attempts before a 30-minute lockout.
// ─────────────────────────────────────────────────────────────────────
final otpVerifyAttemptWarningComponent = WidgetbookComponent(
  name: 'Verify mobile with attempt warning',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style '
              'layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _verifyAttemptWarningCardCode,
          _ => _verifyAttemptWarningCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyMobileAttemptWarningCardMockup(),
          _ => const _VerifyMobileAttemptWarningMockup(),
        };

        return ComponentDocs(
          name: 'Verify mobile with attempt warning',
          description:
              'Mobile-number OTP verification screen showing a warning '
              'banner after a wrong OTP. Counts down remaining attempts '
              'before a 30-minute lockout. Use the [Variant] knob on the '
              'right to toggle between the flat layout and the card-style '
              'layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────
// Verify mobile with voice-call fallback — adds a Back button at top,
// shows the resend timer in its expired state (active "Resend OTP"
// link), and a secondary outlined "Get OTP via voice call" CTA.
// ─────────────────────────────────────────────────────────────────────
final otpVerifyVoiceComponent = WidgetbookComponent(
  name: 'Verify mobile with voice fallback',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style '
              'layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _verifyVoiceFallbackCardCode,
          _ => _verifyVoiceFallbackCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyMobileVoiceCardMockup(),
          _ => const _VerifyMobileVoiceMockup(),
        };

        return ComponentDocs(
          name: 'Verify mobile with voice fallback',
          description:
              'Mobile-number OTP verification with a back action at the '
              'top, an active "Resend OTP" link (timer expired), and a '
              'secondary "Get OTP via voice call" CTA for users who '
              'never received the SMS. Use the [Variant] knob on the right '
              'to toggle between the flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Shared helpers
// ───────────────────────────────────────────────────────────────────────

/// Phone-frame container shared by every mobile mockup so each screen
/// renders inside an identical 360x760 device frame with rounded corners.
class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 760,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Government-style header used by every screen — national emblem, a thin
/// vertical divider, and the brand union logo.
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ux4gAppHeader(
          variant: Ux4gAppHeaderVariant.light,
          title: '',
          leadingWidgets: [
            SvgPicture.asset(_nationalEmblemPath, height: 32),
            Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
            SvgPicture.asset(_unionLogoPath, height: 32),
          ],
          horizontalPadding: 16,
          leadingSpacing: 12,
        ),
        const Divider(height: 1, thickness: 1, color: _border),
      ],
    );
  }
}

/// "Powered by - Digital India" footer shared by every screen.
class _BrandFooter extends StatelessWidget {
  const _BrandFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: _mutedText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Image.asset(_digitalIndiaLogoPath, height: 22),
        ],
      ),
    );
  }
}

/// Reusable ghost-style back button using [Ux4gButton].
class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Ux4gButton(
      text: 'Back',
      onPressed: () {},
      variant: Ux4gButtonVariant.ghost,
      size: Ux4gButtonSize.small,
      leadingIcon: Icons.arrow_back,
      iconSize: 18,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }
}

/// Reusable "New user? Register here" link, styled to match the
/// reference design — soft purple (primary @ 75% alpha), bold,
/// 16px with a slight negative letter-spacing.
class _RegisterLink extends StatelessWidget {
  const _RegisterLink({this.fontSize = 16});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(
          'New user? Register here',
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// 1. Sign in to your account — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _SignInMobileMockup extends StatefulWidget {
  const _SignInMobileMockup();

  @override
  State<_SignInMobileMockup> createState() => _SignInMobileMockupState();
}

class _SignInMobileMockupState extends State<_SignInMobileMockup> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Access your government services securely',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Ux4gInputField(
                    value: _username,
                    onValueChange: (v) => setState(() => _username = v),
                    label: 'Username',
                    placeholder: 'Enter your username',
                    placeholderStyle: _placeholderStyle,
                  ),
                  const SizedBox(height: 16),

                  Ux4gInputField(
                    value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password',
                    placeholder: '...........',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 16),

                  // Error banner — uses the design-system [Ux4gStatusBanner]
                  // with [margin: EdgeInsets.zero] so it aligns flush with
                  // the inputs above. The Username-not-found message uses
                  // the regular [title], "Take action" the bold [subtitle],
                  // and the "Attempt 1 of 5" pill rides as [trailingIcon].
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title: 'Username not found.',
                    subtitle: 'Take action',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    subtitleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    leadingIcon: const Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.red600,
                      size: 20,
                    ),
                    trailingIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.red100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 1 of 5',
                        style: TextStyle(
                          fontSize: 12,
                          color: Ux4gPalette.red800,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Expanded(child: Divider(color: _border, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            color: _mutedText,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: _border, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Ux4gButton(
                    text: 'Sign in with Aadhaar',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 28),

                  const _RegisterLink(),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// 2. Enter OTP — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _EnterOtpMobileMockup extends StatefulWidget {
  const _EnterOtpMobileMockup();

  @override
  State<_EnterOtpMobileMockup> createState() => _EnterOtpMobileMockupState();
}

class _EnterOtpMobileMockupState extends State<_EnterOtpMobileMockup> {
  String _otp = '';

  // Bumped every time the user taps "Resend OTP" — used as a [ValueKey]
  // for the OTP input so it remounts and restarts its built-in countdown.
  int _resendNonce = 0;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 32),

                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes via the design-system component.
                  // [autoCountdownSeconds] runs a built-in 60s reverse
                  // timer. When it hits 00:00 the caption flips from
                  // resendTimer → resendAction, making "Resend OTP"
                  // tap-able. Tapping it bumps the key so the component
                  // re-mounts and restarts the timer.
                  Ux4gOtpInput(
                    key: ValueKey('otp_$_resendNonce'),
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                    captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                    captionLeadingText: "Didn't receive OTP?",
                    captionTrailingText: 'Resend OTP',
                    autoCountdownSeconds: 60,
                    onCaptionTrailingTap: () {
                      setState(() {
                        _otp = '';
                        _resendNonce++;
                      });
                    },
                  ),
                  const SizedBox(height: 28),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      'OTP is valid for 10 minutes',
                      style: TextStyle(fontSize: 13, color: _subtleText),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// 3. Sign in with Aadhaar — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _SignInAadhaarMobileMockup extends StatefulWidget {
  const _SignInAadhaarMobileMockup();

  @override
  State<_SignInAadhaarMobileMockup> createState() =>
      _SignInAadhaarMobileMockupState();
}

class _SignInAadhaarMobileMockupState
    extends State<_SignInAadhaarMobileMockup> {
  String _aadhaar = '';
  String _method = 'otp'; // 'otp' | 'face' — Send OTP selected by default

  /// Live validation state derived from the current Aadhaar value.
  /// We only show an error once the user has typed all 12 digits — so
  /// they don't see a red error while they're still typing.
  ({Ux4gInputFieldStatus status, String? caption}) _validate() {
    final digits = _aadhaar.replaceAll(' ', '');
    if (digits.length < 12) {
      return (status: Ux4gInputFieldStatus.defaultStatus, caption: null);
    }
    final isValid = Ux4gAadhaarInputField.validateAadhaar(_aadhaar);
    return isValid
        ? (
            status: Ux4gInputFieldStatus.success,
            caption: 'Aadhaar number looks valid',
          )
        : (
            status: Ux4gInputFieldStatus.error,
            caption: 'Invalid Aadhaar number. Please check and re-enter.',
          );
  }

  @override
  Widget build(BuildContext context) {
    final validation = _validate();
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 32),

                  const Text(
                    'Sign in with Aadhaar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Enter your 12-digit Aadhaar number',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Ux4gAadhaarInputField(
                    value: _aadhaar,
                    onValueChange: (v) => setState(() => _aadhaar = v),
                    label: 'Aadhaar Number',
                    placeholder: 'XXXX XXXX 1234',
                    // Match the placeholder typography used by the
                    // other SignIn patterns for visual consistency.
                    placeholderStyle: _placeholderStyle,
                    // Drive border color + caption icon from live
                    // Verhoeff validation done above.
                    status: validation.status,
                    caption: validation.caption,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Choose Authentication Method',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Ux4gRadioButton<String>(
                          value: 'otp',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v!),
                          label: 'Send OTP',
                          trailingIcon: Icons.phone_outlined,
                        ),
                      ),
                      Expanded(
                        child: Ux4gRadioButton<String>(
                          value: 'face',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v!),
                          label: 'Face Auth',
                          trailingIcon: Icons.face_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Ux4gButton(
                    text: 'Continue',
                    onPressed: () {},
                    // Only enable Continue once we have a valid 12-digit
                    // Aadhaar — the button automatically renders in its
                    // disabled style otherwise.
                    enabled: validation.status == Ux4gInputFieldStatus.success,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.lock_outline, size: 14, color: _mutedText),
                        SizedBox(width: 6),
                        Text(
                          'Your Aadhaar details are encrypted and secure',
                          style: TextStyle(fontSize: 12, color: _subtleText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// 4. Signed in success — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _SignedInSuccessMobileMockup extends StatefulWidget {
  const _SignedInSuccessMobileMockup();

  @override
  State<_SignedInSuccessMobileMockup> createState() =>
      _SignedInSuccessMobileMockupState();
}

class _SignedInSuccessMobileMockupState
    extends State<_SignedInSuccessMobileMockup> {
  // Brand greens — independent of theme so the success messaging always
  // reads as "success" regardless of how the host app is themed.
  static const _successDark = Ux4gPalette.green700;
  static const _successMid = Ux4gPalette.green;
  static const _successLight = Ux4gPalette.green100;

  Timer? _countdownTimer;
  int _secondsLeft = 3;

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          // Restart so the demo loops continuously inside Widgetbook.
          _secondsLeft = 3;
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  // Success badge — concentric circles + check icon.
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: _successLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: _successMid,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Signed in successfully!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _successDark,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'You are being redirected to your service',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 3-dot status using the design-system [Ux4gBadge.dot].
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ux4gBadge.dot(containerColor: primary),
                      const SizedBox(width: 8),
                      Ux4gBadge.dot(containerColor: primary),
                      const SizedBox(width: 8),
                      Ux4gBadge.dot(
                        containerColor: primary.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Text(
                    'Redirecting in $_secondsLeft seconds...',
                    style: const TextStyle(
                      fontSize: 13,
                      color: _mutedText,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Code snippets (shown in the docs "Code" tab so users can copy-paste).
// ───────────────────────────────────────────────────────────────────────

const _signInDefaultCode = r'''// Mobile-sized sign-in screen (360 x 760)
Container(
  width: 360,
  decoration: BoxDecoration(color: Colors.white),
  child: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign in to your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            SizedBox(height: 6),
            Text('Access your government services securely',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),

            Ux4gInputField(
              value: username,
              onValueChange: (v) => setState(() => username = v),
              label: 'Username',
              placeholder: 'Enter your username',
            ),
            SizedBox(height: 16),

            Ux4gInputField(
              value: password,
              onValueChange: (v) => setState(() => password = v),
              label: 'Password',
              placeholder: '...........',
              type: Ux4gInputFieldType.password,
            ),
            SizedBox(height: 16),

            // Error banner — design-system Ux4gStatusBanner.
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.errorLight,
              title: 'Username not found.',
              subtitle: 'Take action',
              margin: EdgeInsets.zero,
              padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
              titleStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400,
                color: Ux4gPalette.red800,
              ),
              subtitleStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: Ux4gPalette.red800,
              ),
              leadingIcon: Icon(Icons.error_outline,
                color: Ux4gPalette.red600, size: 20),
              trailingIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Ux4gPalette.red100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Attempt 1 of 5',
                  style: TextStyle(fontSize: 12,
                    color: Ux4gPalette.red800,
                    fontWeight: FontWeight.w500)),
              ),
            ),

            Ux4gButton(
              text: 'Send OTP',
              onPressed: () {},
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),

            Row(children: [
              Expanded(child: Divider()),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('OR')),
              Expanded(child: Divider()),
            ]),
            SizedBox(height: 16),

            Ux4gButton(
              text: 'Sign in with Aadhaar',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
          ],
        ),
      ),
    ],
  ),
)''';

const _enterOtpCode = r'''// Mobile-sized OTP screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 32),

          Text('Enter OTP',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 6),
          Text('Sent to +91 98765 XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // 6 OTP boxes — built-in 60s countdown + tap-to-resend.
          Ux4gOtpInput(
            key: ValueKey('otp_$resendNonce'),
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            boxSize: 44,
            gap: 8,
            showSeparator: false,
            captionVariant: Ux4gOtpCaptionVariant.resendTimer,
            captionLeadingText: "Didn't receive OTP?",
            captionTrailingText: 'Resend OTP',
            autoCountdownSeconds: 60,
            onCaptionTrailingTap: () {
              setState(() {
                otp = '';
                resendNonce++;
              });
            },
          ),
          SizedBox(height: 28),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
        ],
      ),
    ),
  ],
)''';

const _aadhaarCode = r'''// Mobile-sized Aadhaar sign-in screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 32),

          Text('Sign in with Aadhaar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 6),
          Text('Enter your 12-digit Aadhaar number',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // Live Verhoeff validation — only flag errors once all
          // 12 digits are entered so the user isn't yelled at while
          // they're still typing.
          (() {
            final digits = aadhaar.replaceAll(' ', '');
            final showResult = digits.length == 12;
            final isValid = showResult &&
                Ux4gAadhaarInputField.validateAadhaar(aadhaar);
            return Ux4gAadhaarInputField(
              value: aadhaar,
              onValueChange: (v) => setState(() => aadhaar = v),
              label: 'Aadhaar Number',
              placeholder: 'XXXX XXXX 1234',
              placeholderStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              status: !showResult
                  ? Ux4gInputFieldStatus.defaultStatus
                  : (isValid
                      ? Ux4gInputFieldStatus.success
                      : Ux4gInputFieldStatus.error),
              caption: !showResult
                  ? null
                  : (isValid
                      ? 'Aadhaar number looks valid'
                      : 'Invalid Aadhaar number. Please check and re-enter.'),
            );
          })(),
          SizedBox(height: 20),

          Text('Choose Authentication Method',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: Ux4gRadioButton<String>(
                value: 'otp',
                groupValue: method,
                onChanged: (v) => setState(() => method = v!),
                label: 'Send OTP',
                trailingIcon: Icons.phone_outlined,
              ),
            ),
            Expanded(
              child: Ux4gRadioButton<String>(
                value: 'face',
                groupValue: method,
                onChanged: (v) => setState(() => method = v!),
                label: 'Face Auth',
                trailingIcon: Icons.face_outlined,
              ),
            ),
          ]),
          SizedBox(height: 24),

          Ux4gButton(
            text: 'Continue',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
        ],
      ),
    ),
  ],
)''';

const _successCode = r'''// Mobile-sized success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        children: [
          // Success badge — concentric circles + check icon.
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(color: Ux4gPalette.green100, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: Ux4gPalette.green, shape: BoxShape.circle),
              child: Icon(Icons.check, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: 24),

          Text('Signed in successfully!',
            style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800,
              color: Ux4gPalette.green700,
            )),
          SizedBox(height: 8),
          Text('You are being redirected to your service',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 28),

          // 3-dot status using the design-system [Ux4gBadge.dot].
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ux4gBadge.dot(containerColor: Theme.of(context).colorScheme.primary),
              SizedBox(width: 8),
              Ux4gBadge.dot(containerColor: Theme.of(context).colorScheme.primary),
              SizedBox(width: 8),
              Ux4gBadge.dot(
                containerColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              ),
            ],
          ),
          SizedBox(height: 14),

          Text('Redirecting in 3 seconds...',
            style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// 5. Sign in account with Mobile No — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _SignInWithMobileMockup extends StatefulWidget {
  const _SignInWithMobileMockup();

  @override
  State<_SignInWithMobileMockup> createState() =>
      _SignInWithMobileMockupState();
}

class _SignInWithMobileMockupState extends State<_SignInWithMobileMockup> {
  String _mobile = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Access your government services securely',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Mobile input with +91 prefix ──
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.number,
                    prefixText: '+91',
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),

                  // ── Status banner — same pattern as Sign In screen ──
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title: 'Your status message goes here',
                    subtitle: 'Take action',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    subtitleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    leadingIcon: const Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.red600,
                      size: 20,
                    ),
                    trailingIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.red100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 1 of 5',
                        style: TextStyle(
                          fontSize: 12,
                          color: Ux4gPalette.red800,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Expanded(child: Divider(color: _border, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            color: _mutedText,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: _border, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Ux4gButton(
                    text: 'Sign in with Aadhaar',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 28),

                  const _RegisterLink(),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _signInWithMobileCode =
    r'''// Mobile-sized sign-in-with-mobile screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sign in to your account',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 6),
          Text('Access your government services securely',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // Mobile input with +91 prefix
          Ux4gInputField(
            value: mobile,
            onValueChange: (v) => setState(() => mobile = v),
            label: 'Mobile Number',
            placeholder: 'Enter mobile number',
            type: Ux4gInputFieldType.number,
            prefixText: '+91',
            maxLength: 10,
          ),
          SizedBox(height: 16),

          // Error banner — design-system Ux4gStatusBanner.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.errorLight,
            title: 'Your status message goes here',
            subtitle: 'Take action',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,
              color: Ux4gPalette.red800,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Ux4gPalette.red800,
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Ux4gPalette.red600, size: 20),
            trailingIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Ux4gPalette.red100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 1 of 5',
                style: TextStyle(fontSize: 12,
                  color: Ux4gPalette.red800,
                  fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: 20),

          Ux4gButton(
            text: 'Send OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          SizedBox(height: 16),

          Row(children: [
            Expanded(child: Divider()),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('OR')),
            Expanded(child: Divider()),
          ]),
          SizedBox(height: 16),

          Ux4gButton(
            text: 'Sign in with Aadhaar',
            onPressed: () {},
            variant: Ux4gButtonVariant.outline,
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          SizedBox(height: 28),

          Center(child: TextButton(
            onPressed: () {},
            child: Text('New user? Register here'),
          )),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Sign in to your account — Card-style variant
// (toggled via the [Variant] knob on signInDefaultComponent)
// ───────────────────────────────────────────────────────────────────────
class _SignInCardMockup extends StatefulWidget {
  const _SignInCardMockup();

  @override
  State<_SignInCardMockup> createState() => _SignInCardMockupState();
}

class _SignInCardMockupState extends State<_SignInCardMockup> {
  String _username = '';
  String _password = '';

  // Card-variant background — soft purple tint behind the white card.
  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),

          // Soft purple background section that hosts the card. We use
          // a Column-with-Expanded so the footer can stay pinned to the
          // bottom of the soft-purple section while the card area
          // scrolls if its content overflows on smaller frames.
          Expanded(
            child: Container(
              color: _cardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign in to your account',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Access your government services securely',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Username input.
                            Ux4gInputField(
                              value: _username,
                              onValueChange: (v) =>
                                  setState(() => _username = v),
                              label: 'Username',
                              placeholder: 'Enter your username',
                              placeholderStyle: _placeholderStyle,
                            ),
                            const SizedBox(height: 16),

                            // Password input.
                            Ux4gInputField(
                              value: _password,
                              onValueChange: (v) =>
                                  setState(() => _password = v),
                              label: 'Password',
                              placeholder: '...........',
                              placeholderStyle: _placeholderStyle,
                              type: Ux4gInputFieldType.password,
                            ),
                            const SizedBox(height: 12),

                            // Error banner.
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.errorLight,
                              title: 'Username not found.',
                              subtitle: 'Take action',
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                12,
                                10,
                                12,
                              ),
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Ux4gPalette.red800,
                                height: 1.3,
                              ),
                              subtitleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Ux4gPalette.red800,
                                height: 1.3,
                              ),
                              leadingIcon: const Icon(
                                Icons.error_outline,
                                color: Ux4gPalette.red600,
                                size: 20,
                              ),
                              trailingIcon: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Ux4gPalette.red100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Attempt 1 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Ux4gPalette.red800,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            Ux4gButton(
                              text: 'Send OTP',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 12),

                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(color: _border, thickness: 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _mutedText,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: _border, thickness: 1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            Ux4gButton(
                              text: 'Sign in with Aadhaar',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 16),

                            const _RegisterLink(fontSize: 15),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer pinned to the bottom of the soft-purple
                  // section, just like the default variant.
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signInCardCode = r'''// Mobile-sized card-style sign-in (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    // Soft-purple section. Card scrolls; footer stays pinned at the bottom.
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sign in to your account',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      SizedBox(height: 6),
                      Text('Access your government services securely',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                      SizedBox(height: 20),

                      Ux4gInputField(
                        value: username,
                        onValueChange: (v) => setState(() => username = v),
                        label: 'Username',
                        placeholder: 'Enter your username',
                      ),
                      SizedBox(height: 16),

                      Ux4gInputField(
                        value: password,
                        onValueChange: (v) => setState(() => password = v),
                        label: 'Password',
                        placeholder: '...........',
                        type: Ux4gInputFieldType.password,
                      ),
                      SizedBox(height: 12),

                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.errorLight,
                        title: 'Username not found.',
                        subtitle: 'Take action',
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                        leadingIcon: Icon(Icons.error_outline,
                          color: Ux4gPalette.red600, size: 20),
                        trailingIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Ux4gPalette.red100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Attempt 1 of 5',
                            style: TextStyle(fontSize: 12,
                              color: Ux4gPalette.red800,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(height: 16),

                      Ux4gButton(
                        text: 'Send OTP',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 12),

                      Row(children: [
                        Expanded(child: Divider()),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR')),
                        Expanded(child: Divider()),
                      ]),
                      SizedBox(height: 12),

                      Ux4gButton(
                        text: 'Sign in with Aadhaar',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 16),

                      Center(child: TextButton(
                        onPressed: () {},
                        child: Text('New user? Register here'),
                      )),
                    ],
                  ),
                ),
              ),
            ),

            // "Powered by - Digital India" pinned to the bottom.
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Sign in account with Mobile No — Card-style variant
// (toggled via the [Variant] knob on signInWithMobileComponent)
// ───────────────────────────────────────────────────────────────────────
class _SignInWithMobileCardMockup extends StatefulWidget {
  const _SignInWithMobileCardMockup();

  @override
  State<_SignInWithMobileCardMockup> createState() =>
      _SignInWithMobileCardMockupState();
}

class _SignInWithMobileCardMockupState
    extends State<_SignInWithMobileCardMockup> {
  String _mobile = '';

  // Same soft-purple background tint used by the username/password
  // card variant so both feel like the same family.
  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),

          // Soft purple section. Card scrolls; footer stays pinned at
          // the bottom of the purple area.
          Expanded(
            child: Container(
              color: _cardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign in to your account',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Access your government services securely',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Mobile input with +91 prefix.
                            Ux4gInputField(
                              value: _mobile,
                              onValueChange: (v) => setState(() => _mobile = v),
                              label: 'Mobile Number',
                              placeholder: 'Enter mobile number',
                              placeholderStyle: _placeholderStyle,
                              type: Ux4gInputFieldType.number,
                              prefixText: '+91',
                              maxLength: 10,
                            ),
                            const SizedBox(height: 12),

                            // Error banner.
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.errorLight,
                              title: 'Your status message goes here',
                              subtitle: 'Take action',
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                12,
                                10,
                                12,
                              ),
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Ux4gPalette.red800,
                                height: 1.3,
                              ),
                              subtitleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Ux4gPalette.red800,
                                height: 1.3,
                              ),
                              leadingIcon: const Icon(
                                Icons.error_outline,
                                color: Ux4gPalette.red600,
                                size: 20,
                              ),
                              trailingIcon: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Ux4gPalette.red100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Attempt 1 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Ux4gPalette.red800,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            Ux4gButton(
                              text: 'Send OTP',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 12),

                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(color: _border, thickness: 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _mutedText,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: _border, thickness: 1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            Ux4gButton(
                              text: 'Sign in with Aadhaar',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 16),

                            const _RegisterLink(fontSize: 15),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer pinned at the bottom of the soft-purple section.
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signInWithMobileCardCode =
    r'''// Mobile-sized card-style sign-in with mobile number (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    // Soft-purple section. Card scrolls; footer stays pinned at the bottom.
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sign in to your account',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      SizedBox(height: 6),
                      Text('Access your government services securely',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                      SizedBox(height: 20),

                      // Mobile input with +91 prefix.
                      Ux4gInputField(
                        value: mobile,
                        onValueChange: (v) => setState(() => mobile = v),
                        label: 'Mobile Number',
                        placeholder: 'Enter mobile number',
                        type: Ux4gInputFieldType.number,
                        prefixText: '+91',
                        maxLength: 10,
                      ),
                      SizedBox(height: 12),

                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.errorLight,
                        title: 'Your status message goes here',
                        subtitle: 'Take action',
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                        leadingIcon: Icon(Icons.error_outline,
                          color: Ux4gPalette.red600, size: 20),
                        trailingIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Ux4gPalette.red100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Attempt 1 of 5',
                            style: TextStyle(fontSize: 12,
                              color: Ux4gPalette.red800,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SizedBox(height: 16),

                      Ux4gButton(
                        text: 'Send OTP',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 12),

                      Row(children: [
                        Expanded(child: Divider()),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR')),
                        Expanded(child: Divider()),
                      ]),
                      SizedBox(height: 12),

                      Ux4gButton(
                        text: 'Sign in with Aadhaar',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 16),

                      Center(child: TextButton(
                        onPressed: () {},
                        child: Text('New user? Register here'),
                      )),
                    ],
                  ),
                ),
              ),
            ),

            // "Powered by - Digital India" pinned to the bottom.
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Enter OTP — Card-style variant
// (toggled via the [Variant] knob on signInEnterOtpComponent)
// ───────────────────────────────────────────────────────────────────────
class _EnterOtpCardMockup extends StatefulWidget {
  const _EnterOtpCardMockup();

  @override
  State<_EnterOtpCardMockup> createState() => _EnterOtpCardMockupState();
}

class _EnterOtpCardMockupState extends State<_EnterOtpCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _cardBg,
              child: Column(
                children: [
                  // White card holds the OTP form. Sits at the top of the
                  // soft-purple area; the area below stays empty so the
                  // footer can pin to the bottom — exactly like the
                  // reference image.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Sent to +91 98765 XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            key: ValueKey('otp_card_$_resendNonce'),
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                            captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                            captionLeadingText: "Didn't receive OTP?",
                            captionTrailingText: 'Resend OTP',
                            autoCountdownSeconds: 60,
                            onCaptionTrailingTap: () {
                              setState(() {
                                _otp = '';
                                _resendNonce++;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 12),

                          const Center(
                            child: Text(
                              'OTP is valid for 10 minutes',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Empty soft-purple area between card and footer —
                  // matches the reference image where the card hugs
                  // the top and the footer sits at the bottom.
                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _enterOtpCardCode = r'''// Mobile-sized card-style OTP screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('Enter OTP',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 6),
                    Text('Sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('otp_$resendNonce'),
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      boxSize: 44,
                      gap: 8,
                      showSeparator: false,
                      captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                      captionLeadingText: "Didn't receive OTP?",
                      captionTrailingText: 'Resend OTP',
                      autoCountdownSeconds: 60,
                      onCaptionTrailingTap: () {
                        setState(() {
                          otp = '';
                          resendNonce++;
                        });
                      },
                    ),
                    SizedBox(height: 24),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    SizedBox(height: 12),

                    Center(child: Text('OTP is valid for 10 minutes',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)))),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Sign in with Aadhaar — Card-style variant
// (toggled via the [Variant] knob on signInAadhaarComponent)
// ───────────────────────────────────────────────────────────────────────
class _SignInAadhaarCardMockup extends StatefulWidget {
  const _SignInAadhaarCardMockup();

  @override
  State<_SignInAadhaarCardMockup> createState() =>
      _SignInAadhaarCardMockupState();
}

class _SignInAadhaarCardMockupState extends State<_SignInAadhaarCardMockup> {
  String _aadhaar = '';
  String _method = 'otp';

  static const _cardBg = Color(0xFFE9E5FF);

  ({Ux4gInputFieldStatus status, String? caption}) _validate() {
    final digits = _aadhaar.replaceAll(' ', '');
    if (digits.length < 12) {
      return (status: Ux4gInputFieldStatus.defaultStatus, caption: null);
    }
    final isValid = Ux4gAadhaarInputField.validateAadhaar(_aadhaar);
    return isValid
        ? (
            status: Ux4gInputFieldStatus.success,
            caption: 'Aadhaar number looks valid',
          )
        : (
            status: Ux4gInputFieldStatus.error,
            caption: 'Invalid Aadhaar number. Please check and re-enter.',
          );
  }

  @override
  Widget build(BuildContext context) {
    final validation = _validate();

    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _cardBg,
              child: Column(
                children: [
                  // White card hugs the top of the soft-purple area.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'Sign in with Aadhaar',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Enter your 12-digit Aadhaar number',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gAadhaarInputField(
                            value: _aadhaar,
                            onValueChange: (v) => setState(() => _aadhaar = v),
                            label: 'Aadhaar Number',
                            placeholder: 'XXXX XXXX 1234',
                            placeholderStyle: _placeholderStyle,
                            status: validation.status,
                            caption: validation.caption,
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Choose Authentication Method',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: Ux4gRadioButton<String>(
                                  value: 'otp',
                                  groupValue: _method,
                                  onChanged: (v) =>
                                      setState(() => _method = v!),
                                  label: 'Send OTP',
                                  trailingIcon: Icons.phone_outlined,
                                ),
                              ),
                              Expanded(
                                child: Ux4gRadioButton<String>(
                                  value: 'face',
                                  groupValue: _method,
                                  onChanged: (v) =>
                                      setState(() => _method = v!),
                                  label: 'Face Auth',
                                  trailingIcon: Icons.face_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Continue',
                            onPressed: () {},
                            enabled:
                                validation.status ==
                                Ux4gInputFieldStatus.success,
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Encrypted hint sits *outside* the card, on the
                  // soft-purple area — exactly like the reference image.
                  const SizedBox(height: 14),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.lock_outline, size: 14, color: _mutedText),
                        SizedBox(width: 6),
                        Text(
                          'Your Aadhaar details are encrypted and secure',
                          style: TextStyle(fontSize: 12, color: _subtleText),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _aadhaarCardCode =
    r'''// Mobile-sized card-style Aadhaar sign-in (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('Sign in with Aadhaar',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 6),
                    Text('Enter your 12-digit Aadhaar number',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    // Live Verhoeff validation — see Default variant for details.
                    Ux4gAadhaarInputField(
                      value: aadhaar,
                      onValueChange: (v) => setState(() => aadhaar = v),
                      label: 'Aadhaar Number',
                      placeholder: 'XXXX XXXX 1234',
                    ),
                    SizedBox(height: 16),

                    Text('Choose Authentication Method',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: Ux4gRadioButton<String>(
                          value: 'otp',
                          groupValue: method,
                          onChanged: (v) => setState(() => method = v!),
                          label: 'Send OTP',
                          trailingIcon: Icons.phone_outlined,
                        ),
                      ),
                      Expanded(
                        child: Ux4gRadioButton<String>(
                          value: 'face',
                          groupValue: method,
                          onChanged: (v) => setState(() => method = v!),
                          label: 'Face Auth',
                          trailingIcon: Icons.face_outlined,
                        ),
                      ),
                    ]),
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),

            // Encrypted hint sits *outside* the card, on the soft-purple area.
            SizedBox(height: 14),
            Center(child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline, size: 14, color: Color(0xFF9CA3AF)),
                SizedBox(width: 6),
                Text('Your Aadhaar details are encrypted and secure',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              ],
            )),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Signed in success — Card-style variant
// (toggled via the [Variant] knob on signInSuccessComponent)
// ───────────────────────────────────────────────────────────────────────
class _SignedInSuccessCardMockup extends StatefulWidget {
  const _SignedInSuccessCardMockup();

  @override
  State<_SignedInSuccessCardMockup> createState() =>
      _SignedInSuccessCardMockupState();
}

class _SignedInSuccessCardMockupState
    extends State<_SignedInSuccessCardMockup> {
  // Brand greens shared with the flat success variant.
  static const _successMid = Ux4gPalette.green;
  static const _successLight = Ux4gPalette.green100;
  static const _successDark = Ux4gPalette.green700;

  static const _cardBg = Color(0xFFE9E5FF);

  Timer? _countdownTimer;
  int _secondsLeft = 3;

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _secondsLeft = 3; // loop for the demo
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  // White card hugs the top of the soft-purple area.
                  // Full-bleed horizontally — only top spacing,
                  // no left/right outer padding.
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Success badge — concentric circles + check.
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: _successLight,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: _successMid,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            'Signed in successfully!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _successDark,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'You are being redirected to your service',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // 3-dot status using the design-system [Ux4gBadge.dot].
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Ux4gBadge.dot(containerColor: primary),
                              const SizedBox(width: 8),
                              Ux4gBadge.dot(containerColor: primary),
                              const SizedBox(width: 8),
                              Ux4gBadge.dot(
                                containerColor: primary.withValues(alpha: 0.4),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          Text(
                            'Redirecting in $_secondsLeft seconds...',
                            style: const TextStyle(
                              fontSize: 13,
                              color: _mutedText,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signInSuccessCardCode =
    r'''// Mobile-sized card-style success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Success badge — concentric circles + check.
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        color: Ux4gPalette.green100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(height: 24),

                    Text('Signed in successfully!',
                      style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w800,
                        color: Ux4gPalette.green700,
                      )),
                    SizedBox(height: 8),
                    Text('You are being redirected to your service',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                      textAlign: TextAlign.center),
                    SizedBox(height: 24),

                    // 3-dot status using the design-system [Ux4gBadge.dot].
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ux4gBadge.dot(containerColor: Theme.of(context).colorScheme.primary),
                        SizedBox(width: 8),
                        Ux4gBadge.dot(containerColor: Theme.of(context).colorScheme.primary),
                        SizedBox(width: 8),
                        Ux4gBadge.dot(
                          containerColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),

                    Text('Redirecting in 3 seconds...',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify your mobile number — mobile mockup (OTP Verification folder)
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileOtpMockup extends StatefulWidget {
  const _VerifyMobileOtpMockup();

  @override
  State<_VerifyMobileOtpMockup> createState() => _VerifyMobileOtpMockupState();
}

class _VerifyMobileOtpMockupState extends State<_VerifyMobileOtpMockup> {
  String _otp = '';

  // Bumped every time the user taps "Resend OTP" — used as a [ValueKey]
  // for the OTP input so it remounts and restarts its built-in countdown.
  int _resendNonce = 0;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title (wraps to 2 lines as per the reference) ──
                  const Text(
                    'Verify your mobile\nnumber',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'OTP sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes via the design-system component.
                  // Same resend-timer mechanics as the Enter OTP pattern.
                  Ux4gOtpInput(
                    key: ValueKey('verify_mobile_otp_$_resendNonce'),
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                    captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                    captionLeadingText: "Didn't receive OTP?",
                    captionTrailingText: 'Resend OTP',
                    autoCountdownSeconds: 60,
                    onCaptionTrailingTap: () {
                      setState(() {
                        _otp = '';
                        _resendNonce++;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 8),

                  // "Change mobile number" — ghost-style link button.
                  Center(
                    child: Ux4gButton(
                      text: 'Change mobile number',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _verifyMobileOtpCode =
    r'''// Mobile-sized verify-mobile OTP screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 56, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verify your mobile\nnumber',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('OTP sent to +91 98765 XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // 6 OTP boxes via the design-system component.
          Ux4gOtpInput(
            key: ValueKey('verify_mobile_otp_$resendNonce'),
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            boxSize: 44,
            gap: 8,
            showSeparator: false,
            captionVariant: Ux4gOtpCaptionVariant.resendTimer,
            captionLeadingText: "Didn't receive OTP?",
            captionTrailingText: 'Resend OTP',
            autoCountdownSeconds: 60,
            onCaptionTrailingTap: () {
              setState(() {
                otp = '';
                resendNonce++;
              });
            },
          ),
          SizedBox(height: 24),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          SizedBox(height: 8),

          // "Change mobile number" — ghost-style link button.
          Center(child: Ux4gButton(
            text: 'Change mobile number',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
          )),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify your mobile number — Card-style variant
// (toggled via the [Variant] knob on otpVerifyMobileComponent)
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileOtpCardMockup extends StatefulWidget {
  const _VerifyMobileOtpCardMockup();

  @override
  State<_VerifyMobileOtpCardMockup> createState() =>
      _VerifyMobileOtpCardMockupState();
}

class _VerifyMobileOtpCardMockupState
    extends State<_VerifyMobileOtpCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  // Soft-purple gap above the card — image shows the
                  // card sitting in the upper-middle of the body, not
                  // flush at the top.
                  const SizedBox(height: 56),

                  // White card with the OTP form.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Verify your mobile\nnumber',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'OTP sent to +91 98765 XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            key: ValueKey(
                              'verify_mobile_otp_card_$_resendNonce',
                            ),
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                            captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                            captionLeadingText: "Didn't receive OTP?",
                            captionTrailingText: 'Resend OTP',
                            autoCountdownSeconds: 60,
                            onCaptionTrailingTap: () {
                              setState(() {
                                _otp = '';
                                _resendNonce++;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 4),

                          Center(
                            child: Ux4gButton(
                              text: 'Change mobile number',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.ghost,
                              size: Ux4gButtonSize.small,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _verifyMobileOtpCardCode =
    r'''// Mobile-sized card-style verify-mobile OTP screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 56),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verify your mobile\nnumber',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('OTP sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('verify_mobile_otp_$resendNonce'),
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      boxSize: 44,
                      gap: 8,
                      showSeparator: false,
                      captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                      captionLeadingText: "Didn't receive OTP?",
                      captionTrailingText: 'Resend OTP',
                      autoCountdownSeconds: 60,
                      onCaptionTrailingTap: () {
                        setState(() {
                          otp = '';
                          resendNonce++;
                        });
                      },
                    ),
                    SizedBox(height: 24),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    SizedBox(height: 4),

                    Center(child: Ux4gButton(
                      text: 'Change mobile number',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                    )),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with voice fallback — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileVoiceMockup extends StatefulWidget {
  const _VerifyMobileVoiceMockup();

  @override
  State<_VerifyMobileVoiceMockup> createState() =>
      _VerifyMobileVoiceMockupState();
}

class _VerifyMobileVoiceMockupState extends State<_VerifyMobileVoiceMockup> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 24),

                  // ── 2-line title ──
                  const Text(
                    'Verify your mobile\nnumber',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'OTP sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes — caption is in [resendAction] mode so
                  // "Resend OTP" appears as a tap-able link (the timer
                  // has already expired in this state).
                  Ux4gOtpInput(
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                    captionVariant: Ux4gOtpCaptionVariant.resendAction,
                    captionLeadingText: "Didn't receive OTP?",
                    captionTrailingText: 'Resend OTP',
                    onCaptionTrailingTap: () {
                      setState(() {
                        _otp = '';
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),

                  // Secondary action — voice-call fallback for users
                  // who couldn't receive the SMS.
                  Ux4gButton(
                    text: 'Get OTP via voice call',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    leadingIcon: Icons.phone_outlined,
                    iconSize: 18,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _verifyVoiceFallbackCode =
    r'''// Mobile-sized verify-mobile screen with voice-call fallback (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 24),

          Text('Verify your mobile\nnumber',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('OTP sent to +91 98765 XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // 6 OTP boxes with the resend caption in its expired
          // (action) state so "Resend OTP" is immediately tap-able.
          Ux4gOtpInput(
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            boxSize: 44,
            gap: 8,
            showSeparator: false,
            captionVariant: Ux4gOtpCaptionVariant.resendAction,
            captionLeadingText: "Didn't receive OTP?",
            captionTrailingText: 'Resend OTP',
            onCaptionTrailingTap: () => setState(() => otp = ''),
          ),
          SizedBox(height: 24),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          SizedBox(height: 12),

          // Voice-call fallback CTA.
          Ux4gButton(
            text: 'Get OTP via voice call',
            onPressed: () {},
            variant: Ux4gButtonVariant.outline,
            size: Ux4gButtonSize.large,
            leadingIcon: Icons.phone_outlined,
            width: double.infinity,
          ),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with voice fallback — Card-style variant
// (toggled via the [Variant] knob on otpVerifyVoiceComponent)
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileVoiceCardMockup extends StatefulWidget {
  const _VerifyMobileVoiceCardMockup();

  @override
  State<_VerifyMobileVoiceCardMockup> createState() =>
      _VerifyMobileVoiceCardMockupState();
}

class _VerifyMobileVoiceCardMockupState
    extends State<_VerifyMobileVoiceCardMockup> {
  String _otp = '';

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  // White card hugs the top of the soft-purple area.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'Verify your mobile\nnumber',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'OTP sent to +91 98765 XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Caption already in expired/action state so
                          // "Resend OTP" is immediately tap-able.
                          Ux4gOtpInput(
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                            captionVariant: Ux4gOtpCaptionVariant.resendAction,
                            captionLeadingText: "Didn't receive OTP?",
                            captionTrailingText: 'Resend OTP',
                            onCaptionTrailingTap: () {
                              setState(() => _otp = '');
                            },
                          ),
                          const SizedBox(height: 24),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 12),

                          Ux4gButton(
                            text: 'Get OTP via voice call',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
                            leadingIcon: Icons.phone_outlined,
                            iconSize: 18,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _verifyVoiceFallbackCardCode =
    r'''// Mobile-sized card-style verify-mobile screen with voice-call fallback (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('Verify your mobile\nnumber',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('OTP sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      boxSize: 44,
                      gap: 8,
                      showSeparator: false,
                      captionVariant: Ux4gOtpCaptionVariant.resendAction,
                      captionLeadingText: "Didn't receive OTP?",
                      captionTrailingText: 'Resend OTP',
                      onCaptionTrailingTap: () => setState(() => otp = ''),
                    ),
                    SizedBox(height: 24),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    SizedBox(height: 12),

                    Ux4gButton(
                      text: 'Get OTP via voice call',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      leadingIcon: Icons.phone_outlined,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with attempt warning — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileAttemptWarningMockup extends StatefulWidget {
  const _VerifyMobileAttemptWarningMockup();

  @override
  State<_VerifyMobileAttemptWarningMockup> createState() =>
      _VerifyMobileAttemptWarningMockupState();
}

class _VerifyMobileAttemptWarningMockupState
    extends State<_VerifyMobileAttemptWarningMockup> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 24),

                  const Text(
                    'Verify your mobile\nnumber',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'OTP sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes — caption suppressed since the warning
                  // banner below carries the resend message.
                  Ux4gOtpInput(
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                  const SizedBox(height: 16),

                  // Warning banner — uses the design-system component
                  // with warningLight variant and an Attempt pill on
                  // the trailing side.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title: 'Incorrect OTP',
                    subtitle: '1 more incorrect entry\nbefore 30-min lockout',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.secondary800,
                      height: 1.3,
                    ),
                    subtitleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.secondary800,
                      height: 1.3,
                    ),
                    leadingIcon: const Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.secondary600,
                      size: 20,
                    ),
                    trailingIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.secondary100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 1 of 3',
                        style: TextStyle(
                          fontSize: 12,
                          color: Ux4gPalette.secondary800,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _verifyAttemptWarningCode =
    r'''// Mobile-sized verify-mobile screen with attempt-warning banner (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 24),

          Text('Verify your mobile\nnumber',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('OTP sent to +91 98765 XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          Ux4gOtpInput(
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            boxSize: 44,
            gap: 8,
            showSeparator: false,
          ),
          SizedBox(height: 16),

          // Warning banner — design-system Ux4gStatusBanner.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.warningLight,
            title: 'Incorrect OTP',
            subtitle: '1 more incorrect entry\nbefore 30-min lockout',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,
              color: Ux4gPalette.secondary800,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Ux4gPalette.secondary800,
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Ux4gPalette.secondary600, size: 20),
            trailingIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Ux4gPalette.secondary100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 1 of 3',
                style: TextStyle(fontSize: 12,
                  color: Ux4gPalette.secondary800,
                  fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: 20),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with attempt warning — Card-style variant
// (toggled via the [Variant] knob on otpVerifyAttemptWarningComponent)
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileAttemptWarningCardMockup extends StatefulWidget {
  const _VerifyMobileAttemptWarningCardMockup();

  @override
  State<_VerifyMobileAttemptWarningCardMockup> createState() =>
      _VerifyMobileAttemptWarningCardMockupState();
}

class _VerifyMobileAttemptWarningCardMockupState
    extends State<_VerifyMobileAttemptWarningCardMockup> {
  String _otp = '';

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  // White card hugs the top of the soft-purple area.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'Verify your mobile\nnumber',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'OTP sent to +91 98765 XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                          ),
                          const SizedBox(height: 16),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.warningLight,
                            title: 'Incorrect OTP',
                            subtitle:
                                '1 more incorrect entry\nbefore 30-min lockout',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.secondary800,
                              height: 1.3,
                            ),
                            subtitleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Ux4gPalette.secondary800,
                              height: 1.3,
                            ),
                            leadingIcon: const Icon(
                              Icons.error_outline,
                              color: Ux4gPalette.secondary600,
                              size: 20,
                            ),
                            trailingIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Ux4gPalette.secondary100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Attempt 1 of 3',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Ux4gPalette.secondary800,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _verifyAttemptWarningCardCode =
    r'''// Mobile-sized card-style verify-mobile screen with attempt-warning (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('Verify your mobile\nnumber',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('OTP sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      boxSize: 44,
                      gap: 8,
                      showSeparator: false,
                    ),
                    SizedBox(height: 16),

                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Incorrect OTP',
                      subtitle: '1 more incorrect entry\nbefore 30-min lockout',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                      titleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400,
                        color: Ux4gPalette.secondary800,
                      ),
                      subtitleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700,
                        color: Ux4gPalette.secondary800,
                      ),
                      leadingIcon: Icon(Icons.error_outline,
                        color: Ux4gPalette.secondary600, size: 20),
                      trailingIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Ux4gPalette.secondary100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Attempt 1 of 3',
                          style: TextStyle(fontSize: 12,
                            color: Ux4gPalette.secondary800,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with last-attempt warning — mobile mockup
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileLastAttemptMockup extends StatefulWidget {
  const _VerifyMobileLastAttemptMockup();

  @override
  State<_VerifyMobileLastAttemptMockup> createState() =>
      _VerifyMobileLastAttemptMockupState();
}

class _VerifyMobileLastAttemptMockupState
    extends State<_VerifyMobileLastAttemptMockup> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 24),

                  const Text(
                    'Verify your mobile\nnumber',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'OTP sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Ux4gOtpInput(
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                  const SizedBox(height: 16),

                  // Error-styled banner — escalated from warning since
                  // this is the final attempt before lockout.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title: 'Incorrect OTP',
                    subtitle:
                        'This is your last attempt\nbefore a 30-min lockout',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    subtitleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    leadingIcon: const Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.red600,
                      size: 20,
                    ),
                    trailingIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.red100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 2 of 3',
                        style: TextStyle(
                          fontSize: 12,
                          color: Ux4gPalette.red800,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _verifyLastAttemptCode =
    r'''// Mobile-sized verify-mobile screen on the FINAL attempt (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 24),

          Text('Verify your mobile\nnumber',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('OTP sent to +91 98765 XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          Ux4gOtpInput(
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            boxSize: 44,
            gap: 8,
            showSeparator: false,
          ),
          SizedBox(height: 16),

          // Error-styled banner — final attempt before lockout.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.errorLight,
            title: 'Incorrect OTP',
            subtitle: 'This is your last attempt\nbefore a 30-min lockout',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,
              color: Ux4gPalette.red800,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Ux4gPalette.red800,
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Ux4gPalette.red600, size: 20),
            trailingIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Ux4gPalette.red100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 2 of 3',
                style: TextStyle(fontSize: 12,
                  color: Ux4gPalette.red800,
                  fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: 20),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile with last-attempt warning — Card-style variant
// ───────────────────────────────────────────────────────────────────────
class _VerifyMobileLastAttemptCardMockup extends StatefulWidget {
  const _VerifyMobileLastAttemptCardMockup();

  @override
  State<_VerifyMobileLastAttemptCardMockup> createState() =>
      _VerifyMobileLastAttemptCardMockupState();
}

class _VerifyMobileLastAttemptCardMockupState
    extends State<_VerifyMobileLastAttemptCardMockup> {
  String _otp = '';

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'Verify your mobile\nnumber',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'OTP sent to +91 98765 XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                          ),
                          const SizedBox(height: 16),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.errorLight,
                            title: 'Incorrect OTP',
                            subtitle:
                                'This is your last attempt\nbefore a 30-min lockout',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.red800,
                              height: 1.3,
                            ),
                            subtitleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Ux4gPalette.red800,
                              height: 1.3,
                            ),
                            leadingIcon: const Icon(
                              Icons.error_outline,
                              color: Ux4gPalette.red600,
                              size: 20,
                            ),
                            trailingIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Ux4gPalette.red100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Attempt 2 of 3',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Ux4gPalette.red800,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _verifyLastAttemptCardCode =
    r'''// Mobile-sized card-style verify-mobile screen on the FINAL attempt (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('Verify your mobile\nnumber',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('OTP sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      boxSize: 44,
                      gap: 8,
                      showSeparator: false,
                    ),
                    SizedBox(height: 16),

                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.errorLight,
                      title: 'Incorrect OTP',
                      subtitle: 'This is your last attempt\nbefore a 30-min lockout',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                      titleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400,
                        color: Ux4gPalette.red800,
                      ),
                      subtitleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700,
                        color: Ux4gPalette.red800,
                      ),
                      leadingIcon: Icon(Icons.error_outline,
                        color: Ux4gPalette.red600, size: 20),
                      trailingIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Ux4gPalette.red100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Attempt 2 of 3',
                          style: TextStyle(fontSize: 12,
                            color: Ux4gPalette.red800,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile — account locked (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _VerifyAccountLockedMockup extends StatefulWidget {
  const _VerifyAccountLockedMockup();

  @override
  State<_VerifyAccountLockedMockup> createState() =>
      _VerifyAccountLockedMockupState();
}

class _VerifyAccountLockedMockupState
    extends State<_VerifyAccountLockedMockup> {
  // Lock-state palette.
  static const _lockBadgeBg = Ux4gPalette.red100;
  static const _lockIconColor = Ux4gPalette.red600;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 24),

                  // ── Lock badge ──
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: _lockBadgeBg,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.lock,
                        color: _lockIconColor,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Center(
                    child: Text(
                      'Too many incorrect\nattempts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: _titleColor,
                        height: 1.2,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 disabled OTP boxes with the [locked] caption — the
                  // design-system component renders "🔒 Locked for mm:ss"
                  // on the leading side and "Resend OTP" on the trailing
                  // side automatically.
                  Ux4gOtpInput(
                    length: 6,
                    value: '',
                    onChanged: (_) {},
                    enabled: false,
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                    captionVariant: Ux4gOtpCaptionVariant.locked,
                    captionLeadingText: 'Locked for 28:43',
                    captionTrailingText: 'Resend OTP',
                  ),
                  const SizedBox(height: 12),

                  // ── Error banner ──
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title:
                        'Account locked. Please wait for the\n'
                        'countdown to complete',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.red800,
                      height: 1.35,
                    ),
                    leadingIcon: const Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.red600,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Support link ──
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Need help?  ',
                          style: TextStyle(
                            fontSize: 14,
                            color: _subtleText,
                            height: 1.3,
                          ),
                        ),
                        Ux4gButton(
                          text: 'Call 1800-XXX-XXXX',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.ghost,
                          size: Ux4gButtonSize.small,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _verifyAccountLockedCode =
    r'''// Mobile-sized account-locked screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 24),

          // Red lock badge.
          Center(child: Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: Ux4gPalette.red100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.lock, color: Ux4gPalette.red600, size: 28),
          )),
          SizedBox(height: 16),

          Center(child: Text('Too many incorrect\nattempts',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
          SizedBox(height: 24),

          // Disabled OTP field with built-in "Locked for mm:ss" caption.
          Ux4gOtpInput(
            length: 6,
            value: '',
            onChanged: (_) {},
            enabled: false,
            boxSize: 44,
            gap: 8,
            showSeparator: false,
            captionVariant: Ux4gOtpCaptionVariant.locked,
            captionLeadingText: 'Locked for 28:43',
            captionTrailingText: 'Resend OTP',
          ),
          SizedBox(height: 12),

          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.errorLight,
            title: 'Account locked. Please wait for the\\ncountdown to complete',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,
              color: Ux4gPalette.red800,
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Ux4gPalette.red600, size: 20),
          ),
          SizedBox(height: 20),

          Center(child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('Need help?  ',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
              Ux4gButton(
                text: 'Call 1800-XXX-XXXX',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.small,
              ),
            ],
          )),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Verify mobile — account locked (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _VerifyAccountLockedCardMockup extends StatefulWidget {
  const _VerifyAccountLockedCardMockup();

  @override
  State<_VerifyAccountLockedCardMockup> createState() =>
      _VerifyAccountLockedCardMockupState();
}

class _VerifyAccountLockedCardMockupState
    extends State<_VerifyAccountLockedCardMockup> {
  static const _cardBg = Color(0xFFE9E5FF);
  static const _lockBadgeBg = Ux4gPalette.red100;
  static const _lockIconColor = Ux4gPalette.red600;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 16),

                          Center(
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: _lockBadgeBg,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.lock,
                                color: _lockIconColor,
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Center(
                            child: Text(
                              'Too many incorrect\nattempts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            length: 6,
                            value: '',
                            onChanged: (_) {},
                            enabled: false,
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                            captionVariant: Ux4gOtpCaptionVariant.locked,
                            captionLeadingText: 'Locked for 28:43',
                            captionTrailingText: 'Resend OTP',
                          ),
                          const SizedBox(height: 12),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.errorLight,
                            title:
                                'Account locked. Please wait for the\ncountdown to complete',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.red800,
                              height: 1.35,
                            ),
                            leadingIcon: const Icon(
                              Icons.error_outline,
                              color: Ux4gPalette.red600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Center(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  'Need help?  ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _subtleText,
                                    height: 1.3,
                                  ),
                                ),
                                Ux4gButton(
                                  text: 'Call 1800-XXX-XXXX',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.ghost,
                                  size: Ux4gButtonSize.small,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _verifyAccountLockedCardCode =
    r'''// Mobile-sized card-style account-locked screen (360 x 760)
// Same content as the flat variant, wrapped in a soft-purple section
// with a white rounded card hugging the top.
Column(
  children: [
    Ux4gAppHeader(/* ... */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [/* subtle shadow */],
                ),
                child: Column(/* same content as flat variant */),
              ),
            ),
            Spacer(),
            // "Powered by - Digital India" footer pinned at the bottom.
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP verified — success (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _OtpVerifiedSuccessMockup extends StatelessWidget {
  const _OtpVerifiedSuccessMockup();

  // Brand greens — independent of theme so the success messaging
  // always reads as "success" regardless of how the host app is themed.
  static const _successMid = Ux4gPalette.green;
  static const _successLight = Ux4gPalette.green100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
              child: Column(
                children: [
                  // Success badge — same concentric-circles as the
                  // "Signed in success" pattern.
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: _successLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: _successMid,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Verified!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Redirecting you to your dashboard...',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes filled with the entered code, tinted
                  // green via the design-system's success status.
                  // The built-in "Verification successful" caption
                  // ships with the [success] caption variant.
                  Ux4gOtpInput(
                    length: 6,
                    value: '555555',
                    onChanged: (_) {},
                    status: Ux4gOtpInputStatus.success,
                    captionVariant: Ux4gOtpCaptionVariant.success,
                    captionText: 'Verification successful',
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

const _otpVerifiedSuccessCode =
    r'''// Mobile-sized OTP verified-success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
      child: Column(
        children: [
          // Success badge — concentric circles + check.
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: Ux4gPalette.green100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: Ux4gPalette.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: 20),

          Text('Verified!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Redirecting you to your dashboard...',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // OTP field tinted green via the design-system's success
          // status, with built-in "Verification successful" caption.
          Ux4gOtpInput(
            length: 6,
            value: '555555',
            onChanged: (_) {},
            status: Ux4gOtpInputStatus.success,
            captionVariant: Ux4gOtpCaptionVariant.success,
            captionText: 'Verification successful',
            boxSize: 44,
            gap: 8,
            showSeparator: false,
          ),
        ],
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP verified — success (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _OtpVerifiedSuccessCardMockup extends StatelessWidget {
  const _OtpVerifiedSuccessCardMockup();

  static const _cardBg = Color(0xFFE9E5FF);
  static const _successMid = Ux4gPalette.green;
  static const _successLight = Ux4gPalette.green100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: _successLight,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: _successMid,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Verified!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Redirecting you to your dashboard...',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          Ux4gOtpInput(
                            length: 6,
                            value: '555555',
                            onChanged: (_) {},
                            status: Ux4gOtpInputStatus.success,
                            captionVariant: Ux4gOtpCaptionVariant.success,
                            captionText: 'Verification successful',
                            boxSize: 44,
                            gap: 8,
                            showSeparator: false,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _otpVerifiedSuccessCardCode =
    r'''// Mobile-sized card-style OTP verified-success screen (360 x 760)
// Same content as the flat variant, wrapped in a soft-purple section
// with a white rounded card hugging the top.
Column(
  children: [
    Ux4gAppHeader(/* ... */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [/* subtle shadow */],
                ),
                child: Column(/* same content as flat variant */),
              ),
            ),
            Spacer(),
            // "Powered by - Digital India" footer pinned at the bottom.
          ],
        ),
      ),
    ),
  ],
)''';

// ═══════════════════════════════════════════════════════════════════════════
// SIGN UP PATTERN
// 5 steps mirroring the SignIn card / default style.
// Each component has a [Variant] knob: Default (flat) ↔ Card style (purple-bg).
// ═══════════════════════════════════════════════════════════════════════════

/// "Already have an account? Sign in" link — mirror of [_RegisterLink].
class _SignInLink extends StatelessWidget {
  const _SignInLink({this.fontSize = 15});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(
          'Already have an account? Sign in',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }
}

/// Inline error banner reusing the same [Ux4gStatusBanner] as SignIn.
Widget _signUpErrorBanner({
  String title = 'Your status message goes here',
  String subtitle = 'Take action',
  String badge = 'Attempt 1 of 5',
}) {
  return Ux4gStatusBanner(
    variant: Ux4gBannerVariant.errorLight,
    title: title,
    subtitle: subtitle,
    margin: EdgeInsets.zero,
    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
    titleStyle: const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400,
      color: Color(0xFF991B1B), height: 1.3,
    ),
    subtitleStyle: const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700,
      color: Color(0xFF991B1B), height: 1.3,
    ),
    leadingIcon: const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
    trailingIcon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        badge,
        style: const TextStyle(
          fontSize: 12, color: Color(0xFF991B1B),
          fontWeight: FontWeight.w500, height: 1.2,
        ),
      ),
    ),
  );
}

/// Card-container decoration shared by all 5 SignUp card-style steps.
BoxDecoration _suCardDeco() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ],
);

const _suCardBg = Color(0xFFE9E5FF);

// ───────────────────────────────────────────────────────────────────────
// STEP 1 — Create your account
// ───────────────────────────────────────────────────────────────────────

final signUpStep1Component = WidgetbookComponent(
  name: 'Create your account',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Create your account',
          description: 'First step of the sign-up flow. User enters their +91 mobile number '
              'and taps Send OTP. An error banner appears on invalid input.',
          code: variant == 'Card style' ? _signUpStep1CardCode : _signUpStep1Code,
          center: true,
          child: variant == 'Card style'
              ? const _SignUpStep1CardMockup()
              : const _SignUpStep1Mockup(),
        );
      },
    ),
  ],
);

class _SignUpStep1Mockup extends StatefulWidget {
  const _SignUpStep1Mockup();
  @override
  State<_SignUpStep1Mockup> createState() => _SignUpStep1MockupState();
}

class _SignUpStep1MockupState extends State<_SignUpStep1Mockup> {
  String _mobile = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Create your account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                        color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                  const SizedBox(height: 6),
                  const Text('Enter your mobile number to get started',
                    style: TextStyle(fontSize: 14, color: _subtleText, height: 1.3)),
                  const SizedBox(height: 24),
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: _placeholderStyle,
                    prefixText: '+91',
                    type: Ux4gInputFieldType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),
                  _signUpErrorBanner(),
                  const SizedBox(height: 20),
                  Ux4gButton(text: 'Send OTP', onPressed: () {},
                      size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 20),
                  const _SignInLink(),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

class _SignUpStep1CardMockup extends StatefulWidget {
  const _SignUpStep1CardMockup();
  @override
  State<_SignUpStep1CardMockup> createState() => _SignUpStep1CardMockupState();
}

class _SignUpStep1CardMockupState extends State<_SignUpStep1CardMockup> {
  String _mobile = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Create your account',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                                  color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                            const SizedBox(height: 6),
                            const Text('Enter your mobile number to get started',
                              style: TextStyle(fontSize: 13, color: _subtleText, height: 1.3)),
                            const SizedBox(height: 20),
                            Ux4gInputField(
                              value: _mobile,
                              onValueChange: (v) => setState(() => _mobile = v),
                              label: 'Mobile Number',
                              placeholder: 'Enter mobile number',
                              placeholderStyle: _placeholderStyle,
                              prefixText: '+91',
                              type: Ux4gInputFieldType.number,
                              maxLength: 10,
                            ),
                            const SizedBox(height: 12),
                            _signUpErrorBanner(),
                            const SizedBox(height: 16),
                            Ux4gButton(text: 'Send OTP', onPressed: () {},
                                size: Ux4gButtonSize.large, width: double.infinity),
                            const SizedBox(height: 16),
                            const _SignInLink(fontSize: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signUpStep1Code = r'''// Step 1 – Create your account
Ux4gInputField(
  label: 'Mobile Number',
  placeholder: 'Enter mobile number',
  prefixText: '+91',
),
SizedBox(height: 16),
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.errorLight,
  title: 'Your status message goes here',
  subtitle: 'Take action',
  margin: EdgeInsets.zero,
  trailingIcon: Text('Attempt 1 of 5', ...),
),
SizedBox(height: 20),
Ux4gButton(text: 'Send OTP', size: Ux4gButtonSize.large,
  width: double.infinity, onPressed: () {})''';

const _signUpStep1CardCode = r'''// Step 1 – Create your account (card style)
Container(
  color: Color(0xFFE9E5FF),
  child: Column(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create your account', ...),
              Ux4gInputField(label: 'Mobile Number', prefixText: '+91'),
              Ux4gStatusBanner(variant: Ux4gBannerVariant.errorLight, ...),
              Ux4gButton(text: 'Send OTP', ...),
              // Already have an account? Sign in
            ],
          ),
        ),
      ),
      _BrandFooter(),
    ],
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// STEP 2 — Verify your mobile
// ───────────────────────────────────────────────────────────────────────

final signUpStep2Component = WidgetbookComponent(
  name: 'Verify your mobile',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Verify your mobile',
          description: 'OTP verification screen with 6 single-digit boxes, a built-in '
              '60-second resend countdown, and a Verify OTP action.',
          code: variant == 'Card style' ? _signUpStep2CardCode : _signUpStep2Code,
          center: true,
          child: variant == 'Card style'
              ? const _SignUpStep2CardMockup()
              : const _SignUpStep2Mockup(),
        );
      },
    ),
  ],
);

class _SignUpStep2Mockup extends StatefulWidget {
  const _SignUpStep2Mockup();
  @override
  State<_SignUpStep2Mockup> createState() => _SignUpStep2MockupState();
}

class _SignUpStep2MockupState extends State<_SignUpStep2Mockup> {
  String _otp = '';
  int _resendNonce = 0;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Verify your mobile',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800,
                        color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                  const SizedBox(height: 6),
                  const Text('Enter the 6-digit OTP sent to +91 98765 XXXXX',
                    style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4)),
                  const SizedBox(height: 28),
                  Ux4gOtpInput(
                    key: ValueKey('su2_$_resendNonce'),
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: true,
                    captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                    captionLeadingText: "Didn't receive OTP?",
                    captionTrailingText: 'Resend OTP',
                    autoCountdownSeconds: 60,
                    onCaptionTrailingTap: () =>
                        setState(() { _otp = ''; _resendNonce++; }),
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(text: 'Verify OTP', onPressed: () {},
                      size: Ux4gButtonSize.large, width: double.infinity),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

class _SignUpStep2CardMockup extends StatefulWidget {
  const _SignUpStep2CardMockup();
  @override
  State<_SignUpStep2CardMockup> createState() => _SignUpStep2CardMockupState();
}

class _SignUpStep2CardMockupState extends State<_SignUpStep2CardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Verify your mobile',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                                  color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                            const SizedBox(height: 6),
                            const Text('Enter the 6-digit OTP sent to +91 98765 XXXXX',
                              style: TextStyle(fontSize: 13, color: _subtleText, height: 1.4)),
                            const SizedBox(height: 24),
                            Ux4gOtpInput(
                              key: ValueKey('su2c_$_resendNonce'),
                              length: 6,
                              value: _otp,
                              onChanged: (v) => setState(() => _otp = v),
                              boxSize: 44,
                              gap: 8,
                              showSeparator: true,
                              captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                              captionLeadingText: "Didn't receive OTP?",
                              captionTrailingText: 'Resend OTP',
                              autoCountdownSeconds: 60,
                              onCaptionTrailingTap: () =>
                                  setState(() { _otp = ''; _resendNonce++; }),
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(text: 'Verify OTP', onPressed: () {},
                                size: Ux4gButtonSize.large, width: double.infinity),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signUpStep2Code = r'''// Step 2 – Verify your mobile
Ux4gOtpInput(
  length: 6,
  showSeparator: true,
  captionVariant: Ux4gOtpCaptionVariant.resendTimer,
  captionLeadingText: "Didn\'t receive OTP?",
  autoCountdownSeconds: 60,
  onCaptionTrailingTap: () { setState(() { _otp = ''; }); },
),
SizedBox(height: 28),
Ux4gButton(text: 'Verify OTP', size: Ux4gButtonSize.large,
  width: double.infinity, onPressed: () {})''';

const _signUpStep2CardCode = r'''// Step 2 – Verify your mobile (card style)
Container(
  color: Color(0xFFE9E5FF),
  child: Column(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verify your mobile', ...),
              Ux4gOtpInput(length: 6, showSeparator: true, ...),
              Ux4gButton(text: 'Verify OTP', ...),
            ],
          ),
        ),
      ),
      _BrandFooter(),
    ],
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// STEP 3 — Complete your profile
// ───────────────────────────────────────────────────────────────────────

final signUpStep3Component = WidgetbookComponent(
  name: 'Complete your profile',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Complete your profile',
          description: 'Profile completion screen. Collects full name, email, mobile, '
              'and category before continuing to password setup.',
          code: variant == 'Card style' ? _signUpStep3CardCode : _signUpStep3Code,
          center: true,
          child: variant == 'Card style'
              ? const _SignUpStep3CardMockup()
              : const _SignUpStep3Mockup(),
        );
      },
    ),
  ],
);

class _SignUpStep3Mockup extends StatefulWidget {
  const _SignUpStep3Mockup();
  @override
  State<_SignUpStep3Mockup> createState() => _SignUpStep3MockupState();
}

class _SignUpStep3MockupState extends State<_SignUpStep3Mockup> {
  String _fullName = '', _email = '', _mobile = '';
  List<String> _category = [];

  static const _cats = [
    Ux4gDropdownOption(id: 'citizen', label: 'Citizen'),
    Ux4gDropdownOption(id: 'business', label: 'Business'),
    Ux4gDropdownOption(id: 'govt', label: 'Government Employee'),
  ];

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Ux4gInputField(value: _fullName,
                    onValueChange: (v) => setState(() => _fullName = v),
                    label: 'Full name', placeholder: 'Enter your full name',
                    placeholderStyle: _placeholderStyle),
                  const SizedBox(height: 16),
                  Ux4gInputField(value: _email,
                    onValueChange: (v) => setState(() => _email = v),
                    label: 'Email Address', placeholder: 'example@mail.com',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.email),
                  const SizedBox(height: 16),
                  Ux4gInputField(value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number', placeholder: 'Enter mobile number',
                    placeholderStyle: _placeholderStyle, prefixText: '+91',
                    type: Ux4gInputFieldType.number, maxLength: 10),
                  const SizedBox(height: 16),
                  const Text('Category',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _titleColor)),
                  const SizedBox(height: 4),
                  Ux4gSelectionDropdown(
                    options: _cats,
                    selectedOptionIds: _category,
                    onSelectionChange: (ids) => setState(() => _category = ids),
                    placeholder: 'Please select..',
                    mode: Ux4gDropdownMode.single,
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(text: 'Continue', onPressed: () {},
                      size: Ux4gButtonSize.large, width: double.infinity),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

class _SignUpStep3CardMockup extends StatefulWidget {
  const _SignUpStep3CardMockup();
  @override
  State<_SignUpStep3CardMockup> createState() => _SignUpStep3CardMockupState();
}

class _SignUpStep3CardMockupState extends State<_SignUpStep3CardMockup> {
  String _fullName = '', _email = '', _mobile = '';
  List<String> _category = [];

  static const _cats = [
    Ux4gDropdownOption(id: 'citizen', label: 'Citizen'),
    Ux4gDropdownOption(id: 'business', label: 'Business'),
    Ux4gDropdownOption(id: 'govt', label: 'Government Employee'),
  ];

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Ux4gInputField(value: _fullName,
                              onValueChange: (v) => setState(() => _fullName = v),
                              label: 'Full name', placeholder: 'Enter your full name',
                              placeholderStyle: _placeholderStyle),
                            const SizedBox(height: 14),
                            Ux4gInputField(value: _email,
                              onValueChange: (v) => setState(() => _email = v),
                              label: 'Email Address', placeholder: 'example@mail.com',
                              placeholderStyle: _placeholderStyle,
                              type: Ux4gInputFieldType.email),
                            const SizedBox(height: 14),
                            Ux4gInputField(value: _mobile,
                              onValueChange: (v) => setState(() => _mobile = v),
                              label: 'Mobile Number', placeholder: 'Enter mobile number',
                              placeholderStyle: _placeholderStyle, prefixText: '+91',
                              type: Ux4gInputFieldType.number, maxLength: 10),
                            const SizedBox(height: 14),
                            const Text('Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _titleColor)),
                            const SizedBox(height: 4),
                            Ux4gSelectionDropdown(
                              options: _cats,
                              selectedOptionIds: _category,
                              onSelectionChange: (ids) => setState(() => _category = ids),
                              placeholder: 'Please select..',
                              mode: Ux4gDropdownMode.single,
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(text: 'Continue', onPressed: () {},
                                size: Ux4gButtonSize.large, width: double.infinity),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signUpStep3Code = r'''// Step 3 – Complete your profile
Ux4gInputField(label: 'Full name', placeholder: 'Enter your full name'),
SizedBox(height: 16),
Ux4gInputField(label: 'Email Address', placeholder: 'example@mail.com'),
SizedBox(height: 16),
Ux4gInputField(label: 'Mobile Number', prefixText: '+91'),
SizedBox(height: 16),
Ux4gSelectionDropdown(
  label: 'Category',
  options: [...],
  placeholder: 'Please select..',
  mode: Ux4gDropdownMode.single,
),
SizedBox(height: 28),
Ux4gButton(text: 'Continue', size: Ux4gButtonSize.large,
  width: double.infinity, onPressed: () {})''';

const _signUpStep3CardCode = r'''// Step 3 – Complete your profile (card style)
Container(
  color: Color(0xFFE9E5FF),
  child: Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
        Ux4gInputField(label: 'Full name', ...),
        Ux4gInputField(label: 'Email Address', ...),
        Ux4gInputField(label: 'Mobile Number', prefixText: '+91'),
        Ux4gSelectionDropdown(label: 'Category', ...),
        Ux4gButton(text: 'Continue', ...),
      ],
    ),
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// STEP 4 — Password setup
// ───────────────────────────────────────────────────────────────────────

final signUpStep4Component = WidgetbookComponent(
  name: 'Password setup',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Password setup',
          description: 'Password creation screen. User sets and confirms their account '
              'password before the account is created.',
          code: variant == 'Card style' ? _signUpStep4CardCode : _signUpStep4Code,
          center: true,
          child: variant == 'Card style'
              ? const _SignUpStep4CardMockup()
              : const _SignUpStep4Mockup(),
        );
      },
    ),
  ],
);

class _SignUpStep4Mockup extends StatefulWidget {
  const _SignUpStep4Mockup();
  @override
  State<_SignUpStep4Mockup> createState() => _SignUpStep4MockupState();
}

class _SignUpStep4MockupState extends State<_SignUpStep4Mockup> {
  String _password = '', _confirm = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password setup',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800,
                        color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                  const SizedBox(height: 24),
                  Ux4gInputField(value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password', placeholder: '...........',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.password),
                  const SizedBox(height: 16),
                  Ux4gInputField(value: _confirm,
                    onValueChange: (v) => setState(() => _confirm = v),
                    label: 'Confirm password', placeholder: '...........',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.password),
                  const SizedBox(height: 28),
                  Ux4gButton(text: 'Create account', onPressed: () {},
                      size: Ux4gButtonSize.large, width: double.infinity),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

class _SignUpStep4CardMockup extends StatefulWidget {
  const _SignUpStep4CardMockup();
  @override
  State<_SignUpStep4CardMockup> createState() => _SignUpStep4CardMockupState();
}

class _SignUpStep4CardMockupState extends State<_SignUpStep4CardMockup> {
  String _password = '', _confirm = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Password setup',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                                  color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                            const SizedBox(height: 20),
                            Ux4gInputField(value: _password,
                              onValueChange: (v) => setState(() => _password = v),
                              label: 'Password', placeholder: '...........',
                              placeholderStyle: _placeholderStyle,
                              type: Ux4gInputFieldType.password),
                            const SizedBox(height: 16),
                            Ux4gInputField(value: _confirm,
                              onValueChange: (v) => setState(() => _confirm = v),
                              label: 'Confirm password', placeholder: '...........',
                              placeholderStyle: _placeholderStyle,
                              type: Ux4gInputFieldType.password),
                            const SizedBox(height: 24),
                            Ux4gButton(text: 'Create account', onPressed: () {},
                                size: Ux4gButtonSize.large, width: double.infinity),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signUpStep4Code = r'''// Step 4 – Password setup
Ux4gInputField(
  label: 'Password',
  placeholder: '...........',
  type: Ux4gInputFieldType.password,
),
SizedBox(height: 16),
Ux4gInputField(
  label: 'Confirm password',
  placeholder: '...........',
  type: Ux4gInputFieldType.password,
),
SizedBox(height: 28),
Ux4gButton(text: 'Create account', size: Ux4gButtonSize.large,
  width: double.infinity, onPressed: () {})''';

const _signUpStep4CardCode = r'''// Step 4 – Password setup (card style)
Container(
  color: Color(0xFFE9E5FF),
  child: Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
        Ux4gInputField(label: 'Password', type: Ux4gInputFieldType.password),
        Ux4gInputField(label: 'Confirm password', type: Ux4gInputFieldType.password),
        Ux4gButton(text: 'Create account', ...),
      ],
    ),
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// STEP 5 — Account Created
// ───────────────────────────────────────────────────────────────────────

final signUpStep5Component = WidgetbookComponent(
  name: 'Account Created',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Account Created',
          description: 'Success screen after registration. Offers a recommended action to '
              'link Aadhaar or skip to browse services.',
          code: variant == 'Card style' ? _signUpStep5CardCode : _signUpStep5Code,
          center: true,
          child: variant == 'Card style'
              ? const _SignUpStep5CardMockup()
              : const _SignUpStep5Mockup(),
        );
      },
    ),
  ],
);

class _SignUpStep5Mockup extends StatelessWidget {
  const _SignUpStep5Mockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF86EFAC), width: 2),
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Color(0xFF16A34A), size: 40),
                  ),
                  const SizedBox(height: 24),
                  const Text('Account Created!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800,
                        color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                  const SizedBox(height: 8),
                  const Text('Welcome, Ramesh Kumar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: _subtleText, height: 1.3)),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: const Text('RECOMMENDED',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                          color: Color(0xFF92400E), letterSpacing: 0.8)),
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Link Aadhaar Now', onPressed: () {},
                      size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Skip and Browse Services', onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 16),
                  const Text('You can link Aadhaar later from your profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: _subtleText, height: 1.4)),
                ],
              ),
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

class _SignUpStep5CardMockup extends StatelessWidget {
  const _SignUpStep5CardMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                        decoration: _suCardDeco(),
                        child: Column(
                          children: [
                            Container(
                              width: 72, height: 72,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF86EFAC), width: 2),
                              ),
                              child: const Icon(Icons.check_rounded,
                                  color: Color(0xFF16A34A), size: 40),
                            ),
                            const SizedBox(height: 20),
                            const Text('Account Created!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                                  color: _titleColor, height: 1.2, letterSpacing: -0.3)),
                            const SizedBox(height: 6),
                            const Text('Welcome, Ramesh Kumar',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13, color: _subtleText, height: 1.3)),
                            const SizedBox(height: 28),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFFDE68A)),
                              ),
                              child: const Text('RECOMMENDED',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                                    color: Color(0xFF92400E), letterSpacing: 0.8)),
                            ),
                            const SizedBox(height: 12),
                            Ux4gButton(text: 'Link Aadhaar Now', onPressed: () {},
                                size: Ux4gButtonSize.large, width: double.infinity),
                            const SizedBox(height: 12),
                            Ux4gButton(text: 'Skip and Browse Services', onPressed: () {},
                                variant: Ux4gButtonVariant.outline,
                                size: Ux4gButtonSize.large, width: double.infinity),
                            const SizedBox(height: 12),
                            const Text('You can link Aadhaar later from your profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: _subtleText, height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _BrandFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _signUpStep5Code = r'''// Step 5 – Account Created
Column(
  children: [
    Container(
      width: 72, height: 72,
      decoration: BoxDecoration(
        color: Color(0xFFDCFCE7), shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF86EFAC), width: 2),
      ),
      child: Icon(Icons.check_rounded, color: Color(0xFF16A34A), size: 40),
    ),
    SizedBox(height: 24),
    Text('Account Created!', ...),
    Text('Welcome, Ramesh Kumar', ...),
    SizedBox(height: 32),
    Container(child: Text('RECOMMENDED', ...)),
    SizedBox(height: 12),
    Ux4gButton(text: 'Link Aadhaar Now', size: Ux4gButtonSize.large,
      width: double.infinity, onPressed: () {}),
    SizedBox(height: 12),
    Ux4gButton(text: 'Skip and Browse Services',
      variant: Ux4gButtonVariant.outline,
      size: Ux4gButtonSize.large, width: double.infinity, onPressed: () {}),
    SizedBox(height: 16),
    Text('You can link Aadhaar later from your profile', ...),
  ],
)''';

const _signUpStep5CardCode = r'''// Step 5 – Account Created (card style)
Container(
  color: Color(0xFFE9E5FF),
  child: Column(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 32, 20, 24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            // green check icon, title, subtitle,
            // RECOMMENDED badge, Link Aadhaar button, Skip button, note
          ]),
        ),
      ),
      _BrandFooter(),
    ],
  ),
)''';
