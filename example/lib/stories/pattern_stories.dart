import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import '../widgets/component_docs.dart';

// -- Asset paths (copied into example/assets/) --------------------------
const _nationalEmblemPath = 'assets/national_amblam_logo.svg';
const _unionLogoPath = 'assets/Union.svg';
const _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

// -- Shared design tokens used across all SignIn patterns ---------------
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
bool _isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

Color _getBg(BuildContext context) =>
    _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100;
Color _getBorder(BuildContext context) =>
    _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200;
Color _getTitleColor(BuildContext context) =>
    _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900;
Color _getSubtleText(BuildContext context) =>
    _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500;
Color _getMutedText(BuildContext context) =>
    _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400;

TextStyle _getPlaceholderStyle(BuildContext context) => TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: _getMutedText(context),
  height: 1.3,
);

// -----------------------------------------------------------------------
// SignIn pattern variants
//
// Each screen lives in its own [WidgetbookComponent] so the SignIn folder
// renders as a flat list of patterns:
//
//   SignIn
//    +-- Sign in to your account
//    +-- Enter OTP
//    +-- Sign in with Aadhaar
//    +-- Signed in success
//
// Each component keeps a single "Default" use case that renders the
// mobile mockup. This also keeps each component's "Code" tab focused
// on just that one screen's snippet.
// -----------------------------------------------------------------------

final signInDefaultComponent = WidgetbookComponent(
  name: 'Sign in to your account',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        // Right-side knob lets the user toggle layout variants without
        // cluttering the tree with multiple entries. Both variants share
        // the same intent ("sign in to your account") so they belong
        // together � different actual patterns (OTP, Aadhaar, Success)
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
        // Same knob pattern as the Username/Password component � toggles
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
// Auth errors & lockout — sibling folder of SignIn / OTP Verification /
// Session Time-out Dialog. Houses standalone error patterns that aren't
// part of the linear sign-in flow (incorrect OTP, lockouts, etc.)
// ───────────────────────────────────────────────────────────────────────

final authIncorrectOtpComponent = WidgetbookComponent(
  name: 'OTP error — incorrect entry',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat error layout and the '
              'card-style layout on a soft-purple background.',
        );

        final code = switch (variant) {
          'Card style' => _authIncorrectOtpCardCode,
          _ => _authIncorrectOtpCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AuthIncorrectOtpCardMockup(),
          _ => const _AuthIncorrectOtpMockup(),
        };

        return ComponentDocs(
          name: 'OTP error — incorrect entry',
          description:
              'OTP verification screen showing the error state — '
              '6 boxes filled with the user\'s wrong code rendered '
              'with red borders via [Ux4gOtpInputStatus.error], plus '
              'an inline "Incorrect OTP" caption with a live resend '
              'countdown via [Ux4gOtpCaptionVariant.attemptWithTimer]. '
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

final authOtpAttemptWarningComponent = WidgetbookComponent(
  name: 'OTP error — attempt warning',
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
          'Card style' => _authOtpAttemptWarningCardCode,
          _ => _authOtpAttemptWarningCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AuthOtpAttemptWarningCardMockup(),
          _ => const _AuthOtpAttemptWarningMockup(),
        };

        return ComponentDocs(
          name: 'OTP error — attempt warning',
          description:
              'OTP verification error escalated with an inline warning '
              'banner counting down remaining attempts before a 30-min '
              'lockout. The 6 boxes still render in error state via '
              '[Ux4gOtpInputStatus.error] and the inline caption uses '
              '[Ux4gOtpCaptionVariant.attemptWithTimer]; the warning '
              'banner sits below using the design-system [Ux4gStatusBanner]. '
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

final authOtpLastAttemptComponent = WidgetbookComponent(
  name: 'OTP error — last-attempt warning',
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
          'Card style' => _authOtpLastAttemptCardCode,
          _ => _authOtpLastAttemptCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AuthOtpLastAttemptCardMockup(),
          _ => const _AuthOtpLastAttemptMockup(),
        };

        return ComponentDocs(
          name: 'OTP error — last-attempt warning',
          description:
              'OTP verification on the *final* attempt — escalated to '
              'error styling. Same layout as the attempt-warning pattern '
              'but the inline banner uses [Ux4gBannerVariant.errorLight] '
              'with red palette tokens and the message warns the user '
              'that one more wrong entry will lock the account. '
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

final authOtpAccountLockedComponent = WidgetbookComponent(
  name: 'OTP error — account locked',
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

        // Reuse the same widgets + code snippets used by the
        // "Verify mobile — account locked" pattern in the OTP
        // Verification folder — the lockout state is identical, so
        // we don't duplicate the implementation.
        final code = switch (variant) {
          'Card style' => _verifyAccountLockedCardCode,
          _ => _verifyAccountLockedCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _VerifyAccountLockedCardMockup(),
          _ => const _VerifyAccountLockedMockup(),
        };

        return ComponentDocs(
          name: 'OTP error — account locked',
          description:
              'Terminal lockout state shown after the user exhausts all '
              'OTP attempts. Includes a red lock badge, disabled OTP '
              'field with a live "Locked for mm:ss" caption from the '
              'design-system OTP component, an error banner, and a '
              'support phone link. Use the [Variant] knob on the right '
              'to toggle between the flat layout and the card-style '
              'layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final authOtpRetryUnlockedComponent = WidgetbookComponent(
  name: 'OTP retry — unlocked',
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
          'Card style' => _authOtpRetryUnlockedCardCode,
          _ => _authOtpRetryUnlockedCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AuthOtpRetryUnlockedCardMockup(),
          _ => const _AuthOtpRetryUnlockedMockup(),
        };

        return ComponentDocs(
          name: 'OTP retry — unlocked',
          description:
              'Recovery screen shown after a 30-min lockout window has '
              'expired. A green "You can now try signing in again" '
              'success banner sits above a fresh OTP entry field with '
              'the resend-timer caption. Built entirely with the '
              'design-system [Ux4gStatusBanner] (successLight) and '
              '[Ux4gOtpInput] (resendTimer caption). '
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

final authOtpSuspiciousActivityComponent = WidgetbookComponent(
  name: 'OTP step-up — suspicious activity',
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
          'Card style' => _authOtpSuspiciousActivityCardCode,
          _ => _authOtpSuspiciousActivityCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AuthOtpSuspiciousActivityCardMockup(),
          _ => const _AuthOtpSuspiciousActivityMockup(),
        };

        return ComponentDocs(
          name: 'OTP step-up — suspicious activity',
          description:
              'Step-up authentication screen shown when the system detects '
              'a sign-in from a new device or other suspicious signal. '
              'A multi-line warning banner explains the reason, followed '
              'by a fresh OTP entry field. Built with the design-system '
              '[Ux4gStatusBanner] (warningLight) and [Ux4gOtpInput]. '
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

// ───────────────────────────────────────────────────────────────────────
// Aadhaar Authentication Gate — sibling folder of SignIn / OTP
// Verification / Session Time-out / Auth errors. Houses the Aadhaar
// step-up flows where the user picks a verification method (OTP /
// Face / mAadhaar TOTP) before continuing.
// ───────────────────────────────────────────────────────────────────────

final aadhaarVerifyMethodComponent = WidgetbookComponent(
  name: 'Verify with Aadhaar — choose method',
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
          'Card style' => _aadhaarVerifyMethodCardCode,
          _ => _aadhaarVerifyMethodCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarVerifyMethodCardMockup(),
          _ => const _AadhaarVerifyMethodMockup(),
        };

        return ComponentDocs(
          name: 'Verify with Aadhaar — choose method',
          description:
              'Method-picker shown after the user enters their Aadhaar '
              'number. Three selectable option cards (Aadhaar OTP, Face '
              'Authentication, mAadhaar TOTP) built with the design '
              'system\'s [Ux4gCard] (selection state) and [Ux4gRadioButton]. '
              'A Cancel + Continue footer pinned above the standard '
              'brand footer. Use the [Variant] knob on the right to '
              'toggle between the flat layout and the card-style layout. '
              'Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final aadhaarOtpEnterComponent = WidgetbookComponent(
  name: 'Aadhaar OTP — enter code',
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
          'Card style' => _aadhaarOtpEnterCardCode,
          _ => _aadhaarOtpEnterCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarOtpEnterCardMockup(),
          _ => const _AadhaarOtpEnterMockup(),
        };

        return ComponentDocs(
          name: 'Aadhaar OTP — enter code',
          description:
              'OTP entry step shown after the user picks "Aadhaar OTP" '
              'on the verify-with-Aadhaar method picker. Includes a '
              '"Change method" link back to the picker, a labeled OTP '
              'field with a 60-second resend timer, and a Back + Verify '
              'OTP action footer. Use the [Variant] knob on the right '
              'to toggle between the flat layout and the card-style '
              'layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final aadhaarFaceAuthPermissionComponent = WidgetbookComponent(
  name: 'Aadhaar Face Auth — camera permission',
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
          'Card style' => _aadhaarFaceAuthPermissionCardCode,
          _ => _aadhaarFaceAuthPermissionCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarFaceAuthPermissionCardMockup(),
          _ => const _AadhaarFaceAuthPermissionMockup(),
        };

        return ComponentDocs(
          name: 'Aadhaar Face Auth — camera permission',
          description:
              'Camera-permission step shown after the user picks "Face '
              'Authentication" on the verify-with-Aadhaar method picker. '
              'A muted info card explains the privacy guarantee, with a '
              'Cancel + Allow Camera footer. Use the [Variant] knob on '
              'the right to toggle between the flat layout and the '
              'card-style layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final aadhaarVerifiedSuccessComponent = WidgetbookComponent(
  name: 'Aadhaar verified — success',
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
          'Card style' => _aadhaarVerifiedSuccessCardCode,
          _ => _aadhaarVerifiedSuccessCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarVerifiedSuccessCardMockup(),
          _ => const _AadhaarVerifiedSuccessMockup(),
        };

        return ComponentDocs(
          name: 'Aadhaar verified — success',
          description:
              'Final success state of the Aadhaar gate flow. Includes a '
              'green success banner, a confirmation title and message, '
              'a transaction-ID info card, and a full-width "Continue '
              'to Service" CTA. Built with the design-system '
              '[Ux4gStatusBanner] (successLight) and [Ux4gCard]. '
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

final aadhaarVerificationFailedComponent = WidgetbookComponent(
  name: 'Aadhaar verification failed',
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
          'Card style' => _aadhaarVerificationFailedCardCode,
          _ => _aadhaarVerificationFailedCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarVerificationFailedCardMockup(),
          _ => const _AadhaarVerificationFailedMockup(),
        };

        return ComponentDocs(
          name: 'Aadhaar verification failed',
          description:
              'Failure state of the Aadhaar gate flow. Shows a red error '
              'badge, a clear failure title, a description that includes '
              'the remaining-attempts count, and an inline error banner '
              'with an attempt-counter pill. Action footer offers two '
              'choices — switch method or retry. Use the [Variant] knob '
              'on the right to toggle between the flat layout and the '
              'card-style layout. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final aadhaarAccountLockedComponent = WidgetbookComponent(
  name: 'Aadhaar account locked',
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
          'Card style' => _aadhaarAccountLockedCardCode,
          _ => _aadhaarAccountLockedCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _AadhaarAccountLockedCardMockup(),
          _ => const _AadhaarAccountLockedMockup(),
        };

        return ComponentDocs(
          name: 'Aadhaar account locked',
          description:
              'Terminal error state of the Aadhaar flow shown when the '
              'user exceeds the maximum number of failed attempts. '
              'Features a lock badge, a clear status title, and a '
              'prominent countdown timer box to indicate when the '
              'account will be automatically unlocked. Action footer '
              'allows contacting support. Use the [Variant] knob to '
              'toggle between flat and card layouts. Mobile-sized (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final operatorAssistedAuthComponent = WidgetbookComponent(
  name: 'Operator-assisted authentication',
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
          'Card style' => _operatorAssistedAuthCardCode,
          _ => _operatorAssistedAuthCode,
        };

        final Widget child = switch (variant) {
          'Card style' => const _OperatorAssistedAuthCardMockup(),
          _ => const _OperatorAssistedAuthMockup(),
        };

        return ComponentDocs(
          name: 'Operator-assisted authentication',
          description:
              'Pattern for Aadhaar verification conducted by a certified '
              'VLE operator. Features a back button, operator details '
              'card, and a mandatory consent checkbox. Action footer '
              'allows proceeding with consent or cancelling. Use the '
              '[Variant] knob to toggle between layouts. Mobile-sized (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Session Time-out Dialog — sibling of SignIn / OTP Verification
// ───────────────────────────────────────────────────────────────────────

final sessionExpiringDialogComponent = WidgetbookComponent(
  name: 'Your session is expiring',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        // ── Right-side knobs ────────────────────────────────────────
        final state = context.knobs.list(
          label: 'State',
          options: const ['Expiring', 'Expiring soon', 'Session ended'],
          initialOption: 'Expiring',
          description:
              'Three lifecycle states of the timeout dialog:\n'
              '• Expiring — early warning (purple lock).\n'
              '• Expiring soon — final-minute warning (orange).\n'
              '• Session ended — terminal, sign-in required (clock).',
        );

        final totalSeconds = context.knobs.double
            .slider(
              label: 'Total session (seconds)',
              initialValue: 300,
              min: 60,
              max: 900,
            )
            .round();

        final secondsLeft = context.knobs.double
            .slider(
              label: 'Seconds left',
              initialValue: 287, // 04:47 — matches the reference image
              min: 0,
              max: 900,
            )
            .round()
            .clamp(0, totalSeconds);

        return ComponentDocs(
          name: 'Your session is expiring',
          description:
              'Modal dialog shown after a period of inactivity. Use the '
              '[State] knob on the right to switch between the three '
              'lifecycle states (Expiring, Expiring soon, Session ended) '
              'and the [Total session] / [Seconds left] sliders to drive '
              'the live countdown and progress bar. '
              'Built with the design-system components only.',
          code: switch (state) {
            'Expiring soon' => _sessionExpiringSoonCode,
            'Session ended' => _sessionEndedCode,
            _ => _sessionExpiringCode,
          },
          center: true,
          child: _SessionExpiringDialogMockup(
            state: state,
            totalSeconds: totalSeconds,
            secondsLeft: secondsLeft,
          ),
        );
      },
    ),
  ],
);

// -----------------------------------------------------------------------
// OTP Verification � sibling folder of SignIn
// -----------------------------------------------------------------------

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

// ---------------------------------------------------------------------
// OTP verified � success state shown right after a correct OTP, before
// the auto-redirect kicks in. Filled OTP boxes are tinted green via
// the design-system's success status, and a built-in
// "Verification successful" caption appears below.
// ---------------------------------------------------------------------
final otpVerifiedSuccessComponent = WidgetbookComponent(
  name: 'OTP verified � success',
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
          name: 'OTP verified � success',
          description:
              'Success confirmation shown immediately after a correct '
              'OTP � green check badge, filled OTP field tinted green '
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

// ---------------------------------------------------------------------
// Verify mobile with account locked � terminal state after too many
// failed attempts. Shows a lock badge, disabled OTP boxes with a
// live "Locked for mm:ss" caption, an inline error banner, and a
// support phone number.
// ---------------------------------------------------------------------
final otpVerifyAccountLockedComponent = WidgetbookComponent(
  name: 'Verify mobile � account locked',
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
          name: 'Verify mobile � account locked',
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

// ---------------------------------------------------------------------
// Verify mobile with last-attempt warning � like the attempt-warning
// pattern but escalated to error styling for the *final* attempt.
// ---------------------------------------------------------------------
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
              'Mobile-number OTP verification on the *final* attempt � '
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

// ---------------------------------------------------------------------
// Verify mobile with attempt warning � adds an inline warning banner
// counting down failed attempts before a 30-minute lockout.
// ---------------------------------------------------------------------
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

// ---------------------------------------------------------------------
// Verify mobile with voice-call fallback � adds a Back button at top,
// shows the resend timer in its expired state (active "Resend OTP"
// link), and a secondary outlined "Get OTP via voice call" CTA.
// ---------------------------------------------------------------------
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

// -----------------------------------------------------------------------
// Shared helpers
// -----------------------------------------------------------------------

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
        color: _isDark(context)
            ? Ux4gPalette.primary600
            : Ux4gPalette.primary300,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getBorder(context)),
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

/// Government-style header used by every screen � national emblem, a thin
/// vertical divider, and the brand union logo.
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ux4gAppHeader(
          variant: _isDark(context)
              ? Ux4gAppHeaderVariant.light
              : Ux4gAppHeaderVariant.light,
          title: '',
          leadingWidgets: [
            SvgPicture.asset(
              _nationalEmblemPath,
              height: 32,
              colorFilter: _isDark(context)
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
            SizedBox(
              height: 28,
              child: Ux4gDivider(
                orientation: Ux4gDividerOrientation.vertical,
                color: _isDark(context)
                    ? Ux4gPalette.neutral700
                    : Ux4gPalette.neutral300,
              ),
            ),
            SvgPicture.asset(
              _unionLogoPath,
              height: 32,
              colorFilter: ColorFilter.mode(
                _isDark(context)
                    ? Ux4gPalette.primary300
                    : Ux4gPalette.primary600,
                BlendMode.srcIn,
              ),
            ),
          ],
          horizontalPadding: 16,
          leadingSpacing: 12,
        ),
        Ux4gDivider(color: _getBorder(context)),
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
          Text(
            'Powered by -',
            style: Theme.of(context)
                .extension<Ux4gTypography>()!
                .lS_default
                .copyWith(color: _getMutedText(context)),
          ),
          const SizedBox(height: 6),
          Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
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
/// reference design � soft purple (primary @ 75% alpha), bold,
/// 16px with a slight negative letter-spacing.
class _RegisterLink extends StatelessWidget {
  const _RegisterLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ux4gButton(
        text: 'New user? Register here',
        onPressed: () {},
        variant: Ux4gButtonVariant.ghost,
        size: Ux4gButtonSize.medium,
      ),
    );
  }
}

// -----------------------------------------------------------------------
// 1. Sign in to your account � mobile mockup
// -----------------------------------------------------------------------
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
                  Text(
                    'Sign in to your account',
                    style: Theme.of(context)
                        .extension<Ux4gTypography>()!
                        .hM_strong
                        .copyWith(
                          color: _getTitleColor(context),
                          letterSpacing: -0.3,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Access your government services securely',
                    style: Theme.of(context)
                        .extension<Ux4gTypography>()!
                        .bM_default
                        .copyWith(color: _getSubtleText(context)),
                  ),
                  const SizedBox(height: 24),

                  Ux4gInputField(
                    value: _username,
                    onValueChange: (v) => setState(() => _username = v),
                    label: 'Username',
                    placeholder: 'Enter your username',
                    placeholderStyle: _getPlaceholderStyle(context),
                  ),
                  const SizedBox(height: 16),

                  Ux4gInputField(
                    value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password',
                    placeholder: '...........',
                    placeholderStyle: _getPlaceholderStyle(context),
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 16),

                  // Error banner � uses the design-system [Ux4gStatusBanner]
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
                    leadingIcon: Icon(
                      Icons.error_outline,
                      color: Theme.of(context).extension<Ux4gColors>()!.error,
                      size: 20,
                    ),
                    trailingIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _isDark(context)
                            ? Ux4gPalette.red900
                            : Ux4gPalette.red200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Attempt 1 of 5',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isDark(context)
                              ? Ux4gPalette.red100
                              : Ux4gPalette.red800,
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
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 16),

                  Ux4gDivider(
                    color: _getBorder(context),
                    label: Text(
                      'OR',
                      style: Theme.of(context)
                          .extension<Ux4gTypography>()!
                          .lM_default
                          .copyWith(
                            color: _getMutedText(context),
                            letterSpacing: 0.5,
                          ),
                    ),
                    labelSpacing: 16,
                  ),
                  const SizedBox(height: 16),

                  Ux4gButton(
                    text: 'Sign in with Aadhaar',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

// -----------------------------------------------------------------------
// 2. Enter OTP � mobile mockup
// -----------------------------------------------------------------------
class _EnterOtpMobileMockup extends StatefulWidget {
  const _EnterOtpMobileMockup();

  @override
  State<_EnterOtpMobileMockup> createState() => _EnterOtpMobileMockupState();
}

class _EnterOtpMobileMockupState extends State<_EnterOtpMobileMockup> {
  String _otp = '';

  // Bumped every time the user taps "Resend OTP" � used as a [ValueKey]
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
                  // resendTimer ? resendAction, making "Resend OTP"
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
                    height: 48,
                    width: 326,
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

// -----------------------------------------------------------------------
// 3. Sign in with Aadhaar � mobile mockup
// -----------------------------------------------------------------------
class _SignInAadhaarMobileMockup extends StatefulWidget {
  const _SignInAadhaarMobileMockup();

  @override
  State<_SignInAadhaarMobileMockup> createState() =>
      _SignInAadhaarMobileMockupState();
}

class _SignInAadhaarMobileMockupState
    extends State<_SignInAadhaarMobileMockup> {
  String _aadhaar = '';
  String _method = 'otp'; // 'otp' | 'face' � Send OTP selected by default

  /// Live validation state derived from the current Aadhaar value.
  /// We only show an error once the user has typed all 12 digits � so
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
                    // Aadhaar � the button automatically renders in its
                    // disabled style otherwise.
                    enabled: validation.status == Ux4gInputFieldStatus.success,
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

// -----------------------------------------------------------------------
// 4. Signed in success � mobile mockup
// -----------------------------------------------------------------------
class _SignedInSuccessMobileMockup extends StatefulWidget {
  const _SignedInSuccessMobileMockup();

  @override
  State<_SignedInSuccessMobileMockup> createState() =>
      _SignedInSuccessMobileMockupState();
}

class _SignedInSuccessMobileMockupState
    extends State<_SignedInSuccessMobileMockup> {
  // Brand greens � independent of theme so the success messaging always
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
                  // Success badge � concentric circles + check icon.
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

// -----------------------------------------------------------------------
// Code snippets (shown in the docs "Code" tab so users can copy-paste).

// -----------------------------------------------------------------------

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
          SizedBox(
            height: 28,
            child: Ux4gDivider(
              orientation: Ux4gDividerOrientation.vertical,
              color: Ux4gPalette.neutral300,
            ),
          ),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Ux4gDivider(color: Ux4gPalette.neutral200),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign in to your account',
              style: Theme.of(context).extension<Ux4gTypography>()!.hM_strong.copyWith(color: Ux4gPalette.gray900)),
            SizedBox(height: 6),
            Text('Access your government services securely',
              style: Theme.of(context).extension<Ux4gTypography>()!.bM_default.copyWith(color: Ux4gPalette.neutral500)),
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

            // Error banner � design-system Ux4gStatusBanner.
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
                  color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
            ),
            SizedBox(height: 16),

            Ux4gDivider(
              color: Ux4gPalette.neutral200,
              label: Text('OR', style: Theme.of(context).extension<Ux4gTypography>()!.lM_default.copyWith(color: Ux4gPalette.neutral400, letterSpacing: 0.5)),
              labelSpacing: 16,
            ),
            SizedBox(height: 16),

            Ux4gButton(
              text: 'Sign in with Aadhaar',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 28),

            Center(
              child: Ux4gButton(
                text: 'New user? Register here',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
            ),
          ],
        ),
      ),
        // Powered by - Digital India footer pinned to the bottom.
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Powered by -',
                style: Theme.of(context).extension<Ux4gTypography>()!.lS_default.copyWith(color: Ux4gPalette.neutral400)),
              SizedBox(height: 6),
              Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
            ],
          ),
        ),    ],
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.red500, BlendMode.srcIn)),
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

          // 6 OTP boxes � built-in 60s countdown + tap-to-resend.
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
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

const _aadhaarCode = r'''// Mobile-sized Aadhaar sign-in screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.red500, BlendMode.srcIn)),
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

          // Live Verhoeff validation � only flag errors once all
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
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

const _successCode = r'''// Mobile-sized success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.red500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        children: [
          // Success badge � concentric circles + check icon.
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
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// 5. Sign in account with Mobile No � mobile mockup
// -----------------------------------------------------------------------
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

                  // -- Mobile input with +91 prefix --
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    type: Ux4gInputFieldType.number,
                    prefixText: '+91',
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),

                  // -- Status banner � same pattern as Sign In screen --
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
                        color: Ux4gPalette.red200,
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
                    height: 48,
                    width: 326,
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
                    height: 48,
                    width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          // Error banner � design-system Ux4gStatusBanner.
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
                color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
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
              height: 48,
              width: 326,
          ),
          SizedBox(height: 28),

          Center(child: TextButton(
            onPressed: () {},
            child: Text('New user? Register here'),
          )),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Sign in to your account � Card-style variant
// (toggled via the [Variant] knob on signInDefaultComponent)
// -----------------------------------------------------------------------
class _SignInCardMockup extends StatefulWidget {
  const _SignInCardMockup();

  @override
  State<_SignInCardMockup> createState() => _SignInCardMockupState();
}

class _SignInCardMockupState extends State<_SignInCardMockup> {
  String _username = '';
  String _password = '';

  // Card-variant background � soft purple tint behind the white card.
  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

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
              color: _getBg(context),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password input.
                            Ux4gInputField(
                              value: _password,
                              onValueChange: (v) =>
                                  setState(() => _password = v),
                              label: 'Password',
                              placeholder: '...........',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              type: Ux4gInputFieldType.password,
                            ),
                            const SizedBox(height: 12),

                            // Error banner.
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.errorLight,
                              title: 'Username not found.',
                              subtitleWidget: Row(
                                children: [
                                  Text(
                                    'Take action',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: _isDark(context)
                                          ? Ux4gPalette.red300
                                          : Ux4gPalette.red800,
                                      height: 1.3,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isDark(context)
                                          ? Ux4gPalette.red800
                                          : Ux4gPalette.red100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Attempt 1 of 5',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isDark(context)
                                            ? Ux4gPalette.red300
                                            : Ux4gPalette.red800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.zero,
                              backgroundColor: _isDark(context)
                                  ? Ux4gPalette.red900
                                  : Ux4gPalette.red50,
                              borderColor: _isDark(context)
                                  ? Ux4gPalette.red600
                                  : Ux4gPalette.red300,
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                12,
                                10,
                                12,
                              ),
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: _isDark(context)
                                    ? Ux4gPalette.red300
                                    : Ux4gPalette.red800,
                                height: 1.3,
                              ),
                              leadingIcon: Icon(
                                Icons.error,
                                color: _isDark(context)
                                    ? Ux4gPalette.red500
                                    : Ux4gPalette.red600,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 16),

                            Ux4gButton(
                              text: 'Send OTP',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
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
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 16),

                            const _RegisterLink(),
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
                            color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Sign in account with Mobile No � Card-style variant
// (toggled via the [Variant] knob on signInWithMobileComponent)
// -----------------------------------------------------------------------
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
  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

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
              color: _getCardBg(context),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
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
                                  color: Ux4gPalette.red200,
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
                              height: 48,
                              width: 326,
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
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 16),

                            const _RegisterLink(),
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
                            color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Enter OTP � Card-style variant
// (toggled via the [Variant] knob on signInEnterOtpComponent)
// -----------------------------------------------------------------------
class _EnterOtpCardMockup extends StatefulWidget {
  const _EnterOtpCardMockup();

  @override
  State<_EnterOtpCardMockup> createState() => _EnterOtpCardMockupState();
}

class _EnterOtpCardMockupState extends State<_EnterOtpCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              color: _getCardBg(context),
              child: Column(
                children: [
                  // White card holds the OTP form. Sits at the top of the
                  // soft-purple area; the area below stays empty so the
                  // footer can pin to the bottom � exactly like the
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
                            height: 48,
                            width: 326,
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

                  // Empty soft-purple area between card and footer �
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Sign in with Aadhaar � Card-style variant
// (toggled via the [Variant] knob on signInAadhaarComponent)
// -----------------------------------------------------------------------
class _SignInAadhaarCardMockup extends StatefulWidget {
  const _SignInAadhaarCardMockup();

  @override
  State<_SignInAadhaarCardMockup> createState() =>
      _SignInAadhaarCardMockupState();
}

class _SignInAadhaarCardMockupState extends State<_SignInAadhaarCardMockup> {
  String _aadhaar = '';
  String _method = 'otp';

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

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
              color: _getCardBg(context),
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
                            placeholderStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Ux4gPalette.neutral500
                                  : Ux4gPalette.neutral400,
                              height: 1.3,
                            ),
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
                            height: 48,
                            width: 326,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Encrypted hint sits *outside* the card, on the
                  // soft-purple area � exactly like the reference image.
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

                    // Live Verhoeff validation � see Default variant for details.
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Signed in success � Card-style variant
// (toggled via the [Variant] knob on signInSuccessComponent)
// -----------------------------------------------------------------------
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

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

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
              color: _getCardBg(context),
              child: Column(
                children: [
                  // White card hugs the top of the soft-purple area.
                  // Full-bleed horizontally � only top spacing,
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
                          // Success badge � concentric circles + check.
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
                    // Success badge � concentric circles + check.
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Verify your mobile number � mobile mockup (OTP Verification folder)
// -----------------------------------------------------------------------
class _VerifyMobileOtpMockup extends StatefulWidget {
  const _VerifyMobileOtpMockup();

  @override
  State<_VerifyMobileOtpMockup> createState() => _VerifyMobileOtpMockupState();
}

class _VerifyMobileOtpMockupState extends State<_VerifyMobileOtpMockup> {
  String _otp = '';

  // Bumped every time the user taps "Resend OTP" � used as a [ValueKey]
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
                  // -- Title (wraps to 2 lines as per the reference) --
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
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 8),

                  // "Change mobile number" � ghost-style link button.
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
          ),
          SizedBox(height: 8),

          // "Change mobile number" � ghost-style link button.
          Center(child: Ux4gButton(
            text: 'Change mobile number',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
          )),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Verify your mobile number � Card-style variant
// (toggled via the [Variant] knob on otpVerifyMobileComponent)
// -----------------------------------------------------------------------
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

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  // Soft-purple gap above the card � image shows the
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
                            height: 48,
                            width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with voice fallback � mobile mockup
// -----------------------------------------------------------------------
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

                  // -- 2-line title --
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

                  // 6 OTP boxes � caption is in [resendAction] mode so
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
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 12),

                  // Secondary action � voice-call fallback for users
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
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
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with voice fallback � Card-style variant
// (toggled via the [Variant] knob on otpVerifyVoiceComponent)
// -----------------------------------------------------------------------
class _VerifyMobileVoiceCardMockup extends StatefulWidget {
  const _VerifyMobileVoiceCardMockup();

  @override
  State<_VerifyMobileVoiceCardMockup> createState() =>
      _VerifyMobileVoiceCardMockupState();
}

class _VerifyMobileVoiceCardMockupState
    extends State<_VerifyMobileVoiceCardMockup> {
  String _otp = '';

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
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
                            height: 48,
                            width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with attempt warning � mobile mockup
// -----------------------------------------------------------------------
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

                  // 6 OTP boxes � caption suppressed since the warning
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

                  // Warning banner � uses the design-system component
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
                    height: 48,
                    width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          // Warning banner � design-system Ux4gStatusBanner.
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
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with attempt warning � Card-style variant
// (toggled via the [Variant] knob on otpVerifyAttemptWarningComponent)
// -----------------------------------------------------------------------
class _VerifyMobileAttemptWarningCardMockup extends StatefulWidget {
  const _VerifyMobileAttemptWarningCardMockup();

  @override
  State<_VerifyMobileAttemptWarningCardMockup> createState() =>
      _VerifyMobileAttemptWarningCardMockupState();
}

class _VerifyMobileAttemptWarningCardMockupState
    extends State<_VerifyMobileAttemptWarningCardMockup> {
  String _otp = '';

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
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
                            height: 48,
                            width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with last-attempt warning � mobile mockup
// -----------------------------------------------------------------------
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

                  // Error-styled banner � escalated from warning since
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
                        color: Ux4gPalette.red200,
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
                    height: 48,
                    width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          // Error-styled banner � final attempt before lockout.
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
                color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile with last-attempt warning � Card-style variant
// -----------------------------------------------------------------------
class _VerifyMobileLastAttemptCardMockup extends StatefulWidget {
  const _VerifyMobileLastAttemptCardMockup();

  @override
  State<_VerifyMobileLastAttemptCardMockup> createState() =>
      _VerifyMobileLastAttemptCardMockupState();
}

class _VerifyMobileLastAttemptCardMockupState
    extends State<_VerifyMobileLastAttemptCardMockup> {
  String _otp = '';

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
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
                                color: Ux4gPalette.red200,
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
                            height: 48,
                            width: 326,
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
                          color: Ux4gPalette.red200,
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
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile � account locked (mobile mockup)
// -----------------------------------------------------------------------
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

                  // -- Lock badge --
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

                  // 6 disabled OTP boxes with the [locked] caption � the
                  // design-system component renders "?? Locked for mm:ss"
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

                  // -- Error banner --
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

                  // -- Support link --
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// Verify mobile � account locked (Card-style variant)
// -----------------------------------------------------------------------
class _VerifyAccountLockedCardMockup extends StatefulWidget {
  const _VerifyAccountLockedCardMockup();

  @override
  State<_VerifyAccountLockedCardMockup> createState() =>
      _VerifyAccountLockedCardMockupState();
}

class _VerifyAccountLockedCardMockupState
    extends State<_VerifyAccountLockedCardMockup> {
  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;
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
              color: _getCardBg(context),
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

// -----------------------------------------------------------------------
// OTP verified � success (mobile mockup)
// -----------------------------------------------------------------------
class _OtpVerifiedSuccessMockup extends StatelessWidget {
  const _OtpVerifiedSuccessMockup();

  // Brand greens � independent of theme so the success messaging
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
                  // Success badge � same concentric-circles as the
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
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 64, 20, 0),
      child: Column(
        children: [
          // Success badge � concentric circles + check.
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
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// -----------------------------------------------------------------------
// OTP verified � success (Card-style variant)
// -----------------------------------------------------------------------
class _OtpVerifiedSuccessCardMockup extends StatelessWidget {
  const _OtpVerifiedSuccessCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;
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
              color: _getCardBg(context),
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

// ───────────────────────────────────────────────────────────────────────
// Your session is expiring — modal dialog mockup with 3 lifecycle states
// driven by knobs from the right-side panel.
// ───────────────────────────────────────────────────────────────────────
class _SessionExpiringDialogMockup extends StatefulWidget {
  const _SessionExpiringDialogMockup({
    required this.state,
    required this.totalSeconds,
    required this.secondsLeft,
  });

  /// 'Expiring' | 'Expiring soon' | 'Session ended'
  final String state;
  final int totalSeconds;
  final int secondsLeft;

  @override
  State<_SessionExpiringDialogMockup> createState() =>
      _SessionExpiringDialogMockupState();
}

class _SessionExpiringDialogMockupState
    extends State<_SessionExpiringDialogMockup> {
  // Live countdown derived from the [secondsLeft] knob — each second
  // we tick down. When the user moves the knob, [didUpdateWidget]
  // resets the live counter to whatever the slider says.
  Timer? _timer;
  late int _live;

  @override
  void initState() {
    super.initState();
    _live = widget.secondsLeft;
    _startTimer();
  }

  @override
  void didUpdateWidget(_SessionExpiringDialogMockup old) {
    super.didUpdateWidget(old);
    if (old.secondsLeft != widget.secondsLeft) {
      setState(() => _live = widget.secondsLeft);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_live > 0) {
          _live--;
        } else {
          // Loop the demo so the dialog keeps animating in Widgetbook.
          _live = widget.secondsLeft;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_live ~/ 60).toString().padLeft(2, '0');
    final s = (_live % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final progress = widget.totalSeconds == 0
        ? 0.0
        : (_live / widget.totalSeconds).clamp(0.0, 1.0);

    // ── State-driven palette + content ──────────────────────────────
    late final Color accent;
    late final IconData badgeIcon;
    late final String title;
    late final String body;

    switch (widget.state) {
      case 'Expiring soon':
        accent = Ux4gPalette.secondary600;
        badgeIcon = Icons.warning_amber_rounded;
        title = 'Your session is expiring soon';
        body = "You'll be signed out in less than a minute";
        break;
      case 'Session ended':
        accent = Ux4gPalette.gray800;
        badgeIcon = Icons.access_time;
        title = 'Session ended';
        body =
            'Your form progress has been saved. Sign in again to '
            'continue where you left off.';
        break;
      case 'Expiring':
      default:
        accent = primary;
        badgeIcon = Icons.lock;
        title = 'Your session is expiring';
        body =
            "You've been inactive for a while. For your security, "
            "we'll sign you out automatically.";
    }

    final isEnded = widget.state == 'Session ended';

    // Countdown + description + progress live in the body slot of
    // [Ux4gModalContent]. For the terminal "Session ended" state the
    // countdown/progress are hidden — only the description remains.
    final bodyContent = Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isEnded) ...[
            Text(
              _formattedTime,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: accent,
                height: 1.0,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: _subtleText,
              height: 1.4,
            ),
          ),
          if (!isEnded) ...[
            const SizedBox(height: 20),
            Ux4gAnimatedLinearProgress(
              value: progress,
              height: 8,
              color: accent,
              duration: const Duration(milliseconds: 800),
            ),
          ],
        ],
      ),
    );

    // Render via the design-system modal content. We use the inline
    // [Ux4gModalContent] (not the [Ux4gModal] wrapper that calls
    // [showDialog]) because the pattern preview lives directly inside
    // the canvas, not inside an actual dialog route.
    return SizedBox(
      width: 360,
      child: Ux4gModalContent(
        onDismiss: () {},
        backgroundColor: Colors.white,
        cornerRadius: 20,
        alignment: Ux4gModalAlignment.centered,
        leadingItem: Ux4gModalLeadingItem.icon,
        leadingIcon: badgeIcon,
        leadingIconTint: accent,
        showCloseButton: false,
        showDividers: false,
        showSubtitle: false,
        showDescription: false,
        headerTitle: title,
        bodyContent: bodyContent,
        footerButtons: isEnded
            ? Ux4gModalFooterButtons.oneButton
            : Ux4gModalFooterButtons.twoButtons,
        footerAlign: Ux4gModalFooterAlign.center,
        primaryButtonText: isEnded ? 'Sign in to continue' : 'Stay signed in',
        secondaryButtonText: 'Sign out now',
        onPrimaryClick: () {},
        onSecondaryClick: () {},
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Session-timeout code snippets — all three states render via the
// design-system [Ux4gModalContent] component, so callers get the
// shipped badge/header/footer chrome and just provide:
//   • [headerTitle] + [bodyContent] (countdown + progress + description)
//   • [footerButtons] + button text + click handlers
// ───────────────────────────────────────────────────────────────────────

const _sessionExpiringCode =
    r'''// "Your session is expiring" — early warning state.
// Wired to a Timer.periodic that decrements [secondsLeft] every second.
SizedBox(
  width: 360,
  child: Ux4gModalContent(
    onDismiss: () {},
    backgroundColor: Colors.white,
    cornerRadius: 20,
    alignment: Ux4gModalAlignment.centered,
    leadingItem: Ux4gModalLeadingItem.icon,
    leadingIcon: Icons.lock,
    leadingIconTint: Theme.of(context).colorScheme.primary,
    showCloseButton: false,
    showDividers: false,
    showSubtitle: false,
    showDescription: false,
    headerTitle: 'Your session is expiring',
    bodyContent: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(formattedTime, // e.g. "04:47"
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
          )),
        SizedBox(height: 16),
        Text(
          "You've been inactive for a while. For your security, "
          "we'll sign you out automatically.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
        SizedBox(height: 20),
        Ux4gAnimatedLinearProgress(
          value: secondsLeft / totalSeconds,
          height: 8,
          duration: Duration(milliseconds: 800),
        ),
      ],
    ),
    footerButtons: Ux4gModalFooterButtons.twoButtons,
    footerAlign: Ux4gModalFooterAlign.center,
    primaryButtonText: 'Stay signed in',
    secondaryButtonText: 'Sign out now',
    onPrimaryClick: () {},
    onSecondaryClick: () {},
  ),
)''';

const _sessionExpiringSoonCode =
    r'''// "Your session is expiring soon" — final-minute warning state.
// Same modal shell, but the badge and countdown switch to
// [Ux4gPalette.secondary600] (orange).
SizedBox(
  width: 360,
  child: Ux4gModalContent(
    onDismiss: () {},
    backgroundColor: Colors.white,
    cornerRadius: 20,
    alignment: Ux4gModalAlignment.centered,
    leadingItem: Ux4gModalLeadingItem.icon,
    leadingIcon: Icons.warning_amber_rounded,
    leadingIconTint: Ux4gPalette.secondary600,
    showCloseButton: false,
    showDividers: false,
    showSubtitle: false,
    showDescription: false,
    headerTitle: 'Your session is expiring soon',
    bodyContent: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(formattedTime, // e.g. "00:57"
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Ux4gPalette.secondary600,
          )),
        SizedBox(height: 16),
        Text("You'll be signed out in less than a minute",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
        SizedBox(height: 20),
        Ux4gAnimatedLinearProgress(
          value: secondsLeft / totalSeconds,
          height: 8,
          color: Ux4gPalette.secondary600,
          duration: Duration(milliseconds: 800),
        ),
      ],
    ),
    footerButtons: Ux4gModalFooterButtons.twoButtons,
    footerAlign: Ux4gModalFooterAlign.center,
    primaryButtonText: 'Stay signed in',
    secondaryButtonText: 'Sign out now',
    onPrimaryClick: () {},
    onSecondaryClick: () {},
  ),
)''';

const _sessionEndedCode =
    r'''// "Session ended" — terminal state. No countdown, no progress.
// Single full-width primary button replaces the dual-button row.
SizedBox(
  width: 360,
  child: Ux4gModalContent(
    onDismiss: () {},
    backgroundColor: Colors.white,
    cornerRadius: 20,
    alignment: Ux4gModalAlignment.centered,
    leadingItem: Ux4gModalLeadingItem.icon,
    leadingIcon: Icons.access_time,
    leadingIconTint: Ux4gPalette.gray800,
    showCloseButton: false,
    showDividers: false,
    showSubtitle: false,
    showDescription: false,
    headerTitle: 'Session ended',
    bodyContent: Text(
      'Your form progress has been saved. Sign in again to '
      'continue where you left off.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
    ),
    footerButtons: Ux4gModalFooterButtons.oneButton,
    footerAlign: Ux4gModalFooterAlign.center,
    primaryButtonText: 'Sign in to continue',
    onPrimaryClick: () {},
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP error — incorrect entry (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _AuthIncorrectOtpMockup extends StatelessWidget {
  const _AuthIncorrectOtpMockup();

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

                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the 6-digit code sent to +91 98XXX XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes — error status drives the red border on
                  // each box, and the [attemptWithTimer] caption variant
                  // renders the red "Incorrect OTP" leading text + live
                  // "Resend OTP in mm:ss" trailing timer automatically.
                  Ux4gOtpInput(
                    length: 6,
                    value: '555555',
                    onChanged: (_) {},
                    status: Ux4gOtpInputStatus.error,
                    captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                    captionLeadingText: 'Incorrect OTP',
                    captionTrailingText: 'Resend OTP in 00:17',
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                  const SizedBox(height: 24),

                  // Verify CTA — sits right under the OTP block with
                  // a small gap (no Expanded spacer above it).
                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

const _authIncorrectOtpCode = r'''// Mobile-sized OTP error screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          Text('OTP Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // The design-system Ux4gOtpInput renders red borders + the
          // "Incorrect OTP / Resend OTP in mm:ss" caption directly
          // from the [error] status + [attemptWithTimer] caption.
          Ux4gOtpInput(
            length: 6,
            value: '555555',
            onChanged: (_) {},
            status: Ux4gOtpInputStatus.error,
            captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
            captionLeadingText: 'Incorrect OTP',
            captionTrailingText: 'Resend OTP in 00:17',
            boxSize: 44,
            gap: 8,
            showSeparator: false,
          ),
        ],
      ),
    ),

    // Verify CTA pinned near the bottom of the body.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Ux4gButton(
        text: 'Verify OTP',
        onPressed: () {},
        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP error — incorrect entry (Card-style variant)
// Card hugs the header with bottom-only rounded corners — image flush
// against the top edge of the soft-purple area.
// ───────────────────────────────────────────────────────────────────────
class _AuthIncorrectOtpCardMockup extends StatefulWidget {
  const _AuthIncorrectOtpCardMockup();

  @override
  State<_AuthIncorrectOtpCardMockup> createState() =>
      _AuthIncorrectOtpCardMockupState();
}

class _AuthIncorrectOtpCardMockupState
    extends State<_AuthIncorrectOtpCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  // Soft-purple gap between the header and the card.
                  const SizedBox(height: 16),

                  // White card — fully rounded on all four corners and
                  // inset 16px from the phone-frame edges so it floats
                  // on the soft-purple background.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
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
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the 6-digit code sent to +91 98XXX XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Clean entry state with the resend-timer caption.
                          Ux4gOtpInput(
                            key: ValueKey('auth_card_otp_$_resendNonce'),
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
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
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

const _authIncorrectOtpCardCode =
    r'''// Mobile-sized card-style OTP verification screen (360 x 760)
// Card is fully rounded on all four corners and floats on a
// soft-purple background with 16px horizontal inset.
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
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
                    Text('OTP Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('auth_card_otp_$resendNonce'),
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
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// OTP error — attempt warning (mobile mockup)
// Same OTP error state as [_AuthIncorrectOtpMockup] *plus* an inline
// warning banner counting down attempts before a 30-min lockout.
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpAttemptWarningMockup extends StatelessWidget {
  const _AuthOtpAttemptWarningMockup();

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

                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the 6-digit code sent to +91 98XXX XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6 OTP boxes in error state with the inline caption.
                  Ux4gOtpInput(
                    length: 6,
                    value: '555555',
                    onChanged: (_) {},
                    status: Ux4gOtpInputStatus.error,
                    captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                    captionLeadingText: 'Incorrect OTP',
                    captionTrailingText: 'Resend OTP in 00:17',
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                  const SizedBox(height: 16),

                  // Warning banner — design-system [Ux4gStatusBanner]
                  // with the warningLight variant and an Attempt pill on
                  // the trailing side.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title: 'Incorrect OTP',
                    subtitle: '1 more incorrect entry\nbefore 30-min lockout',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.secondary800,
                      height: 1.3,
                    ),
                    subtitleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.secondary800,
                      height: 1.3,
                    ),
                    leadingIcon: Icon(
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
                      child: Text(
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
                  const SizedBox(height: 24),

                  // Verify CTA — sits right under the warning banner.
                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

const _authOtpAttemptWarningCode =
    r'''// Mobile-sized OTP error screen with attempt-counter banner (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          Text('OTP Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          // OTP boxes in error state with inline "Incorrect OTP" caption.
          Ux4gOtpInput(
            length: 6,
            value: '555555',
            onChanged: (_) {},
            status: Ux4gOtpInputStatus.error,
            captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
            captionLeadingText: 'Incorrect OTP',
            captionTrailingText: 'Resend OTP in 00:17',
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
        ],
      ),
    ),

    // Verify CTA pinned near the bottom of the body.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Ux4gButton(
        text: 'Verify OTP',
        onPressed: () {},
        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
      ),
    ),
    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP error — attempt warning (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpAttemptWarningCardMockup extends StatelessWidget {
  const _AuthOtpAttemptWarningCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // White rounded card — 16px horizontal inset.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
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
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the 6-digit code sent to +91 98XXX XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            length: 6,
                            value: '555555',
                            onChanged: (_) {},
                            status: Ux4gOtpInputStatus.error,
                            captionVariant:
                                Ux4gOtpCaptionVariant.attemptWithTimer,
                            captionLeadingText: 'Incorrect OTP',
                            captionTrailingText: 'Resend OTP in 00:17',
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
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.secondary800,
                              height: 1.3,
                            ),
                            subtitleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Ux4gPalette.secondary800,
                              height: 1.3,
                            ),
                            leadingIcon: Icon(
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
                              child: Text(
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
                          const SizedBox(height: 16),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
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

const _authOtpAttemptWarningCardCode =
    r'''// Mobile-sized card-style OTP error screen with attempt-counter banner (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
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
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('OTP Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      length: 6,
                      value: '555555',
                      onChanged: (_) {},
                      status: Ux4gOtpInputStatus.error,
                      captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                      captionLeadingText: 'Incorrect OTP',
                      captionTrailingText: 'Resend OTP in 00:17',
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
                    SizedBox(height: 16),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// OTP error — last-attempt warning (mobile mockup)
// Same layout as the attempt-warning pattern but the inline banner is
// escalated to errorLight (red) for the FINAL attempt.
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpLastAttemptMockup extends StatelessWidget {
  const _AuthOtpLastAttemptMockup();

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

                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the 6-digit code sent to +91 98XXX XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Ux4gOtpInput(
                    length: 6,
                    value: '555555',
                    onChanged: (_) {},
                    status: Ux4gOtpInputStatus.error,
                    captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                    captionLeadingText: 'Incorrect OTP',
                    captionTrailingText: 'Resend OTP in 00:17',
                    boxSize: 44,
                    gap: 8,
                    showSeparator: false,
                  ),
                  const SizedBox(height: 16),

                  // Error-styled banner — escalated to red since this
                  // is the final attempt before lockout.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title: 'Incorrect OTP',
                    subtitle:
                        'This is your last attempt\nbefore a 30-min lockout',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    subtitleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.red800,
                      height: 1.3,
                    ),
                    leadingIcon: Icon(
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
                        color: Ux4gPalette.red200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
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
                  const SizedBox(height: 24),

                  // Verify CTA — sits right under the error banner.
                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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
// OTP error — last-attempt warning (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpLastAttemptCardMockup extends StatelessWidget {
  const _AuthOtpLastAttemptCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
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
                          const _BackButton(),
                          const SizedBox(height: 16),

                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the 6-digit code sent to +91 98XXX XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            length: 6,
                            value: '555555',
                            onChanged: (_) {},
                            status: Ux4gOtpInputStatus.error,
                            captionVariant:
                                Ux4gOtpCaptionVariant.attemptWithTimer,
                            captionLeadingText: 'Incorrect OTP',
                            captionTrailingText: 'Resend OTP in 00:17',
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
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.red800,
                              height: 1.3,
                            ),
                            subtitleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Ux4gPalette.red800,
                              height: 1.3,
                            ),
                            leadingIcon: Icon(
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
                                color: Ux4gPalette.red200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
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
                          const SizedBox(height: 16),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
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

const _authOtpLastAttemptCode =
    r'''// Mobile-sized OTP error screen — final attempt before lockout (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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

          Text('OTP Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          Ux4gOtpInput(
            length: 6,
            value: '555555',
            onChanged: (_) {},
            status: Ux4gOtpInputStatus.error,
            captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
            captionLeadingText: 'Incorrect OTP',
            captionTrailingText: 'Resend OTP in 00:17',
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
                color: Ux4gPalette.red200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 2 of 3',
                style: TextStyle(fontSize: 12,
                  color: Ux4gPalette.red800,
                  fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    ),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Ux4gButton(
        text: 'Verify OTP',
        onPressed: () {},
        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _authOtpLastAttemptCardCode =
    r'''// Mobile-sized card-style OTP error screen — final attempt (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
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
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 16),

                    Text('OTP Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      length: 6,
                      value: '555555',
                      onChanged: (_) {},
                      status: Ux4gOtpInputStatus.error,
                      captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                      captionLeadingText: 'Incorrect OTP',
                      captionTrailingText: 'Resend OTP in 00:17',
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
                          color: Ux4gPalette.red200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Attempt 2 of 3',
                          style: TextStyle(fontSize: 12,
                            color: Ux4gPalette.red800,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: 16),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// OTP retry — unlocked (mobile mockup)
// Lockout window has expired — show a green confirmation banner above
// a fresh OTP entry field so the user knows they can try again.
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpRetryUnlockedMockup extends StatefulWidget {
  const _AuthOtpRetryUnlockedMockup();

  @override
  State<_AuthOtpRetryUnlockedMockup> createState() =>
      _AuthOtpRetryUnlockedMockupState();
}

class _AuthOtpRetryUnlockedMockupState
    extends State<_AuthOtpRetryUnlockedMockup> {
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
                  const _BackButton(),
                  const SizedBox(height: 16),

                  // Success banner — design-system Ux4gStatusBanner.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.successLight,
                    title: 'You can now try signing in again.',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Ux4gPalette.green700,
                      height: 1.3,
                    ),
                    leadingIcon: Icon(
                      Icons.check_circle,
                      color: Ux4gPalette.green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the 6-digit code sent to +91 98XXX XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Fresh OTP entry — counter resets, attempts back to 3.
                  Ux4gOtpInput(
                    key: ValueKey('auth_retry_otp_$_resendNonce'),
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
                    height: 48,
                    width: 326,
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
// OTP retry — unlocked (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpRetryUnlockedCardMockup extends StatefulWidget {
  const _AuthOtpRetryUnlockedCardMockup();

  @override
  State<_AuthOtpRetryUnlockedCardMockup> createState() =>
      _AuthOtpRetryUnlockedCardMockupState();
}

class _AuthOtpRetryUnlockedCardMockupState
    extends State<_AuthOtpRetryUnlockedCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
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
                          const _BackButton(),
                          const SizedBox(height: 12),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.successLight,
                            title: 'You can now try signing in again.',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Ux4gPalette.green700,
                              height: 1.3,
                            ),
                            leadingIcon: Icon(
                              Icons.check_circle,
                              color: Ux4gPalette.green,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the 6-digit code sent to +91 98XXX XXXXX',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            key: ValueKey('auth_retry_card_otp_$_resendNonce'),
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
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
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

const _authOtpRetryUnlockedCode =
    r'''// Mobile-sized OTP retry screen after a lockout (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
          SizedBox(height: 16),

          // Green confirmation banner — Ux4gBannerVariant.successLight.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.successLight,
            title: 'You can now try signing in again.',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500,
              color: Ux4gPalette.green700,
            ),
            leadingIcon: Icon(Icons.check_circle,
              color: Ux4gPalette.green, size: 20),
          ),
          SizedBox(height: 24),

          Text('OTP Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          Ux4gOtpInput(
            key: ValueKey('auth_retry_otp_$resendNonce'),
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
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _authOtpRetryUnlockedCardCode =
    r'''// Mobile-sized card-style OTP retry screen after a lockout (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
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
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 12),

                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.successLight,
                      title: 'You can now try signing in again.',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      titleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500,
                        color: Ux4gPalette.green700,
                      ),
                      leadingIcon: Icon(Icons.check_circle,
                        color: Ux4gPalette.green, size: 20),
                    ),
                    SizedBox(height: 20),

                    Text('OTP Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Enter the 6-digit code sent to +91 98XXX XXXXX',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('auth_retry_card_otp_$resendNonce'),
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
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// OTP step-up — suspicious activity (mobile mockup)
// Triggered when the back-end detects a sign-in from a new device or
// other risk signal — surface the reason in a warning banner and ask
// for a fresh OTP before continuing.
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpSuspiciousActivityMockup extends StatefulWidget {
  const _AuthOtpSuspiciousActivityMockup();

  @override
  State<_AuthOtpSuspiciousActivityMockup> createState() =>
      _AuthOtpSuspiciousActivityMockupState();
}

class _AuthOtpSuspiciousActivityMockupState
    extends State<_AuthOtpSuspiciousActivityMockup> {
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
                  const _BackButton(),
                  const SizedBox(height: 16),

                  // Warning banner — multi-line description in subtitle.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title: 'Suspicious activity detected',
                    subtitle:
                        'We detected a sign-in from a new device. Please '
                        'verify your identity before continuing.',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Ux4gPalette.secondary800,
                      height: 1.3,
                    ),
                    subtitleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Ux4gPalette.secondary800,
                      height: 1.4,
                    ),
                    leadingIcon: Icon(
                      Icons.error_outline,
                      color: Ux4gPalette.secondary600,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A verification code has been sent to your '
                    'registered number for security verification.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Ux4gOtpInput(
                    key: ValueKey('auth_stepup_otp_$_resendNonce'),
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
                  const SizedBox(height: 32),

                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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
// OTP step-up — suspicious activity (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpSuspiciousActivityCardMockup extends StatefulWidget {
  const _AuthOtpSuspiciousActivityCardMockup();

  @override
  State<_AuthOtpSuspiciousActivityCardMockup> createState() =>
      _AuthOtpSuspiciousActivityCardMockupState();
}

class _AuthOtpSuspiciousActivityCardMockupState
    extends State<_AuthOtpSuspiciousActivityCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
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
                          const _BackButton(),
                          const SizedBox(height: 12),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.warningLight,
                            title: 'Suspicious activity detected',
                            subtitle:
                                'We detected a sign-in from a new device. '
                                'Please verify your identity before continuing.',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Ux4gPalette.secondary800,
                              height: 1.3,
                            ),
                            subtitleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Ux4gPalette.secondary800,
                              height: 1.4,
                            ),
                            leadingIcon: Icon(
                              Icons.error_outline,
                              color: Ux4gPalette.secondary600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'A verification code has been sent to your '
                            'registered number for security verification.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            key: ValueKey('auth_stepup_card_otp_$_resendNonce'),
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
                          const SizedBox(height: 20),

                          Ux4gButton(
                            text: 'Verify OTP',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
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

const _authOtpSuspiciousActivityCode =
    r'''// Mobile-sized OTP step-up screen — suspicious activity (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
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
          SizedBox(height: 16),

          // Orange warning banner — multi-line description.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.warningLight,
            title: 'Suspicious activity detected',
            subtitle: 'We detected a sign-in from a new device. Please '
                'verify your identity before continuing.',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Ux4gPalette.secondary800,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400,
              color: Ux4gPalette.secondary800,
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Ux4gPalette.secondary600, size: 20),
          ),
          SizedBox(height: 24),

          Text('OTP Verification',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('A verification code has been sent to your '
            'registered number for security verification.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 24),

          Ux4gOtpInput(
            key: ValueKey('auth_stepup_otp_$resendNonce'),
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
          SizedBox(height: 32),

          Ux4gButton(
            text: 'Verify OTP',
            onPressed: () {},
            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _authOtpSuspiciousActivityCardCode =
    r'''// Mobile-sized card-style OTP step-up screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
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
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 12),

                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Suspicious activity detected',
                      subtitle: 'We detected a sign-in from a new device. '
                          'Please verify your identity before continuing.',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      titleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700,
                        color: Ux4gPalette.secondary800,
                      ),
                      subtitleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400,
                        color: Ux4gPalette.secondary800,
                      ),
                      leadingIcon: Icon(Icons.error_outline,
                        color: Ux4gPalette.secondary600, size: 20),
                    ),
                    SizedBox(height: 20),

                    Text('OTP Verification',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('A verification code has been sent to your '
                      'registered number for security verification.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('auth_stepup_card_otp_$resendNonce'),
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
                    SizedBox(height: 20),

                    Ux4gButton(
                      text: 'Verify OTP',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
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
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Verify with Aadhaar — choose method (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerifyMethodMockup extends StatefulWidget {
  const _AadhaarVerifyMethodMockup();

  @override
  State<_AadhaarVerifyMethodMockup> createState() =>
      _AadhaarVerifyMethodMockupState();
}

class _AadhaarVerifyMethodMockupState
    extends State<_AadhaarVerifyMethodMockup> {
  // 'otp' | 'face' | 'totp' — Aadhaar OTP selected by default.
  String _method = 'otp';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          // Header with a hamburger menu action on the trailing side.
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 16),

                  const Text(
                    'Verify with Aadhaar',
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
                    'Choose how you want to authenticate. Your Aadhaar '
                    'number is never stored.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _AadhaarMethodCard(
                    value: 'otp',
                    groupValue: _method,
                    onChanged: (v) => setState(() => _method = v),
                    title: 'Aadhaar OTP',
                    subtitle:
                        'Receive a one-time password on your Aadhaar-linked mobile number.',
                  ),
                  const SizedBox(height: 12),
                  _AadhaarMethodCard(
                    value: 'face',
                    groupValue: _method,
                    onChanged: (v) => setState(() => _method = v),
                    title: 'Face Authentication',
                    subtitle:
                        'Verify identity using face recognition. Camera access required.',
                  ),
                  const SizedBox(height: 12),
                  _AadhaarMethodCard(
                    value: 'totp',
                    groupValue: _method,
                    onChanged: (v) => setState(() => _method = v),
                    title: 'mAadhaar TOTP',
                    subtitle: 'Use the time-based code from your mAadhaar app.',
                  ),
                ],
              ),
            ),
          ),

          // Cancel + Continue footer.
          _AadhaarVerifyFooterRow(onCancel: () {}, onContinue: () {}),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Verify with Aadhaar — Card-style variant
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerifyMethodCardMockup extends StatefulWidget {
  const _AadhaarVerifyMethodCardMockup();

  @override
  State<_AadhaarVerifyMethodCardMockup> createState() =>
      _AadhaarVerifyMethodCardMockupState();
}

class _AadhaarVerifyMethodCardMockupState
    extends State<_AadhaarVerifyMethodCardMockup> {
  String _method = 'otp';

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          const SizedBox(height: 12),

                          const Text(
                            'Verify with Aadhaar',
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
                            'Choose how you want to authenticate. Your '
                            'Aadhaar number is never stored.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _AadhaarMethodCard(
                            value: 'otp',
                            groupValue: _method,
                            onChanged: (v) => setState(() => _method = v),
                            title: 'Aadhaar OTP',
                            subtitle:
                                'Receive a one-time password on your Aadhaar-linked mobile number.',
                          ),
                          const SizedBox(height: 12),
                          _AadhaarMethodCard(
                            value: 'face',
                            groupValue: _method,
                            onChanged: (v) => setState(() => _method = v),
                            title: 'Face Authentication',
                            subtitle:
                                'Verify identity using face recognition. Camera access required.',
                          ),
                          const SizedBox(height: 12),
                          _AadhaarMethodCard(
                            value: 'totp',
                            groupValue: _method,
                            onChanged: (v) => setState(() => _method = v),
                            title: 'mAadhaar TOTP',
                            subtitle:
                                'Use the time-based code from your mAadhaar app.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Cancel + Continue footer + brand footer (both sit
                  // on the soft-purple area, outside the white card).
                  _AadhaarVerifyFooterRow(onCancel: () {}, onContinue: () {}),
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

// ───────────────────────────────────────────────────────────────────────
// Helpers — reusable across the Aadhaar gate patterns.
// ───────────────────────────────────────────────────────────────────────

/// Header variant that adds a hamburger-menu action button on the
/// trailing side. Wraps the design-system [Ux4gAppHeader].
class _BrandHeaderWithMenu extends StatelessWidget {
  const _BrandHeaderWithMenu({required this.onMenuPressed});

  final VoidCallback onMenuPressed;

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
          actions: [
            // Custom widget — bordered rounded square containing the
            // menu icon. We use a Material+InkWell so the tap ripple
            // is clipped to the same rounded shape as the border, and
            // a fixed 40x40 SizedBox guarantees a true square (the
            // design-system Ux4gButton would expand horizontally for
            // its leading-icon row layout).
            Ux4gAppHeaderAction(
              customWidget: SizedBox(
                width: 40,
                height: 40,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: onMenuPressed,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Ux4gPalette.primary100,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.menu,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1, thickness: 1, color: _border),
      ],
    );
  }
}

/// Selectable option card built from the design-system [Ux4gCard].
/// When selected, the card switches to a tinted (primary-50) background
/// with a primary border to visually pair with the [Ux4gRadioButton]
/// inside it.
class _AadhaarMethodCard extends StatelessWidget {
  const _AadhaarMethodCard({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
  });

  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final primary = Theme.of(context).colorScheme.primary;

    return Ux4gCard(
      cornerRadius: 12,
      isClickable: true,
      onPressed: () => onChanged(value),
      backgroundColor: isSelected ? Ux4gPalette.primary50 : Ux4gPalette.gray100,
      // No border — selected state communicated by the tinted
      // background + radio + tinted text only.
      borderColor: Colors.transparent,
      borderWidth: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 16, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Ux4gRadioButton<String>(
                value: value,
                groupValue: groupValue,
                onChanged: (v) => onChanged(v!),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? primary : _titleColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? primary : _subtleText,
                      height: 1.35,
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

/// Cancel (ghost) + Continue (primary) footer row used by the Aadhaar
/// gate patterns. Sits on a divider that visually separates the form
/// from the actions. Button labels are configurable so the same row
/// can be reused for "Back / Verify OTP" on the OTP-entry step.
class _AadhaarVerifyFooterRow extends StatelessWidget {
  const _AadhaarVerifyFooterRow({
    required this.onCancel,
    required this.onContinue,
    this.cancelLabel = 'Cancel',
    this.continueLabel = 'Continue',
  });

  final VoidCallback onCancel;
  final VoidCallback onContinue;
  final String cancelLabel;
  final String continueLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, thickness: 1, color: _border),
          // Halved the gap between the divider and the action row —
          // matches the tighter spacing in the reference image.
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ux4gButton(
                text: cancelLabel,
                onPressed: onCancel,
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
              Ux4gButton(
                text: continueLabel,
                onPressed: onContinue,
                size: Ux4gButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _aadhaarVerifyMethodCode =
    r'''// Mobile-sized Aadhaar method-picker (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        Ux4gAppHeaderAction(icon: Icons.menu, onPressed: () {}),
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
          SizedBox(height: 16),

          Text('Verify with Aadhaar',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Choose how you want to authenticate. Your Aadhaar '
            'number is never stored.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 20),

          // Each option card uses the design-system Ux4gCard:
          //   • backgroundColor switches to Ux4gPalette.primary50 when selected
          //   • borderColor switches to the theme primary
          //   • a Ux4gRadioButton sits on the leading edge
          // See _AadhaarMethodCard for the full implementation.
          _AadhaarMethodCard(
            value: 'otp',
            groupValue: method,
            onChanged: (v) => setState(() => method = v),
            title: 'Aadhaar OTP',
            subtitle: 'Receive a one-time password on your Aadhaar-linked mobile number.',
          ),
          SizedBox(height: 12),
          _AadhaarMethodCard(
            value: 'face',
            groupValue: method,
            onChanged: (v) => setState(() => method = v),
            title: 'Face Authentication',
            subtitle: 'Verify identity using face recognition. Camera access required.',
          ),
          SizedBox(height: 12),
          _AadhaarMethodCard(
            value: 'totp',
            groupValue: method,
            onChanged: (v) => setState(() => method = v),
            title: 'mAadhaar TOTP',
            subtitle: 'Use the time-based code from your mAadhaar app.',
          ),
        ],
      ),
    ),

    // Cancel + Continue footer.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: Color(0xFFE5E7EB)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ux4gButton(
                text: 'Cancel',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
              Ux4gButton(
                text: 'Continue',
                onPressed: () {},
                size: Ux4gButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _aadhaarVerifyMethodCardCode =
    r'''// Mobile-sized card-style Aadhaar method-picker (360 x 760)
// Wraps the same form in a soft-purple section with a white rounded card.
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        Ux4gAppHeaderAction(icon: Icons.menu, onPressed: () {}),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    SizedBox(height: 12),
                    Text('Verify with Aadhaar',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Choose how you want to authenticate. Your '
                      'Aadhaar number is never stored.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 16),

                    // 3 option cards via _AadhaarMethodCard — see flat
                    // variant snippet for the full implementation.
                  ],
                ),
              ),
            ),

            Spacer(),

            // Cancel + Continue + brand footer sit on the soft-purple area.
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Ux4gButton(
                    text: 'Cancel',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.medium,
                  ),
                  Ux4gButton(
                    text: 'Continue',
                    onPressed: () {},
                    size: Ux4gButtonSize.medium,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Aadhaar OTP — enter code (mobile mockup)
// Step 2 of the Aadhaar gate flow: user picked "Aadhaar OTP" on the
// method picker; we now collect the 6-digit code.
// ───────────────────────────────────────────────────────────────────────
class _AadhaarOtpEnterMockup extends StatefulWidget {
  const _AadhaarOtpEnterMockup();

  @override
  State<_AadhaarOtpEnterMockup> createState() => _AadhaarOtpEnterMockupState();
}

class _AadhaarOtpEnterMockupState extends State<_AadhaarOtpEnterMockup> {
  String _otp = '';
  int _resendNonce = 0;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Change method" — semantically a back action that
                  // takes the user to the method picker, not just the
                  // previous screen. Built from Ux4gButton (ghost).
                  Ux4gButton(
                    text: 'Change method',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.small,
                    leadingIcon: Icons.arrow_back,
                    iconSize: 18,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A 6-digit OTP has been sent to the mobile number '
                    'linked to your Aadhaar.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Ux4gOtpInput(
                    key: ValueKey('aadhaar_otp_$_resendNonce'),
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    label: 'Enter OTP',
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
                ],
              ),
            ),
          ),

          // Back + Verify OTP action footer.
          _AadhaarVerifyFooterRow(
            onCancel: () {},
            onContinue: () {},
            cancelLabel: 'Back',
            continueLabel: 'Verify OTP',
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Aadhaar OTP — enter code (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarOtpEnterCardMockup extends StatefulWidget {
  const _AadhaarOtpEnterCardMockup();

  @override
  State<_AadhaarOtpEnterCardMockup> createState() =>
      _AadhaarOtpEnterCardMockupState();
}

class _AadhaarOtpEnterCardMockupState
    extends State<_AadhaarOtpEnterCardMockup> {
  String _otp = '';
  int _resendNonce = 0;

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          Ux4gButton(
                            text: 'Change method',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.ghost,
                            size: Ux4gButtonSize.small,
                            leadingIcon: Icons.arrow_back,
                            iconSize: 18,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'A 6-digit OTP has been sent to the mobile '
                            'number linked to your Aadhaar.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Ux4gOtpInput(
                            key: ValueKey('aadhaar_otp_card_$_resendNonce'),
                            length: 6,
                            value: _otp,
                            onChanged: (v) => setState(() => _otp = v),
                            label: 'Enter OTP',
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
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  _AadhaarVerifyFooterRow(
                    onCancel: () {},
                    onContinue: () {},
                    cancelLabel: 'Back',
                    continueLabel: 'Verify OTP',
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

const _aadhaarOtpEnterCode =
    r'''// Mobile-sized Aadhaar OTP entry screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: SizedBox(
            width: 40, height: 40,
            child: Ux4gButton(
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.small,
              borderRadius: 10,
              borderColor: Ux4gPalette.primary100,
              borderWidth: 1.5,
              padding: EdgeInsets.zero,
              leadingIcon: Icons.menu,
              iconSize: 20,
            ),
          ),
        ),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Change method" — back to the method picker.
          Ux4gButton(
            text: 'Change method',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 16),

          Text('Enter OTP',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('A 6-digit OTP has been sent to the mobile number '
            'linked to your Aadhaar.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 20),

          Ux4gOtpInput(
            key: ValueKey('aadhaar_otp_$resendNonce'),
            length: 6,
            value: otp,
            onChanged: (v) => setState(() => otp = v),
            label: 'Enter OTP',
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
        ],
      ),
    ),

    // Back + Verify OTP action footer.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: Color(0xFFE5E7EB)),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ux4gButton(
                text: 'Back',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
              Ux4gButton(
                text: 'Verify OTP',
                onPressed: () {},
                size: Ux4gButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _aadhaarOtpEnterCardCode =
    r'''// Mobile-sized card-style Aadhaar OTP entry screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: SizedBox(
            width: 40, height: 40,
            child: Ux4gButton(
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.small,
              borderRadius: 10,
              borderColor: Ux4gPalette.primary100,
              borderWidth: 1.5,
              padding: EdgeInsets.zero,
              leadingIcon: Icons.menu,
              iconSize: 20,
            ),
          ),
        ),
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                      text: 'Change method',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 12),

                    Text('Enter OTP',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('A 6-digit OTP has been sent to the mobile '
                      'number linked to your Aadhaar.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gOtpInput(
                      key: ValueKey('aadhaar_otp_card_$resendNonce'),
                      length: 6,
                      value: otp,
                      onChanged: (v) => setState(() => otp = v),
                      label: 'Enter OTP',
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
                  ],
                ),
              ),
            ),

            Spacer(),

            // Back + Verify OTP action footer.
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(height: 1, color: Color(0xFFE5E7EB)),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ux4gButton(
                        text: 'Back',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        size: Ux4gButtonSize.medium,
                      ),
                      Ux4gButton(
                        text: 'Verify OTP',
                        onPressed: () {},
                        size: Ux4gButtonSize.medium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Powered by - Digital India footer pinned to the bottom.
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Aadhaar Face Auth — camera permission (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarFaceAuthPermissionMockup extends StatelessWidget {
  const _AadhaarFaceAuthPermissionMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Ux4gButton(
                    text: 'Change method',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.small,
                    leadingIcon: Icons.arrow_back,
                    iconSize: 18,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Face Authentication',
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
                    'Allow camera access to capture your face for '
                    'Aadhaar biometric verification.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Privacy info card — cream/peach surface so it pairs
                  // visually with biometric/scan flows. Built from the
                  // design-system [Ux4gCard] with a custom body.
                  const _CameraPrivacyInfoCard(),
                ],
              ),
            ),
          ),

          // Cancel + Allow Camera action footer.
          _AadhaarVerifyFooterRow(
            onCancel: () {},
            onContinue: () {},
            cancelLabel: 'Cancel',
            continueLabel: 'Allow Camera',
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Aadhaar Face Auth — camera permission (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarFaceAuthPermissionCardMockup extends StatelessWidget {
  const _AadhaarFaceAuthPermissionCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          Ux4gButton(
                            text: 'Change method',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.ghost,
                            size: Ux4gButtonSize.small,
                            leadingIcon: Icons.arrow_back,
                            iconSize: 18,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            'Face Authentication',
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
                            'Allow camera access to capture your face '
                            'for Aadhaar biometric verification.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          const _CameraPrivacyInfoCard(),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  _AadhaarVerifyFooterRow(
                    onCancel: () {},
                    onContinue: () {},
                    cancelLabel: 'Cancel',
                    continueLabel: 'Allow Camera',
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

/// Privacy info card used by the Face Auth permission step.
/// Built from the design-system [Ux4gCard] with a cream/peach surface
/// (Ux4gPalette.secondary50) and a centered, two-line body.
class _CameraPrivacyInfoCard extends StatelessWidget {
  const _CameraPrivacyInfoCard();

  @override
  Widget build(BuildContext context) {
    return Ux4gCard(
      cornerRadius: 12,
      backgroundColor: Ux4gPalette.secondary50,
      borderColor: Colors.transparent,
      borderWidth: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Camera Access Required',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _titleColor,
                height: 1.3,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your face scan data is processed locally and never '
              'stored on our servers.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

const _aadhaarFaceAuthPermissionCode =
    r'''// Mobile-sized Aadhaar Face Auth permission screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        // Bordered hamburger tile — see _BrandHeaderWithMenu for the
        // full implementation (Material + InkWell inside an Ink with
        // a 1.5px Ux4gPalette.primary100 border).
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ux4gButton(
            text: 'Change method',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            size: Ux4gButtonSize.small,
            leadingIcon: Icons.arrow_back,
          ),
          SizedBox(height: 16),

          Text('Face Authentication',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Allow camera access to capture your face for '
            'Aadhaar biometric verification.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 20),

          // Privacy info card — design-system Ux4gCard with a cream
          // (Ux4gPalette.secondary50) surface and centered body.
          Ux4gCard(
            cornerRadius: 12,
            backgroundColor: Ux4gPalette.secondary50,
            borderColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Camera Access Required',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('Your face scan data is processed locally and '
                    'never stored on our servers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                ],
              ),
            ),
          ),
        ],
      ),
    ),

    // Cancel + Allow Camera action footer.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: Color(0xFFE5E7EB)),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ux4gButton(
                text: 'Cancel',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
              Ux4gButton(
                text: 'Allow Camera',
                onPressed: () {},
                size: Ux4gButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _aadhaarFaceAuthPermissionCardCode =
    r'''// Mobile-sized card-style Aadhaar Face Auth permission screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      actions: [
        // Bordered hamburger tile — see _BrandHeaderWithMenu.
      ],
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                      text: 'Change method',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                    ),
                    SizedBox(height: 12),

                    Text('Face Authentication',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Allow camera access to capture your face '
                      'for Aadhaar biometric verification.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gCard(
                      cornerRadius: 12,
                      backgroundColor: Ux4gPalette.secondary50,
                      borderColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Camera Access Required',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                            SizedBox(height: 8),
                            Text('Your face scan data is processed locally '
                              'and never stored on our servers.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Cancel + Allow Camera action footer.
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(height: 1, color: Color(0xFFE5E7EB)),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ux4gButton(
                        text: 'Cancel',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        size: Ux4gButtonSize.medium,
                      ),
                      Ux4gButton(
                        text: 'Allow Camera',
                        onPressed: () {},
                        size: Ux4gButtonSize.medium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Aadhaar verified — success (mobile mockup)
// Final state of the Aadhaar gate flow.
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerifiedSuccessMockup extends StatelessWidget {
  const _AadhaarVerifiedSuccessMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Inline success banner — Ux4gStatusBanner.successLight.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.successLight,
                    title: 'Aadhaar identity verified successfully',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Ux4gPalette.green700,
                      height: 1.3,
                    ),
                    leadingIcon: Icon(
                      Icons.check_circle,
                      color: Ux4gPalette.green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Authentication\nSuccessful',
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
                    'Your Aadhaar identity has been verified. You may '
                    'now proceed to the service.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Transaction-ID card — light primary surface.
                  const _TransactionIdCard(
                    label: 'Transaction ID',
                    value: 'TXN-2024-AAD-78432',
                  ),
                ],
              ),
            ),
          ),

          // Full-width Continue to Service CTA pinned just above the
          // brand footer, separated by a divider.
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 1, thickness: 1, color: _border),
                const SizedBox(height: 12),
                Ux4gButton(
                  text: 'Continue to Service',
                  onPressed: () {},
                  size: Ux4gButtonSize.large,
                  height: 48,
                  width: 326,
                ),
              ],
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Aadhaar verified — success (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerifiedSuccessCardMockup extends StatelessWidget {
  const _AadhaarVerifiedSuccessCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.successLight,
                            title: 'Aadhaar identity verified successfully',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Ux4gPalette.green700,
                              height: 1.3,
                            ),
                            leadingIcon: Icon(
                              Icons.check_circle,
                              color: Ux4gPalette.green,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Authentication\nSuccessful',
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
                            'Your Aadhaar identity has been verified. '
                            'You may now proceed to the service.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          const _TransactionIdCard(
                            label: 'Transaction ID',
                            value: 'TXN-2024-AAD-78432',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Ux4gButton(
                      text: 'Continue to Service',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      height: 48,
                      width: 326,
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

/// Read-only key-value card used to surface a transaction reference
/// after a successful verification. Built from the design-system
/// [Ux4gCard] with a light-primary tint.
class _TransactionIdCard extends StatelessWidget {
  const _TransactionIdCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Ux4gCard(
      cornerRadius: 12,
      backgroundColor: Ux4gPalette.primary50,
      borderColor: Colors.transparent,
      borderWidth: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: _subtleText,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _titleColor,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _aadhaarVerifiedSuccessCode =
    r'''// Mobile-sized Aadhaar verified-success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(/* same header with bordered hamburger action */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Green inline confirmation banner.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.successLight,
            title: 'Aadhaar identity verified successfully',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
            titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500,
              color: Ux4gPalette.green700,
            ),
            leadingIcon: Icon(Icons.check_circle,
              color: Ux4gPalette.green, size: 20),
          ),
          SizedBox(height: 20),

          Text('Authentication\nSuccessful',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Your Aadhaar identity has been verified. You may '
            'now proceed to the service.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 20),

          // Transaction-ID card — light-primary surface.
          Ux4gCard(
            cornerRadius: 12,
            backgroundColor: Ux4gPalette.primary50,
            borderColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Transaction ID',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  SizedBox(height: 4),
                  Text('TXN-2024-AAD-78432',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),

    // Full-width Continue to Service CTA above the brand footer.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: Color(0xFFE5E7EB)),
          SizedBox(height: 12),
          Ux4gButton(
            text: 'Continue to Service',
            onPressed: () {},
            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _aadhaarVerifiedSuccessCardCode =
    r'''// Mobile-sized card-style Aadhaar verified-success screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(/* same header with bordered hamburger action */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.successLight,
                      title: 'Aadhaar identity verified successfully',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                      titleStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500,
                        color: Ux4gPalette.green700,
                      ),
                      leadingIcon: Icon(Icons.check_circle,
                        color: Ux4gPalette.green, size: 20),
                    ),
                    SizedBox(height: 20),

                    Text('Authentication\nSuccessful',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Your Aadhaar identity has been verified. '
                      'You may now proceed to the service.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),

                    Ux4gCard(
                      cornerRadius: 12,
                      backgroundColor: Ux4gPalette.primary50,
                      borderColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 14, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Transaction ID',
                              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            SizedBox(height: 4),
                            Text('TXN-2024-AAD-78432',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Ux4gButton(
                text: 'Continue to Service',
                onPressed: () {},
                size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Aadhaar verification failed (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerificationFailedMockup extends StatelessWidget {
  const _AadhaarVerificationFailedMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red error badge — concentric circles with an
                  // exclamation icon. Same shape language as the
                  // Signed-in success badge but tinted red.
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Ux4gPalette.red100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Ux4gPalette.red600,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.priority_high,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Authentication Failed',
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
                    'The OTP entered is incorrect. You have 2 attempts '
                    'remaining before your account is temporarily locked.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Inline error banner — multi-line subtitle wrap +
                  // attempt-counter pill on the trailing side.
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.errorLight,
                    title:
                        'Verification failed, Please try a different\n'
                        'method or try again',
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    titleStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Ux4gPalette.red800,
                      height: 1.35,
                    ),
                    leadingIcon: Icon(
                      Icons.error,
                      color: Ux4gPalette.red600,
                      size: 18,
                    ),
                    badge: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.red200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Attempt 1 of 2',
                        style: TextStyle(
                          fontSize: 11,
                          color: Ux4gPalette.red800,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Try Different Method (ghost) + Try Again (primary).
          _AadhaarVerifyFooterRow(
            onCancel: () {},
            onContinue: () {},
            cancelLabel: 'Try Different Method',
            continueLabel: 'Try Again',
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Aadhaar verification failed (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarVerificationFailedCardMockup extends StatelessWidget {
  const _AadhaarVerificationFailedCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Ux4gPalette.red100,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.red600,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.priority_high,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Authentication Failed',
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
                            'The OTP entered is incorrect. You have 2 '
                            'attempts remaining before your account is '
                            'temporarily locked.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Subtle divider seen in the reference image.
                          const Divider(
                            height: 16,
                            thickness: 1,
                            color: _border,
                          ),
                          const SizedBox(height: 4),

                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.errorLight,
                            title:
                                'Verification failed, Please try a different\n'
                                'method or try again',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                            titleStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Ux4gPalette.red800,
                              height: 1.35,
                            ),
                            leadingIcon: Icon(
                              Icons.error,
                              color: Ux4gPalette.red600,
                              size: 18,
                            ),
                            badge: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Ux4gPalette.red200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Attempt 1 of 2',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Ux4gPalette.red800,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  _AadhaarVerifyFooterRow(
                    onCancel: () {},
                    onContinue: () {},
                    cancelLabel: 'Try Different Method',
                    continueLabel: 'Try Again',
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

const _aadhaarVerificationFailedCode =
    r'''// Mobile-sized Aadhaar verification-failed screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(/* same header with bordered hamburger action */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Red error badge — concentric circles + exclamation icon.
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: Ux4gPalette.red100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: Ux4gPalette.red600,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.priority_high, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: 16),

          Text('Authentication Failed',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('The OTP entered is incorrect. You have 2 attempts '
            'remaining before your account is temporarily locked.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          SizedBox(height: 16),

          // Error banner with an attempt-counter pill on the side.
          Ux4gStatusBanner(
            variant: Ux4gBannerVariant.errorLight,
            title: 'Verification failed, Please try a different\n'
                'method or try again',
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
            titleStyle: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500,
              color: Ux4gPalette.red800,
            ),
            leadingIcon: Icon(Icons.error,
              color: Ux4gPalette.red600, size: 18),
            badge: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Ux4gPalette.red200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 1 of 2',
                style: TextStyle(fontSize: 11,
                  color: Ux4gPalette.red800,
                  fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    ),

    // Try Different Method (ghost) + Try Again (primary) action footer.
    Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, color: Color(0xFFE5E7EB)),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ux4gButton(
                text: 'Try Different Method',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.medium,
              ),
              Ux4gButton(
                text: 'Try Again',
                onPressed: () {},
                size: Ux4gButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    ),

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ],
      ),
    ),
  ],
)''';

const _aadhaarVerificationFailedCardCode =
    r'''// Mobile-sized card-style Aadhaar verification-failed screen (360 x 760)
Column(
  children: [
    Ux4gAppHeader(/* same header with bordered hamburger action */),
    Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xFFE9E5FF),
        child: Column(
          children: [
            SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    // Red error badge — same as flat variant.
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        color: Ux4gPalette.red100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.red600,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.priority_high,
                          color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(height: 16),

                    Text('Authentication Failed',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('The OTP entered is incorrect. You have 2 '
                      'attempts remaining before your account is '
                      'temporarily locked.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                    SizedBox(height: 12),

                    Divider(height: 16, color: Color(0xFFE5E7EB)),
                    SizedBox(height: 4),

                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.errorLight,
                      title: 'Verification failed, Please try a different\n'
                          'method or try again',
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                      titleStyle: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500,
                        color: Ux4gPalette.red800,
                      ),
                      leadingIcon: Icon(Icons.error,
                        color: Ux4gPalette.red600, size: 18),
                      badge: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Ux4gPalette.red200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Attempt 1 of 2',
                          style: TextStyle(fontSize: 11,
                            color: Ux4gPalette.red800,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Try Different Method + Try Again action footer.
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Ux4gButton(
                    text: 'Try Different Method',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.medium,
                  ),
                  Ux4gButton(
                    text: 'Try Again',
                    onPressed: () {},
                    size: Ux4gButtonSize.medium,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
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
// Aadhaar account locked (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarAccountLockedMockup extends StatelessWidget {
  const _AadhaarAccountLockedMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red lock badge
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF2F2), // Very light red
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Ux4gPalette.red100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock,
                        color: Ux4gPalette.red600,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Account Locked',
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
                    'Your Aadhaar authentication has been suspended due to too many failed attempts.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Yellow countdown box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB), // light yellow
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Try again in',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF92400E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '23:45:00',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF92400E),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your account will be unlocked automatically. If you need immediate assistance, contact UIDAI support.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF92400E),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Ux4gButton(
              text: 'Contact UIDAI Support',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
              leadingIcon: Icons.support,
            ),
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Aadhaar account locked (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AadhaarAccountLockedCardMockup extends StatelessWidget {
  const _AadhaarAccountLockedCardMockup();

  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                          // Red lock badge
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFEF2F2),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.red100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock,
                                color: Ux4gPalette.red600,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Account Locked',
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
                            'Your Aadhaar authentication has been suspended due to too many failed attempts.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Yellow countdown box
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Try again in',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF92400E),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '23:45:00',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF92400E),
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Your account will be unlocked automatically. If you need immediate assistance, contact UIDAI support.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF92400E),
                                    height: 1.4,
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

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Ux4gButton(
                      text: 'Contact UIDAI Support',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      height: 48,
                      width: 326,
                      leadingIcon: Icons.support,
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

const _aadhaarAccountLockedCode =
    r'''// Mobile-sized Aadhaar account-locked screen (360 x 760)
Container(
  width: 360,
  height: 760,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xFFE5E7EB)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 24,
        offset: Offset(0, 6),
      ),
    ],
  ),
  child: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/icons/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/icons/Union.svg', height: 32),
        ],
        actions: [
          Ux4gAppHeaderAction(
            customWidget: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE9E5FF), width: 1.5),
              ),
              child: Icon(Icons.menu, size: 20, color: Color(0xFF4F46E5)),
            ),
          ),
        ],
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Red lock badge — concentric circles with a lock icon.
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  color: Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFFEE2E2), // red100
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.lock, color: Color(0xFFDC2626), size: 22), // red600
                ),
              ),
              SizedBox(height: 16),

              Text('Account Locked',
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  height: 1.2,
                  letterSpacing: -0.3,
                )),
              SizedBox(height: 8),
              Text('Your Aadhaar authentication has been suspended due to too many failed attempts.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.35)),
              SizedBox(height: 24),

              // Yellow countdown box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text('Try again in',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                    SizedBox(height: 8),
                    Text('23:45:00',
                      style: TextStyle(
                        fontSize: 36, 
                        fontWeight: FontWeight.w800, 
                        color: Color(0xFF92400E),
                        letterSpacing: 1,
                      )),
                    SizedBox(height: 16),
                    Text('Your account will be unlocked automatically. If you need immediate assistance, contact UIDAI support.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Color(0xFF92400E), height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Ux4gButton(
          text: 'Contact UIDAI Support',
          onPressed: () {},
          variant: Ux4gButtonVariant.outline,
          size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
          leadingIcon: Icons.support,
        ),
      ),
      
      // Brand Footer
      Padding(
        padding: EdgeInsets.only(bottom: 20, top: 8),
        child: Column(
          children: [
            Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            SizedBox(height: 6),
            Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
          ],
        ),
      ),
    ],
  ),
)''';

const _aadhaarAccountLockedCardCode =
    r'''// Mobile-sized card-style Aadhaar account-locked screen (360 x 760)
Container(
  width: 360,
  height: 760,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xFFE5E7EB)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 24,
        offset: Offset(0, 6),
      ),
    ],
  ),
  child: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/icons/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/icons/Union.svg', height: 32),
        ],
        actions: [
          Ux4gAppHeaderAction(
            customWidget: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE9E5FF), width: 1.5),
              ),
              child: Icon(Icons.menu, size: 20, color: Color(0xFF4F46E5)),
            ),
          ),
        ],
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      Expanded(
        child: Container(
          width: double.infinity,
          color: Color(0xFFE9E5FF), // Soft purple background
          child: Column(
            children: [
              SizedBox(height: 16),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Red lock badge
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          color: Color(0xFFFEF2F2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFFEE2E2), // red100
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.lock, color: Color(0xFFDC2626), size: 22),
                        ),
                      ),
                      SizedBox(height: 16),

                      Text('Account Locked',
                        style: TextStyle(
                          fontSize: 26, 
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        )),
                      SizedBox(height: 8),
                      Text('Your Aadhaar authentication has been suspended due to too many failed attempts.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.35)),
                      SizedBox(height: 24),

                      // Yellow countdown box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('Try again in',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                            SizedBox(height: 8),
                            Text('23:45:00',
                              style: TextStyle(
                                fontSize: 36, 
                                fontWeight: FontWeight.w800, 
                                color: Color(0xFF92400E),
                                letterSpacing: 1,
                              )),
                            SizedBox(height: 16),
                            Text('Your account will be unlocked automatically. If you need immediate assistance, contact UIDAI support.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13, color: Color(0xFF92400E), height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Spacer(),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Ux4gButton(
                  text: 'Contact UIDAI Support',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.outline,
                  size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                  leadingIcon: Icons.support,
                ),
              ),
              
              // Brand Footer
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  children: [
                    Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)''';

// ───────────────────────────────────────────────────────────────────────
// Operator-assisted authentication (mobile mockup)
// ───────────────────────────────────────────────────────────────────────
class _OperatorAssistedAuthMockup extends StatefulWidget {
  const _OperatorAssistedAuthMockup();

  @override
  State<_OperatorAssistedAuthMockup> createState() =>
      _OperatorAssistedAuthMockupState();
}

class _OperatorAssistedAuthMockupState
    extends State<_OperatorAssistedAuthMockup> {
  bool _consent = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),
                  const SizedBox(height: 16),

                  const Text(
                    'Operator-Assisted Authentication',
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
                    'A certified VLE operator will conduct this Aadhaar verification on your behalf with your consent.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Operator Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3FF), // Light purple
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'VLE Operator',
                          style: TextStyle(fontSize: 13, color: _subtleText),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Ramesh Kumar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _titleColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ID: VLE-MH-2024-00387 · Certified by MeitY',
                          style: TextStyle(fontSize: 12, color: _mutedText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Consent Checkbox
                  Ux4gCheckbox(
                    value: _consent,
                    onChanged: (v) => setState(() => _consent = v ?? false),
                    isRequired: true,
                    label:
                        'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
                  ),
                ],
              ),
            ),
          ),

          _AadhaarVerifyFooterRow(
            onCancel: () {},
            onContinue: () {},
            continueLabel: 'Proceed with Consent',
          ),
          const _BrandFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Operator-assisted authentication (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _OperatorAssistedAuthCardMockup extends StatefulWidget {
  const _OperatorAssistedAuthCardMockup();

  @override
  State<_OperatorAssistedAuthCardMockup> createState() =>
      _OperatorAssistedAuthCardMockupState();
}

class _OperatorAssistedAuthCardMockupState
    extends State<_OperatorAssistedAuthCardMockup> {
  bool _consent = false;
  Color _getCardBg(BuildContext context) =>
      _isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _getCardBg(context),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BackButton(),
                          const SizedBox(height: 12),

                          const Text(
                            'Operator-Assisted Authentication',
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
                            'A certified VLE operator will conduct this Aadhaar verification on your behalf with your consent.',
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Operator Info Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F3FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'VLE Operator',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _subtleText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Ramesh Kumar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: _titleColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'ID: VLE-MH-2024-00387 · Certified by MeitY',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _mutedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Consent Checkbox
                          Ux4gCheckbox(
                            value: _consent,
                            onChanged: (v) =>
                                setState(() => _consent = v ?? false),
                            isRequired: true,
                            label:
                                'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  _AadhaarVerifyFooterRow(
                    onCancel: () {},
                    onContinue: () {},
                    continueLabel: 'Proceed with Consent',
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

const _operatorAssistedAuthCode =
    r'''// Mobile-sized Operator-assisted authentication (360 x 760)
Container(
  width: 360,
  height: 760,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xFFE5E7EB)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 24,
        offset: Offset(0, 6),
      ),
    ],
  ),
  child: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/icons/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/icons/Union.svg', height: 32),
        ],
        actions: [
          Ux4gAppHeaderAction(
            customWidget: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE9E5FF), width: 1.5),
              ),
              child: Icon(Icons.menu, size: 20, color: Color(0xFF4F46E5)),
            ),
          ),
        ],
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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

              Text('Operator-Assisted Authentication',
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  height: 1.2,
                  letterSpacing: -0.3,
                )),
              SizedBox(height: 8),
              Text('A certified VLE operator will conduct this Aadhaar verification on your behalf with your consent.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.35)),
              SizedBox(height: 24),

              // Operator Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VLE Operator', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 4),
                    Text('Ramesh Kumar', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    SizedBox(height: 8),
                    Text('ID: VLE-MH-2024-00387 · Certified by MeitY',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Consent Checkbox
              Ux4gCheckbox(
                value: consent,
                onChanged: (v) => setState(() => consent = v ?? false),
                isRequired: true,
                label: 'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
              ),
            ],
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Ux4gButton(
              text: 'Cancel', 
              onPressed: () {}, 
              variant: Ux4gButtonVariant.ghost,
              textColor: Color(0xFF4F46E5),
            ),
            Ux4gButton(
              text: 'Proceed with Consent', 
              onPressed: () {},
              variant: Ux4gButtonVariant.primary,
            ),
          ],
        ),
      ),
      
      // Brand Footer
      Padding(
        padding: EdgeInsets.only(bottom: 20, top: 8),
        child: Column(
          children: [
            Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            SizedBox(height: 6),
            Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
          ],
        ),
      ),
    ],
  ),
)''';

const _operatorAssistedAuthCardCode =
    r'''// Mobile-sized card-style Operator-assisted authentication (360 x 760)
Container(
  width: 360,
  height: 760,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xFFE5E7EB)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 24,
        offset: Offset(0, 6),
      ),
    ],
  ),
  child: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/icons/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/icons/Union.svg', height: 32),
        ],
        actions: [
          Ux4gAppHeaderAction(
            customWidget: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE9E5FF), width: 1.5),
              ),
              child: Icon(Icons.menu, size: 20, color: Color(0xFF4F46E5)),
            ),
          ),
        ],
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      Expanded(
        child: Container(
          width: double.infinity,
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              SizedBox(height: 16),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
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
                      SizedBox(height: 12),

                      Text('Operator-Assisted Authentication',
                        style: TextStyle(
                          fontSize: 26, 
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        )),
                      SizedBox(height: 8),
                      Text('A certified VLE operator will conduct this Aadhaar verification on your behalf with your consent.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.35)),
                      SizedBox(height: 20),

                      // Operator Info Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F3FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VLE Operator', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            SizedBox(height: 4),
                            Text('Ramesh Kumar', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                            SizedBox(height: 8),
                            Text('ID: VLE-MH-2024-00387 · Certified by MeitY',
                              style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Consent Checkbox
                      Ux4gCheckbox(
                        value: consent,
                        onChanged: (v) => setState(() => consent = v ?? false),
                        isRequired: true,
                        label: 'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
                      ),
                    ],
                  ),
                ),
              ),

              Spacer(),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Column(
                  children: [
                    Divider(height: 1, color: Color(0xFFD1D5DB)),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Ux4gButton(
                          text: 'Cancel', 
                          onPressed: () {}, 
                          variant: Ux4gButtonVariant.ghost,
                          textColor: Color(0xFF4F46E5),
                        ),
                        Ux4gButton(
                          text: 'Proceed with Consent', 
                          onPressed: () {},
                          variant: Ux4gButtonVariant.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Brand Footer
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  children: [
                    Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)''';

// ---------------------------------------------------------------------------
// SIGN UP PATTERN
// 5 steps mirroring the SignIn card / default style.
// Each component has a [Variant] knob: Default (flat) ? Card style (purple-bg).
// ---------------------------------------------------------------------------

/// "Already have an account? Sign in" link � mirror of [_RegisterLink].
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
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF991B1B),
      height: 1.3,
    ),
    subtitleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Color(0xFF991B1B),
      height: 1.3,
    ),
    leadingIcon: const Icon(
      Icons.error_outline,
      color: Color(0xFFDC2626),
      size: 20,
    ),
    trailingIcon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        badge,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF991B1B),
          fontWeight: FontWeight.w500,
          height: 1.2,
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

// -----------------------------------------------------------------------
// STEP 1 � Create your account
// -----------------------------------------------------------------------

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
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Create your account',
          description:
              'First step of the sign-up flow. User enters their +91 mobile number '
              'and taps Send OTP. An error banner appears on invalid input.',
          code: variant == 'Card style'
              ? _signUpStep1CardCode
              : _signUpStep1Code,
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
                  const Text(
                    'Create your account',
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
                    'Enter your mobile number to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    prefixText: '+91',
                    type: Ux4gInputFieldType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),
                  _signUpErrorBanner(),
                  const SizedBox(height: 20),
                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
                  ),
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
                            const Text(
                              'Create your account',
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
                              'Enter your mobile number to get started',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gInputField(
                              value: _mobile,
                              onValueChange: (v) => setState(() => _mobile = v),
                              label: 'Mobile Number',
                              placeholder: 'Enter mobile number',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              prefixText: '+91',
                              type: Ux4gInputFieldType.number,
                              maxLength: 10,
                            ),
                            const SizedBox(height: 12),
                            _signUpErrorBanner(),
                            const SizedBox(height: 16),
                            Ux4gButton(
                              text: 'Send OTP',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _signUpStep1Code = r'''// Step 1 � Create your account (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Register to access government services',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gInputField(
              value: mobile, onValueChange: (v) => setState(() => mobile = v),
              label: 'Mobile Number', placeholder: 'Enter mobile number',
              prefixText: '+91',
              type: Ux4gInputFieldType.number, maxLength: 10,
            ),
            SizedBox(height: 16),
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
                    color: Ux4gPalette.red800, fontWeight: FontWeight.w500)),
              ),
            ),
            SizedBox(height: 20),
            Ux4gButton(
              text: 'Send OTP', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 20),
            Center(child: TextButton(
              onPressed: () {},
              child: Text('Already have an account? Sign in'),
            )),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _signUpStep1CardCode =
    r'''// Step 1 � Create your account, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create your account',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Register to access government services',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),
                    Ux4gInputField(
                      value: mobile, onValueChange: (v) => setState(() => mobile = v),
                      label: 'Mobile Number', placeholder: 'Enter mobile number',
                      prefixText: '+91',
                      type: Ux4gInputFieldType.number, maxLength: 10,
                    ),
                    SizedBox(height: 14),
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.errorLight,
                      title: 'Your status message goes here',
                      subtitle: 'Take action',
                      margin: EdgeInsets.zero,
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
                            color: Ux4gPalette.red800, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Ux4gButton(
                      text: 'Send OTP', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                    SizedBox(height: 14),
                    Center(child: TextButton(
                      onPressed: () {},
                      child: Text('Already have an account? Sign in'),
                    )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 2 � Verify your mobile
// -----------------------------------------------------------------------

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
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Verify your mobile',
          description:
              'OTP verification screen with 6 single-digit boxes, a built-in '
              '60-second resend countdown, and a Verify OTP action.',
          code: variant == 'Card style'
              ? _signUpStep2CardCode
              : _signUpStep2Code,
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
                  const Text(
                    'Verify your mobile',
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
                    'Enter the 6-digit OTP sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
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
                    onCaptionTrailingTap: () => setState(() {
                      _otp = '';
                      _resendNonce++;
                    }),
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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
                            const Text(
                              'Verify your mobile',
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
                              'Enter the 6-digit OTP sent to +91 98765 XXXXX',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
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
                              onCaptionTrailingTap: () => setState(() {
                                _otp = '';
                                _resendNonce++;
                              }),
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(
                              text: 'Verify OTP',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _signUpStep2Code = r'''// Step 2 � Verify your mobile (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verify your mobile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Enter the 6-digit OTP sent to +91 98765 XXXXX',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 28),
            Ux4gOtpInput(
              length: 6,
              value: otp, onChanged: (v) => setState(() => otp = v),
              boxSize: 44, gap: 8,
              showSeparator: true,
              captionVariant: Ux4gOtpCaptionVariant.resendTimer,
              captionLeadingText: "Didn't receive OTP?",
              captionTrailingText: 'Resend',
              autoCountdownSeconds: 60,
              onCaptionTrailingTap: () => setState(() => otp = ''),
            ),
            SizedBox(height: 28),
            Ux4gButton(
              text: 'Verify OTP', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _signUpStep2CardCode =
    r'''// Step 2 � Verify your mobile, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verify your mobile',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Enter the 6-digit OTP sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 24),
                    Ux4gOtpInput(
                      length: 6,
                      value: otp, onChanged: (v) => setState(() => otp = v),
                      boxSize: 44, gap: 8,
                      showSeparator: true,
                      captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                      captionLeadingText: "Didn't receive OTP?",
                      captionTrailingText: 'Resend',
                      autoCountdownSeconds: 60,
                      onCaptionTrailingTap: () => setState(() => otp = ''),
                    ),
                    SizedBox(height: 24),
                    Ux4gButton(
                      text: 'Verify OTP', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 3 � Complete your profile
// -----------------------------------------------------------------------

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
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Complete your profile',
          description:
              'Profile completion screen. Collects full name, email, mobile, '
              'and category before continuing to password setup.',
          code: variant == 'Card style'
              ? _signUpStep3CardCode
              : _signUpStep3Code,
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
                  Ux4gInputField(
                    value: _fullName,
                    onValueChange: (v) => setState(() => _fullName = v),
                    label: 'Full name',
                    placeholder: 'Enter your full name',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: _email,
                    onValueChange: (v) => setState(() => _email = v),
                    label: 'Email Address',
                    placeholder: 'example@mail.com',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    type: Ux4gInputFieldType.email,
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    prefixText: '+91',
                    type: Ux4gInputFieldType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Ux4gSelectionDropdown(
                    options: _cats,
                    selectedOptionIds: _category,
                    onSelectionChange: (ids) => setState(() => _category = ids),
                    placeholder: 'Please select..',
                    mode: Ux4gDropdownMode.single,
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(
                    text: 'Continue',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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
                            Ux4gInputField(
                              value: _fullName,
                              onValueChange: (v) =>
                                  setState(() => _fullName = v),
                              label: 'Full name',
                              placeholder: 'Enter your full name',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Ux4gInputField(
                              value: _email,
                              onValueChange: (v) => setState(() => _email = v),
                              label: 'Email Address',
                              placeholder: 'example@mail.com',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              type: Ux4gInputFieldType.email,
                            ),
                            const SizedBox(height: 14),
                            Ux4gInputField(
                              value: _mobile,
                              onValueChange: (v) => setState(() => _mobile = v),
                              label: 'Mobile Number',
                              placeholder: 'Enter mobile number',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              prefixText: '+91',
                              type: Ux4gInputFieldType.number,
                              maxLength: 10,
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _titleColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Ux4gSelectionDropdown(
                              options: _cats,
                              selectedOptionIds: _category,
                              onSelectionChange: (ids) =>
                                  setState(() => _category = ids),
                              placeholder: 'Please select..',
                              mode: Ux4gDropdownMode.single,
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(
                              text: 'Continue',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _signUpStep3Code = r'''// Step 3 � Complete your profile (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Complete your profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Help us personalise your experience',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gInputField(
              value: fullName, onValueChange: (v) => setState(() => fullName = v),
              label: 'Full name', placeholder: 'Enter your full name',
            ),
            SizedBox(height: 16),
            Ux4gInputField(
              value: email, onValueChange: (v) => setState(() => email = v),
              label: 'Email Address', placeholder: 'example@mail.com',
              type: Ux4gInputFieldType.email,
            ),
            SizedBox(height: 16),
            Ux4gInputField(
              value: mobile, onValueChange: (v) => setState(() => mobile = v),
              label: 'Mobile Number', prefixText: '+91',
              type: Ux4gInputFieldType.number, maxLength: 10,
            ),
            SizedBox(height: 16),
            Text('Category',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Ux4gSelectionDropdown(
              options: ['Citizen', 'Government Official', 'Business'],
              placeholder: 'Please select..',
              mode: Ux4gDropdownMode.single,
              onChanged: (v) {},
            ),
            SizedBox(height: 28),
            Ux4gButton(
              text: 'Continue', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _signUpStep3CardCode =
    r'''// Step 3 � Complete your profile, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Complete your profile',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Help us personalise your experience',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),
                    Ux4gInputField(
                      value: fullName, onValueChange: (v) => setState(() => fullName = v),
                      label: 'Full name', placeholder: 'Enter your full name',
                    ),
                    SizedBox(height: 14),
                    Ux4gInputField(
                      value: email, onValueChange: (v) => setState(() => email = v),
                      label: 'Email Address', placeholder: 'example@mail.com',
                      type: Ux4gInputFieldType.email,
                    ),
                    SizedBox(height: 14),
                    Ux4gInputField(
                      value: mobile, onValueChange: (v) => setState(() => mobile = v),
                      label: 'Mobile Number', prefixText: '+91',
                      type: Ux4gInputFieldType.number, maxLength: 10,
                    ),
                    SizedBox(height: 14),
                    Text('Category',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Ux4gSelectionDropdown(
                      options: ['Citizen', 'Government Official', 'Business'],
                      placeholder: 'Please select..',
                      mode: Ux4gDropdownMode.single,
                      onChanged: (v) {},
                    ),
                    SizedBox(height: 24),
                    Ux4gButton(
                      text: 'Continue', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 4 � Password setup
// -----------------------------------------------------------------------

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
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Password setup',
          description:
              'Password creation screen. User sets and confirms their account '
              'password before the account is created.',
          code: variant == 'Card style'
              ? _signUpStep4CardCode
              : _signUpStep4Code,
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
                  const Text(
                    'Password setup',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gInputField(
                    value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password',
                    placeholder: '...........',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: _confirm,
                    onValueChange: (v) => setState(() => _confirm = v),
                    label: 'Confirm password',
                    placeholder: '...........',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(
                    text: 'Create account',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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
                            const Text(
                              'Password setup',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gInputField(
                              value: _password,
                              onValueChange: (v) =>
                                  setState(() => _password = v),
                              label: 'Password',
                              placeholder: '...........',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              type: Ux4gInputFieldType.password,
                            ),
                            const SizedBox(height: 16),
                            Ux4gInputField(
                              value: _confirm,
                              onValueChange: (v) =>
                                  setState(() => _confirm = v),
                              label: 'Confirm password',
                              placeholder: '...........',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              type: Ux4gInputFieldType.password,
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(
                              text: 'Create account',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _signUpStep4Code = r'''// Step 4 � Password setup (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Password setup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Create a strong password for your account',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gInputField(
              value: password, onValueChange: (v) => setState(() => password = v),
              label: 'Password', placeholder: '...........',
              type: Ux4gInputFieldType.password,
            ),
            SizedBox(height: 16),
            Ux4gInputField(
              value: confirm, onValueChange: (v) => setState(() => confirm = v),
              label: 'Confirm password', placeholder: '...........',
              type: Ux4gInputFieldType.password,
            ),
            SizedBox(height: 28),
            Ux4gButton(
              text: 'Create account', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _signUpStep4CardCode =
    r'''// Step 4 � Password setup, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password setup',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Create a strong password for your account',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),
                    Ux4gInputField(
                      value: password, onValueChange: (v) => setState(() => password = v),
                      label: 'Password', placeholder: '...........',
                      type: Ux4gInputFieldType.password,
                    ),
                    SizedBox(height: 14),
                    Ux4gInputField(
                      value: confirm, onValueChange: (v) => setState(() => confirm = v),
                      label: 'Confirm password', placeholder: '...........',
                      type: Ux4gInputFieldType.password,
                    ),
                    SizedBox(height: 24),
                    Ux4gButton(
                      text: 'Create account', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 5 � Account Created
// -----------------------------------------------------------------------

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
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Account Created',
          description:
              'Success screen after registration. Offers a recommended action to '
              'link Aadhaar or skip to browse services.',
          code: variant == 'Card style'
              ? _signUpStep5CardCode
              : _signUpStep5Code,
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
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Ux4gPalette.green100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Ux4gPalette.green,
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
                    'Account Created!',
                    textAlign: TextAlign.center,
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
                    'Welcome, Ramesh Kumar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: const Text(
                      'RECOMMENDED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Link Aadhaar Now',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Skip and Browse Services',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'You can link Aadhaar later from your profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: _subtleText,
                      height: 1.4,
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
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Ux4gPalette.green,
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
                              'Account Created!',
                              textAlign: TextAlign.center,
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
                              'Welcome, Ramesh Kumar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFFDE68A),
                                ),
                              ),
                              child: const Text(
                                'RECOMMENDED',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF92400E),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Ux4gButton(
                              text: 'Link Aadhaar Now',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Ux4gButton(
                              text: 'Skip and Browse Services',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'You can link Aadhaar later from your profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
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

const _signUpStep5Code = r'''// Step 5 � Account Created (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: Ux4gPalette.green100, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Ux4gPalette.green, shape: BoxShape.circle),
                child: Icon(Icons.check, color: Colors.white, size: 22),
              ),
            ),
            SizedBox(height: 24),
            Text('Account Created!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                color: Color(0xFF16A34A))),
            SizedBox(height: 8),
            Text('Welcome, Ramesh Kumar',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('RECOMMENDED',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                  color: Color(0xFF1D4ED8), letterSpacing: 0.5)),
            ),
            SizedBox(height: 12),
            Ux4gButton(
              text: 'Link Aadhaar Now', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 12),
            Ux4gButton(
              text: 'Skip and Browse Services', onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 16),
            Text('You can link Aadhaar later from your profile',
              style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _signUpStep5CardCode =
    r'''// Step 5 � Account Created, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 32, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        color: Ux4gPalette.green100, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.green, shape: BoxShape.circle),
                        child: Icon(Icons.check, color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Account Created!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800,
                        color: Color(0xFF16A34A))),
                    SizedBox(height: 6),
                    Text('Welcome, Ramesh Kumar',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('RECOMMENDED',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                          color: Color(0xFF1D4ED8), letterSpacing: 0.5)),
                    ),
                    SizedBox(height: 12),
                    Ux4gButton(
                      text: 'Link Aadhaar Now', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                    SizedBox(height: 10),
                    Ux4gButton(
                      text: 'Skip and Browse Services', onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                    SizedBox(height: 14),
                    Text('You can link Aadhaar later from your profile',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// ---------------------------------------------------------------------------
// FORGOT PASSWORD & ACCOUNT RECOVERY PATTERN
// 5 screens: Reset Password ? Enter OTP ? Create new password ?
//            Password reset successfully ? Account recovery
// Each component has a [Variant] knob: Default ? Card style.
// ---------------------------------------------------------------------------

/// Reusable back-navigation button for FP screens.
/// Uses the same ghost [Ux4gButton] style as the Sign In screen's back button.
class _NavLink extends StatelessWidget {
  const _NavLink({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Ux4gButton(
      text: label,
      onPressed: () {},
      variant: Ux4gButtonVariant.ghost,
      size: Ux4gButtonSize.small,
      leadingIcon: Icons.arrow_back,
      iconSize: 18,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }
}

/// Warning banner for "Most services use OTP login..." note.
Widget _fpWarningBanner() => Ux4gStatusBanner(
  variant: Ux4gBannerVariant.warningLight,
  title: 'Most services use OTP login so you may not need a password.',
  margin: EdgeInsets.zero,
  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
  titleStyle: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xFF92400E),
    height: 1.4,
  ),
  leadingIcon: const Icon(
    Icons.info_outline_rounded,
    color: Color(0xFFD97706),
    size: 18,
  ),
);

/// Password strength row (Ux4gLinearProgress + checklist).
Widget _passwordStrength() {
  const greenCheck = Icon(
    Icons.check_circle_rounded,
    color: Color(0xFF16A34A),
    size: 16,
  );
  const redX = Icon(Icons.error, color: Color(0xFFDC2626), size: 16);
  const itemStyle = TextStyle(fontSize: 13, color: Color(0xFF374151));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Ux4gLinearProgress(
        value: 0.85,
        gradientColors: const [Color(0xFF86EFAC), Color(0xFF15803D)],
        trackColor: const Color(0xFFE5E7EB),
        shape: Ux4gProgressShape.rounded,
        height: 8,
      ),
      const SizedBox(height: 6),
      const Text(
        'Password Strength: Strong',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF16A34A),
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          greenCheck,
          const SizedBox(width: 6),
          const Text('8+ characters', style: itemStyle),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          greenCheck,
          const SizedBox(width: 6),
          const Text('Uppercase letter', style: itemStyle),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          greenCheck,
          const SizedBox(width: 6),
          const Text('Number', style: itemStyle),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          redX,
          const SizedBox(width: 6),
          const Text('Special character', style: itemStyle),
        ],
      ),
    ],
  );
}

// -----------------------------------------------------------------------
// STEP 1 � Reset Password
// -----------------------------------------------------------------------

final fpStep1Component = WidgetbookComponent(
  name: 'Reset Password',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Reset Password',
          description:
              'Entry point for the forgot-password flow. User enters their '
              'registered mobile number to receive an OTP.',
          code: variant == 'Card style' ? _fpStep1CardCode : _fpStep1Code,
          center: true,
          child: variant == 'Card style'
              ? const _FpStep1CardMockup()
              : const _FpStep1Mockup(),
        );
      },
    ),
  ],
);

class _FpStep1Mockup extends StatefulWidget {
  const _FpStep1Mockup();
  @override
  State<_FpStep1Mockup> createState() => _FpStep1MockupState();
}

class _FpStep1MockupState extends State<_FpStep1Mockup> {
  String _mobile = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _NavLink(label: 'Back to Sign In'),
                  const SizedBox(height: 20),
                  const Text(
                    'Reset Password',
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
                    'Enter your registered mobile number to receive a verification code',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gInputField(
                    value: _mobile,
                    onValueChange: (v) => setState(() => _mobile = v),
                    label: 'Mobile Number',
                    placeholder: 'Enter mobile number',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    prefixText: '+91',
                    type: Ux4gInputFieldType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 20),
                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                      ),
                      child: Text(
                        'Recover account using Aadhaar Number  ?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                  Ux4gButton(
                    text: 'Sign in with OTP instead',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
                  ),
                  const SizedBox(height: 16),
                  _fpWarningBanner(),
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

class _FpStep1CardMockup extends StatefulWidget {
  const _FpStep1CardMockup();
  @override
  State<_FpStep1CardMockup> createState() => _FpStep1CardMockupState();
}

class _FpStep1CardMockupState extends State<_FpStep1CardMockup> {
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
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _NavLink(label: 'Back to Sign In'),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: _suCardDeco(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Reset Password',
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
                                  'Enter your registered mobile number to receive a verification code',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _subtleText,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Ux4gInputField(
                                  value: _mobile,
                                  onValueChange: (v) =>
                                      setState(() => _mobile = v),
                                  label: 'Mobile Number',
                                  placeholder: 'Enter mobile number',
                                  placeholderStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Ux4gPalette.neutral500
                                        : Ux4gPalette.neutral400,
                                    height: 1.3,
                                  ),
                                  prefixText: '+91',
                                  type: Ux4gInputFieldType.number,
                                  maxLength: 10,
                                ),
                                const SizedBox(height: 16),
                                Ux4gButton(
                                  text: 'Send OTP',
                                  onPressed: () {},
                                  size: Ux4gButtonSize.large,
                                  height: 48,
                                  width: 326,
                                ),
                                const SizedBox(height: 12),
                                Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 4,
                                      ),
                                    ),
                                    child: Text(
                                      'Recover account using Aadhaar Number  ?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: const [
                                    Expanded(
                                      child: Divider(
                                        color: _border,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        'OR',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _mutedText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: _border,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Ux4gButton(
                                  text: 'Sign in with OTP instead',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.outline,
                                  size: Ux4gButtonSize.large,
                                  height: 48,
                                  width: 326,
                                ),
                                const SizedBox(height: 14),
                                _fpWarningBanner(),
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
            ),
          ),
        ],
      ),
    );
  }
}

const _fpStep1Code = r'''// FP Step 1 � Reset Password (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gButton(
              text: 'Back to Sign In', onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.small,
              leadingIcon: Icons.arrow_back, iconSize: 18,
            ),
            SizedBox(height: 16),
            Text('Reset Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Enter your registered mobile number',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gInputField(
              value: mobile, onValueChange: (v) => setState(() => mobile = v),
              label: 'Mobile Number', placeholder: 'Enter mobile number',
              prefixText: '+91',
              type: Ux4gInputFieldType.number, maxLength: 10,
            ),
            SizedBox(height: 20),
            Ux4gButton(
              text: 'Send OTP', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Recover account using Aadhaar Number ?',
                  style: TextStyle(fontSize: 13)),
              ),
            ),
            SizedBox(height: 12),
            Row(children: [
              Expanded(child: Divider(color: Color(0xFFE5E7EB))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('OR', style: TextStyle(fontSize: 12,
                  color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
              ),
              Expanded(child: Divider(color: Color(0xFFE5E7EB))),
            ]),
            SizedBox(height: 12),
            Ux4gButton(
              text: 'Sign in with OTP instead', onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            SizedBox(height: 16),
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.warningLight,
              title: 'Most services use OTP login so you may not need a password.',
              margin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _fpStep1CardCode =
    r'''// FP Step 1 � Reset Password, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.red500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Back to Sign In', onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back, iconSize: 18,
                    ),
                    SizedBox(height: 12),
                    Text('Reset Password',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Enter your registered mobile number',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 18),
                    Ux4gInputField(
                      value: mobile, onValueChange: (v) => setState(() => mobile = v),
                      label: 'Mobile Number', placeholder: 'Enter mobile number',
                      prefixText: '+91',
                      type: Ux4gInputFieldType.number, maxLength: 10,
                    ),
                    SizedBox(height: 16),
                    Ux4gButton(
                      text: 'Send OTP', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Recover account using Aadhaar Number ?',
                          style: TextStyle(fontSize: 13)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('OR', style: TextStyle(fontSize: 12,
                          color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                    ]),
                    SizedBox(height: 10),
                    Ux4gButton(
                      text: 'Sign in with OTP instead', onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                    SizedBox(height: 14),
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Most services use OTP login so you may not need a password.',
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 2 � Enter OTP
// -----------------------------------------------------------------------

final fpStep2Component = WidgetbookComponent(
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
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Enter OTP',
          description: 'OTP verification screen for the password reset flow.',
          code: variant == 'Card style' ? _fpStep2CardCode : _fpStep2Code,
          center: true,
          child: variant == 'Card style'
              ? const _FpStep2CardMockup()
              : const _FpStep2Mockup(),
        );
      },
    ),
  ],
);

class _FpStep2Mockup extends StatefulWidget {
  const _FpStep2Mockup();
  @override
  State<_FpStep2Mockup> createState() => _FpStep2MockupState();
}

class _FpStep2MockupState extends State<_FpStep2Mockup> {
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _NavLink(label: 'Change mobile number'),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter OTP',
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
                    'Sent to +91 98765 XXXXX',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Ux4gOtpInput(
                    key: ValueKey('fp2_$_resendNonce'),
                    length: 6,
                    value: _otp,
                    onChanged: (v) => setState(() => _otp = v),
                    boxSize: 44,
                    gap: 8,
                    showSeparator: true,
                    captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                    captionLeadingText: "Didn't receive OTP?",
                    captionTrailingText: 'Resend',
                    autoCountdownSeconds: 60,
                    onCaptionTrailingTap: () => setState(() {
                      _otp = '';
                      _resendNonce++;
                    }),
                  ),
                  const SizedBox(height: 28),
                  Ux4gButton(
                    text: 'Verify OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

class _FpStep2CardMockup extends StatefulWidget {
  const _FpStep2CardMockup();
  @override
  State<_FpStep2CardMockup> createState() => _FpStep2CardMockupState();
}

class _FpStep2CardMockupState extends State<_FpStep2CardMockup> {
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
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _NavLink(label: 'Change mobile number'),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: _suCardDeco(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Enter OTP',
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
                                  'Sent to +91 98765 XXXXX',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _subtleText,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Ux4gOtpInput(
                                  key: ValueKey('fp2c_$_resendNonce'),
                                  length: 6,
                                  value: _otp,
                                  onChanged: (v) => setState(() => _otp = v),
                                  boxSize: 44,
                                  gap: 8,
                                  showSeparator: true,
                                  captionVariant:
                                      Ux4gOtpCaptionVariant.resendTimer,
                                  captionLeadingText: "Didn't receive OTP?",
                                  captionTrailingText: 'Resend',
                                  autoCountdownSeconds: 60,
                                  onCaptionTrailingTap: () => setState(() {
                                    _otp = '';
                                    _resendNonce++;
                                  }),
                                ),
                                const SizedBox(height: 24),
                                Ux4gButton(
                                  text: 'Verify OTP',
                                  onPressed: () {},
                                  size: Ux4gButtonSize.large,
                                  height: 48,
                                  width: 326,
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
            ),
          ),
        ],
      ),
    );
  }
}

const _fpStep2Code = r'''// FP Step 2 � Enter OTP (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gButton(
              text: 'Change mobile number', onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.small,
              leadingIcon: Icons.arrow_back, iconSize: 18,
            ),
            SizedBox(height: 16),
            Text('Enter OTP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Sent to +91 98765 XXXXX',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 28),
            Ux4gOtpInput(
              length: 6,
              value: otp, onChanged: (v) => setState(() => otp = v),
              boxSize: 44, gap: 8,
              showSeparator: true,
              captionVariant: Ux4gOtpCaptionVariant.resendTimer,
              captionLeadingText: "Didn't receive OTP?",
              captionTrailingText: 'Resend',
              autoCountdownSeconds: 60,
              onCaptionTrailingTap: () => setState(() => otp = ''),
            ),
            SizedBox(height: 28),
            Ux4gButton(
              text: 'Verify OTP', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _fpStep2CardCode = r'''// FP Step 2 � Enter OTP, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gButton(
                      text: 'Change mobile number', onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back, iconSize: 18,
                    ),
                    SizedBox(height: 12),
                    Text('Enter OTP',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Sent to +91 98765 XXXXX',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 24),
                    Ux4gOtpInput(
                      length: 6,
                      value: otp, onChanged: (v) => setState(() => otp = v),
                      boxSize: 44, gap: 8,
                      showSeparator: true,
                      captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                      captionLeadingText: "Didn't receive OTP?",
                      captionTrailingText: 'Resend',
                      autoCountdownSeconds: 60,
                      onCaptionTrailingTap: () => setState(() => otp = ''),
                    ),
                    SizedBox(height: 24),
                    Ux4gButton(
                      text: 'Verify OTP', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 3 � Create new password
// -----------------------------------------------------------------------

final fpStep3Component = WidgetbookComponent(
  name: 'Create new password',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Create new password',
          description:
              'Password creation screen with strength indicator and mismatch error state.',
          code: variant == 'Card style' ? _fpStep3CardCode : _fpStep3Code,
          center: true,
          child: variant == 'Card style'
              ? const _FpStep3CardMockup()
              : const _FpStep3Mockup(),
        );
      },
    ),
  ],
);

class _FpStep3Mockup extends StatefulWidget {
  const _FpStep3Mockup();
  @override
  State<_FpStep3Mockup> createState() => _FpStep3MockupState();
}

class _FpStep3MockupState extends State<_FpStep3Mockup> {
  String _password = '';
  String _confirm = '';

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
                    'Create new password',
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
                    'Choose a strong password to secure your account',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gInputField(
                    value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password',
                    placeholder: '...........',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 12),
                  _passwordStrength(),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: _confirm,
                    onValueChange: (v) => setState(() => _confirm = v),
                    label: 'Confirm password',
                    placeholder: '...........',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _titleColor,
                    ),
                    type: Ux4gInputFieldType.password,
                    status: Ux4gInputFieldStatus.error,
                    caption: 'Passwords do not match',
                  ),
                  const SizedBox(height: 24),
                  Ux4gButton(
                    text: 'Reset password',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

class _FpStep3CardMockup extends StatefulWidget {
  const _FpStep3CardMockup();
  @override
  State<_FpStep3CardMockup> createState() => _FpStep3CardMockupState();
}

class _FpStep3CardMockupState extends State<_FpStep3CardMockup> {
  String _password = '';
  String _confirm = '';

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
                            const Text(
                              'Create new password',
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
                              'Choose a strong password to secure your account',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gInputField(
                              value: _password,
                              onValueChange: (v) =>
                                  setState(() => _password = v),
                              label: 'Password',
                              placeholder: '...........',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              type: Ux4gInputFieldType.password,
                            ),
                            const SizedBox(height: 10),
                            _passwordStrength(),
                            const SizedBox(height: 14),
                            Ux4gInputField(
                              value: _confirm,
                              onValueChange: (v) =>
                                  setState(() => _confirm = v),
                              label: 'Confirm password',
                              placeholder: '...........',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _titleColor,
                              ),
                              type: Ux4gInputFieldType.password,
                              status: Ux4gInputFieldStatus.error,
                              caption: 'Passwords do not match',
                            ),
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Reset password',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _fpStep3Code = r'''// FP Step 3 � Create new password (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create new password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Your new password must be different from your previous one.',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gInputField(
              value: password, onValueChange: (v) => setState(() => password = v),
              label: 'Password', placeholder: '...........',
              type: Ux4gInputFieldType.password,
            ),
            SizedBox(height: 8),
            Ux4gLinearProgress(
              value: 0.85,
              gradientColors: [Color(0xFF86EFAC), Color(0xFF15803D)],
              trackColor: Color(0xFFE5E7EB),
              shape: Ux4gProgressShape.rounded,
              height: 8,
            ),
            SizedBox(height: 4),
            Text('Password Strength: Strong',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                color: Color(0xFF16A34A))),
            SizedBox(height: 10),
            Row(children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
              SizedBox(width: 6),
              Text('8+ characters',
                style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ]),
            SizedBox(height: 6),
            Row(children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
              SizedBox(width: 6),
              Text('Uppercase letter',
                style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ]),
            SizedBox(height: 6),
            Row(children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
              SizedBox(width: 6),
              Text('Number',
                style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ]),
            SizedBox(height: 6),
            Row(children: [
              Icon(Icons.error, color: Color(0xFFDC2626), size: 16),
              SizedBox(width: 6),
              Text('Special character',
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
            ]),
            SizedBox(height: 16),
            Ux4gInputField(
              value: confirm, onValueChange: (v) => setState(() => confirm = v),
              label: 'Confirm password', placeholder: '...........',
              type: Ux4gInputFieldType.password,
              status: Ux4gInputFieldStatus.error,
              caption: 'Passwords do not match',
              labelStyle: TextStyle(color: Color(0xFF111827)),
            ),
            SizedBox(height: 24),
            Ux4gButton(
              text: 'Reset password', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _fpStep3CardCode =
    r'''// FP Step 3 � Create new password, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create new password',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Your new password must be different from your previous one.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 20),
                    Ux4gInputField(
                      value: password, onValueChange: (v) => setState(() => password = v),
                      label: 'Password', placeholder: '...........',
                      type: Ux4gInputFieldType.password,
                    ),
                    SizedBox(height: 8),
                    Ux4gLinearProgress(
                      value: 0.85,
                      gradientColors: [Color(0xFF86EFAC), Color(0xFF15803D)],
                      trackColor: Color(0xFFE5E7EB),
                      shape: Ux4gProgressShape.rounded,
                      height: 8,
                    ),
                    SizedBox(height: 4),
                    Text('Password Strength: Strong',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                        color: Color(0xFF16A34A))),
                    SizedBox(height: 10),
                    Row(children: [
                      Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                      SizedBox(width: 6),
                      Text('8+ characters',
                        style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
                    ]),
                    SizedBox(height: 6),
                    Row(children: [
                      Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                      SizedBox(width: 6),
                      Text('Uppercase letter',
                        style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
                    ]),
                    SizedBox(height: 6),
                    Row(children: [
                      Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                      SizedBox(width: 6),
                      Text('Number',
                        style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
                    ]),
                    SizedBox(height: 6),
                    Row(children: [
                      Icon(Icons.error, color: Color(0xFFDC2626), size: 16),
                      SizedBox(width: 6),
                      Text('Special character',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    ]),
                    SizedBox(height: 14),
                    Ux4gInputField(
                      value: confirm, onValueChange: (v) => setState(() => confirm = v),
                      label: 'Confirm password', placeholder: '...........',
                      type: Ux4gInputFieldType.password,
                      status: Ux4gInputFieldStatus.error,
                      caption: 'Passwords do not match',
                      labelStyle: TextStyle(color: Color(0xFF111827)),
                    ),
                    SizedBox(height: 20),
                    Ux4gButton(
                      text: 'Reset password', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 4 � Password reset successfully
// -----------------------------------------------------------------------

final fpStep4Component = WidgetbookComponent(
  name: 'Password reset successfully',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Password reset successfully',
          description:
              'Success confirmation after the new password has been saved.',
          code: variant == 'Card style' ? _fpStep4CardCode : _fpStep4Code,
          center: true,
          child: variant == 'Card style'
              ? const _FpStep4CardMockup()
              : const _FpStep4Mockup(),
        );
      },
    ),
  ],
);

class _FpStep4Mockup extends StatelessWidget {
  const _FpStep4Mockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Ux4gPalette.green100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Ux4gPalette.green,
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
                    'Password reset\nsuccessfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF16A34A),
                      height: 1.25,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sign in with your new password to continue access to government services.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Ux4gButton(
                    text: 'Sign in',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

class _FpStep4CardMockup extends StatelessWidget {
  const _FpStep4CardMockup();

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
                        padding: const EdgeInsets.fromLTRB(20, 36, 20, 28),
                        decoration: _suCardDeco(),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Ux4gPalette.green,
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
                              'Password reset\nsuccessfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF16A34A),
                                height: 1.25,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Sign in with your new password to continue access to government services.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Ux4gButton(
                              text: 'Sign in',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
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

const _fpStep4Code = r'''// FP Step 4 � Password reset successfully (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 48, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: Ux4gPalette.green100, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Ux4gPalette.green, shape: BoxShape.circle),
                child: Icon(Icons.check, color: Colors.white, size: 22),
              ),
            ),
            SizedBox(height: 24),
            Text('Password reset\nsuccessfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800,
                color: Color(0xFF16A34A), height: 1.25)),
            SizedBox(height: 12),
            Text(
              'Sign in with your new password to continue\naccess to government services.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 32),
            Ux4gButton(
              text: 'Sign in', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _fpStep4CardCode =
    r'''// FP Step 4 � Password reset successfully, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 36, 20, 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        color: Ux4gPalette.green100, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.green, shape: BoxShape.circle),
                        child: Icon(Icons.check, color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Password reset\nsuccessfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF16A34A), height: 1.25)),
                    SizedBox(height: 10),
                    Text(
                      'Sign in with your new password to continue\naccess to government services.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 28),
                    Ux4gButton(
                      text: 'Sign in', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// -----------------------------------------------------------------------
// STEP 5 � Account recovery
// -----------------------------------------------------------------------

final fpStep5Component = WidgetbookComponent(
  name: 'Account recovery',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Account recovery',
          description:
              'Aadhaar-based account recovery screen. Shows masked Aadhaar number '
              'and consent text before sending OTP.',
          code: variant == 'Card style' ? _fpStep5CardCode : _fpStep5Code,
          center: true,
          child: variant == 'Card style'
              ? const _FpStep5CardMockup()
              : const _FpStep5Mockup(),
        );
      },
    ),
  ],
);

class _FpStep5Mockup extends StatefulWidget {
  const _FpStep5Mockup();
  @override
  State<_FpStep5Mockup> createState() => _FpStep5MockupState();
}

class _FpStep5MockupState extends State<_FpStep5Mockup> {
  String _aadhaar = '';

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account recovery',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gAadhaarInputField(
                    value: _aadhaar,
                    onValueChange: (v) => setState(() => _aadhaar = v),
                    label: 'Aadhaar Number',
                    placeholder: 'XXXX XXXX XXXX',
                    placeholderStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Ux4gPalette.neutral500
                          : Ux4gPalette.neutral400,
                      height: 1.3,
                    ),
                    caption: 'Enter your 12-digit Aadhaar number',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'I agree to verify my identity via Aadhaar OTP for the purpose of password recovery.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _subtleText,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    height: 48,
                    width: 326,
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

class _FpStep5CardMockup extends StatefulWidget {
  const _FpStep5CardMockup();
  @override
  State<_FpStep5CardMockup> createState() => _FpStep5CardMockupState();
}

class _FpStep5CardMockupState extends State<_FpStep5CardMockup> {
  String _aadhaar = '';

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
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                            decoration: _suCardDeco(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Account recovery',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: _titleColor,
                                    height: 1.2,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Ux4gAadhaarInputField(
                                  value: _aadhaar,
                                  onValueChange: (v) =>
                                      setState(() => _aadhaar = v),
                                  label: 'Aadhaar Number',
                                  placeholder: 'XXXX XXXX XXXX',
                                  placeholderStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Ux4gPalette.neutral500
                                        : Ux4gPalette.neutral400,
                                    height: 1.3,
                                  ),
                                  caption: 'Enter your 12-digit Aadhaar number',
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'I agree to verify my identity via Aadhaar OTP for the purpose of password recovery.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _subtleText,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Ux4gButton(
                                  text: 'Send OTP',
                                  onPressed: () {},
                                  size: Ux4gButtonSize.large,
                                  height: 48,
                                  width: 326,
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
            ),
          ),
        ],
      ),
    );
  }
}

const _fpStep5Code = r'''// FP Step 5 � Account recovery (360 � 760)
Container(
  width: 360, height: 760, color: Color(0xFFFAFAFA),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account recovery',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                color: Color(0xFF111827))),
            SizedBox(height: 6),
            Text('Verify your identity using Aadhaar',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            SizedBox(height: 24),
            Ux4gAadhaarInputField(
              value: aadhaar,
              onValueChange: (v) => setState(() => aadhaar = v),
              label: 'Aadhaar Number',
              placeholder: 'XXXX XXXX XXXX',
              caption: 'Enter your 12-digit Aadhaar number',
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'I agree to verify my identity via Aadhaar OTP '
                'for the purpose of password recovery.',
                style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ),
            SizedBox(height: 24),
            Ux4gButton(
              text: 'Send OTP', onPressed: () {},
              size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Powered by - ',
          style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
      ]),
    ),
  ]),
)''';

const _fpStep5CardCode =
    r'''// FP Step 5 � Account recovery, card style (360 � 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16, leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16, offset: Offset(0, 4),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account recovery',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                        color: Color(0xFF111827))),
                    SizedBox(height: 6),
                    Text('Verify your identity using Aadhaar',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                    SizedBox(height: 18),
                    Ux4gAadhaarInputField(
                      value: aadhaar,
                      onValueChange: (v) => setState(() => aadhaar = v),
                      label: 'Aadhaar Number',
                      placeholder: 'XXXX XXXX XXXX',
                      caption: 'Enter your 12-digit Aadhaar number',
                    ),
                    SizedBox(height: 14),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'I agree to verify my identity via Aadhaar OTP '
                        'for the purpose of password recovery.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF374151))),
                    ),
                    SizedBox(height: 20),
                    Ux4gButton(
                      text: 'Send OTP', onPressed: () {},
                      size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Powered by - ',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SvgPicture.asset('assets/Digital_India_logo.svg', height: 24),
            ]),
          ),
        ]),
      ),
    ),
  ]),
)''';

// =============================================================================
// NOTIFICATION PATTERN
// =============================================================================

enum _NotifType { actionRequired, statusUpdate, reminder, info }

extension _NotifTypeExt on _NotifType {
  String get label {
    switch (this) {
      case _NotifType.actionRequired:
        return 'Action required';
      case _NotifType.statusUpdate:
        return 'Status Update';
      case _NotifType.reminder:
        return 'Reminder';
      case _NotifType.info:
        return 'Info';
    }
  }

  Color get dotColor {
    switch (this) {
      case _NotifType.actionRequired:
        return const Color(0xFFEF4444);
      case _NotifType.statusUpdate:
        return const Color(0xFF3B82F6);
      case _NotifType.reminder:
        return const Color(0xFFF59E0B);
      case _NotifType.info:
        return const Color(0xFF14B8A6);
    }
  }
}

class _NotifData {
  final _NotifType type;
  final String title;
  final String body;
  final String time;
  final String? actionLabel;
  bool isRead;
  _NotifData({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    this.actionLabel,
    this.isRead = false,
  });
}

class _NotifSection {
  final String label;
  final List<_NotifData> items;
  _NotifSection({required this.label, required this.items});
}

List<_NotifSection> _buildDefaultNotifSections() => [
  _NotifSection(
    label: 'TODAY',
    items: [
      _NotifData(
        type: _NotifType.actionRequired,
        title: 'Income Certificate . Action required',
        body: 'Upload your income proof by 15 Apr to avoid rejection.',
        time: '10:24 AM',
        actionLabel: 'Upload now',
        isRead: false,
      ),
      _NotifData(
        type: _NotifType.actionRequired,
        title: 'Income Certificate . Action required',
        body: 'Upload your income proof by 15 Apr to avoid rejection.',
        time: '8:03 AM',
        actionLabel: 'Upload now',
        isRead: false,
      ),
    ],
  ),
  _NotifSection(
    label: 'YESTERDAY',
    items: [
      _NotifData(
        type: _NotifType.reminder,
        title: 'Draft expiring . Income Certificate',
        body: 'Your draft expires in 5 days.',
        time: '8:03 AM',
        isRead: true,
      ),
      _NotifData(
        type: _NotifType.info,
        title: 'PAN Correction . Status update',
        body: 'Under review by Income Tax Dept.',
        time: '8:03 AM',
        isRead: true,
      ),
    ],
  ),
  _NotifSection(
    label: 'EARLIER THIS WEEK',
    items: [
      _NotifData(
        type: _NotifType.info,
        title: 'Birth Certificate . Submitted',
        body: 'Reference: BC-2026-MH-001.',
        time: '8:03 AM',
        isRead: true,
      ),
    ],
  ),
];

List<_NotifSection> _buildNotifTypesSections() => [
  _NotifSection(
    label: 'NOTIFICATION TYPES',
    items: [
      _NotifData(
        type: _NotifType.actionRequired,
        title: 'Income Certificate . Action required',
        body: 'Upload your income proof by 15 Apr to avoid rejection.',
        time: '8:03 AM',
        actionLabel: 'Upload now',
        isRead: false,
      ),
      _NotifData(
        type: _NotifType.statusUpdate,
        title: 'Income Certificate . Action required',
        body: 'Upload your income proof by 15 Apr to avoid rejection.',
        time: '8:03 AM',
        isRead: false,
      ),
      _NotifData(
        type: _NotifType.reminder,
        title: 'Draft expiring . Income Certificate',
        body: 'Your draft expires in 5 days.',
        time: '8:03 AM',
        isRead: true,
      ),
      _NotifData(
        type: _NotifType.info,
        title: 'Birth Certificate . Submitted',
        body: 'Reference: BC-2026-MH-001.',
        time: '8:03 AM',
        isRead: true,
      ),
    ],
  ),
];

// -- Reminder alerts ---------------------------------------------------------

class _ReminderAlert {
  final String title;
  final String body;
  final Ux4gBannerVariant variant;
  final IconData icon;
  final Color iconColor;
  final String? actionLabel;
  bool dismissed = false;
  _ReminderAlert({
    required this.title,
    required this.body,
    required this.variant,
    required this.icon,
    required this.iconColor,
    this.actionLabel,
  });
}

List<_ReminderAlert> _buildReminderAlerts() => [
  _ReminderAlert(
    title: '30 days before expiry',
    body:
        'Your Income Certificate expires on 15 May 2026 (30 days away). '
        'Renew early to avoid a service gap: bit.ly/renew-mh.',
    variant: Ux4gBannerVariant.infoLight,
    icon: Icons.info_outline_rounded,
    iconColor: const Color(0xFF14B8A6),
  ),
  _ReminderAlert(
    title: '5 days before expiry',
    body:
        'Your Income Certificate draft expires in 5 days (16 Apr). '
        'Resume now: bit.ly/resume-mh.',
    variant: Ux4gBannerVariant.warningLight,
    icon: Icons.warning_amber_rounded,
    iconColor: const Color(0xFFF59E0B),
  ),
  _ReminderAlert(
    title: '2 days before expiry',
    body:
        'Only 2 days left. Submit your Income Certificate before 16 Apr '
        'or your draft will be deleted. Resume: bit.ly/resume-mh.',
    variant: Ux4gBannerVariant.errorLight,
    icon: Icons.error_outline_rounded,
    iconColor: const Color(0xFFEF4444),
  ),
  _ReminderAlert(
    title: 'On expiry day',
    body:
        'Your Income Certificate draft expired on 16 Apr. Your saved data '
        'has been removed. Start a new application: bit.ly/apply-mh.',
    variant: Ux4gBannerVariant.errorLight,
    icon: Icons.error_outline_rounded,
    iconColor: const Color(0xFFEF4444),
    actionLabel: 'Action',
  ),
  _ReminderAlert(
    title: '1 hour before: Sent 10:13 AM',
    body:
        'In 1 hour: Your 11:00 AM field inspection. Revenue Inspector, '
        'Sector 12 office. Directions: bit.ly/dir-mh.',
    variant: Ux4gBannerVariant.successLight,
    icon: Icons.check_circle_outline_rounded,
    iconColor: const Color(0xFF22C55E),
  ),
];

class _NotifRemindersMockup extends StatefulWidget {
  const _NotifRemindersMockup();
  @override
  State<_NotifRemindersMockup> createState() => _NotifRemindersMockupState();
}

class _NotifRemindersMockupState extends State<_NotifRemindersMockup> {
  late List<_ReminderAlert> _alerts;

  @override
  void initState() {
    super.initState();
    _alerts = _buildReminderAlerts();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _alerts.where((a) => !a.dismissed).toList();
    return _PhoneFrame(
      child: Column(
        children: [
          const _NotifPanelHeader(),
          Expanded(
            child: visible.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3F4F6),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.notifications_none_outlined,
                              size: 32,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No reminders',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'All reminders have been dismissed.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      const _NotifSectionLabel(label: 'REMINDERS'),
                      ...visible.map(
                        (alert) => Ux4gStatusBanner(
                          variant: alert.variant,
                          title: alert.title,
                          subtitle: alert.body,
                          leadingIcon: Icon(
                            alert.icon,
                            color: alert.iconColor,
                            size: 20,
                          ),
                          trailingIcon: IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Color(0xFF6B7280),
                            ),
                            onPressed: () =>
                                setState(() => alert.dismissed = true),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          actions: alert.actionLabel != null
                              ? [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      alert.actionLabel!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF2563EB),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ]
                              : null,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _NotifPanelHeader extends StatelessWidget {
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onClose;
  const _NotifPanelHeader({this.onMarkAsRead, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 14, 4, 14),
          child: Row(
            children: [
              const Text(
                'Notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onMarkAsRead,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Mark as read',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: Color(0xFF6B7280),
                ),
                onPressed: onClose ?? () {},
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: _border),
      ],
    );
  }
}

class _NotifSectionLabel extends StatelessWidget {
  final String label;
  const _NotifSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9CA3AF),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final _NotifData item;
  const _NotifTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final bg = item.isRead ? Colors.white : const Color(0xFFF3F4F6);
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: item.type.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.type.label,
                      style: TextStyle(
                        fontSize: 11,
                        color: item.type.dotColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.45,
                  ),
                ),
                if (item.actionLabel != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    item.actionLabel!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifListMockup extends StatefulWidget {
  final bool showTypes;
  const _NotifListMockup({this.showTypes = false});
  @override
  State<_NotifListMockup> createState() => _NotifListMockupState();
}

class _NotifListMockupState extends State<_NotifListMockup> {
  late List<_NotifSection> _sections;

  @override
  void initState() {
    super.initState();
    _sections = widget.showTypes
        ? _buildNotifTypesSections()
        : _buildDefaultNotifSections();
  }

  @override
  void didUpdateWidget(covariant _NotifListMockup old) {
    super.didUpdateWidget(old);
    if (old.showTypes != widget.showTypes) {
      setState(() {
        _sections = widget.showTypes
            ? _buildNotifTypesSections()
            : _buildDefaultNotifSections();
      });
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (final s in _sections) {
        for (final item in s.items) {
          item.isRead = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rows = <dynamic>[];
    for (final section in _sections) {
      rows.add(section.label);
      rows.addAll(section.items);
    }
    return _PhoneFrame(
      child: Column(
        children: [
          _NotifPanelHeader(onMarkAsRead: _markAllAsRead),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: rows.length,
              itemBuilder: (context, index) {
                final row = rows[index];
                if (row is String) return _NotifSectionLabel(label: row);
                final item = row as _NotifData;
                final nextIsItem =
                    index + 1 < rows.length && rows[index + 1] is _NotifData;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NotifTile(item: item),
                    if (nextIsItem)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE5E7EB),
                        indent: 34,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifEmptyMockup extends StatelessWidget {
  const _NotifEmptyMockup();

  // Icon container background varies by empty-state condition:
  //   � allCaughtUp  (default) ? neutral gray  0xFFF3F4F6
  //   � neverHadAny            ? soft blue tint 0xFFEFF6FF
  static const Color _iconBgAllCaughtUp = Color(0xFFF3F4F6);
  static const Color _iconColorAllCaughtUp = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _NotifPanelHeader(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // -- Bell icon with conditional circular background ----
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color:
                            _iconBgAllCaughtUp, // change to _iconBgNever for "never had" state
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        size: 32,
                        color: _iconColorAllCaughtUp,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'You are all caught up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No new notifications. We will let you know when\nsomething needs your attention.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final notificationComponent = WidgetbookComponent(
  name: 'Notification',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const [
            'With Notifications',
            'Notification Types',
            'Empty State',
          ],
          initialOption: 'With Notifications',
          description:
              'Switch between a populated list, type showcase, and empty state.\n\n'
              'Unread ? gray bg (0xFFF3F4F6) | Read ? white bg. '
              'Tap "Mark as read" to clear.',
        );
        final Widget child = switch (variant) {
          'Notification Types' => const _NotifListMockup(showTypes: true),
          'Empty State' => const _NotifEmptyMockup(),
          _ => const _NotifListMockup(),
        };
        final String code = switch (variant) {
          'Notification Types' => _notifTypesCode,
          'Empty State' => _notifEmptyCode,
          _ => _notifDefaultCode,
        };
        return ComponentDocs(
          name: 'Notification',
          description:
              'Notification panel pattern. Unread items have a gray background '
              '(Color(0xFFF3F4F6)); read items are white. '
              '"Mark as read" clears all unread states. '
              'Empty state: bell icon shown in a 64x64 rounded container '
              '(0xFFF3F4F6 for all-caught-up; 0xFFEFF6FF for never-had-any).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

const _notifDefaultCode =
    r'''// Notification panel . With Notifications (360 . 760)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 14, 4, 14),
      child: Row(children: [
        Text('Notification',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
        Spacer(),
        TextButton(onPressed: _markAllAsRead,
          child: Text('Mark as read',
            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w500))),
        IconButton(icon: Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
          onPressed: () {}, padding: EdgeInsets.all(8)),
      ]),
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: ListView(padding: EdgeInsets.zero, children: [
        // Section label
        Container(color: Colors.white, padding: EdgeInsets.fromLTRB(16, 14, 16, 6),
          child: Text('TODAY',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
              color: Color(0xFF9CA3AF), letterSpacing: 0.6))),

        // Unread tile ? gray bg
        Container(
          color: Color(0xFFF3F4F6),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(margin: EdgeInsets.only(top: 5), width: 8, height: 8,
              decoration: BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
            SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Action required',
                  style: TextStyle(fontSize: 11, color: Color(0xFFEF4444), fontWeight: FontWeight.w600)),
                Text('10:24 AM', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              ]),
              SizedBox(height: 4),
              Text('Income Certificate . Action required',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
              SizedBox(height: 3),
              Text('Upload your income proof by 15 Apr to avoid rejection.',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              SizedBox(height: 6),
              Text('Upload now',
                style: TextStyle(fontSize: 12, color: Color(0xFF2563EB), fontWeight: FontWeight.w600)),
            ])),
          ]),
        ),
        Divider(height: 1, color: Color(0xFFE5E7EB), indent: 34),

        // Read tile ? white bg
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(margin: EdgeInsets.only(top: 5), width: 8, height: 8,
              decoration: BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
            SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Reminder',
                  style: TextStyle(fontSize: 11, color: Color(0xFFF59E0B), fontWeight: FontWeight.w600)),
                Text('8:03 AM', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              ]),
              SizedBox(height: 4),
              Text('Draft expiring . Income Certificate',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
              SizedBox(height: 3),
              Text('Your draft expires in 5 days.',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
            ])),
          ]),
        ),
      ]),
    ),
  ]),
)''';

const _notifTypesCode =
    r'''// Notification panel . Notification Types (360 . 760)
// Dot + label color match the type. Unread = 0xFFF3F4F6 bg | Read = white bg.
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    // Same header as default . omitted for brevity
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Container(color: Colors.white, padding: EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Text('NOTIFICATION TYPES',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Color(0xFF9CA3AF), letterSpacing: 0.6))),
    Expanded(
      child: ListView(padding: EdgeInsets.zero, children: [
        _buildTile(bg: Color(0xFFF3F4F6), dot: Color(0xFFEF4444), label: 'Action required',
          time: '8:03 AM', title: 'Income Certificate . Action required',
          body: 'Upload your income proof by 15 Apr.', action: 'Upload now'),
        Divider(height: 1, color: Color(0xFFE5E7EB), indent: 34),

        _buildTile(bg: Color(0xFFF3F4F6), dot: Color(0xFF3B82F6), label: 'Status Update',
          time: '8:03 AM', title: 'Income Certificate . Action required',
          body: 'Upload your income proof by 15 Apr.'),
        Divider(height: 1, color: Color(0xFFE5E7EB), indent: 34),

        _buildTile(bg: Colors.white, dot: Color(0xFFF59E0B), label: 'Reminder',
          time: '8:03 AM', title: 'Draft expiring . Income Certificate',
          body: 'Your draft expires in 5 days.'),
        Divider(height: 1, color: Color(0xFFE5E7EB), indent: 34),

        _buildTile(bg: Colors.white, dot: Color(0xFF14B8A6), label: 'Info',
          time: '8:03 AM', title: 'Birth Certificate . Submitted',
          body: 'Reference: BC-2026-MH-001.'),
      ]),
    ),
  ]),
)''';

const _notifEmptyCode = r'''// Notification panel . Empty State (360 . 760)
// Icon container background varies by condition:
//   allCaughtUp  ? 0xFFF3F4F6 (neutral gray)
//   neverHadAny  ? 0xFFEFF6FF (soft blue tint)
Container(
  width: 360, height: 760, color: Colors.white,
  child: Column(children: [
    Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 14, 4, 14),
      child: Row(children: [
        Text('Notification',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
        Spacer(),
        TextButton(onPressed: () {},
          child: Text('Mark as read',
            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)))),
        IconButton(icon: Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
          onPressed: () {}, padding: EdgeInsets.all(8)),
      ]),
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bell icon with conditional circular background
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  // allCaughtUp state ? Color(0xFFF3F4F6)
                  // neverHadAny state ? Color(0xFFEFF6FF)
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.notifications_none_outlined,
                  size: 32, color: Color(0xFF9CA3AF)),
              ),
              SizedBox(height: 16),
              Text('You are all caught up',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                  color: Color(0xFF111827), height: 1.3),
                textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text(
                'No new notifications. We will let you know when\nsomething needs your attention.',
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
                textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    ),
  ]),
)''';

// -- Single-alert reminder mockup ---------------------------------------------

// -- Single-alert reminder mockup ---------------------------------------------

class _ReminderAlertMockup extends StatefulWidget {
  final _ReminderAlert alert;
  const _ReminderAlertMockup({required this.alert, super.key});
  @override
  State<_ReminderAlertMockup> createState() => _ReminderAlertMockupState();
}

class _ReminderAlertMockupState extends State<_ReminderAlertMockup> {
  bool _dismissed = false;

  @override
  void didUpdateWidget(covariant _ReminderAlertMockup old) {
    super.didUpdateWidget(old);
    if (old.alert.title != widget.alert.title) {
      setState(() => _dismissed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: _dismissed
          ? const SizedBox.shrink()
          : Stack(
              children: [
                // alert card pinned to the bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                widget.alert.icon,
                                color: widget.alert.iconColor,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.alert.title,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      widget.alert.body,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Color(0xFF9CA3AF),
                                ),
                                onPressed: () =>
                                    setState(() => _dismissed = true),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          if (widget.alert.actionLabel != null) ...[
                            const SizedBox(height: 6),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                widget.alert.actionLabel!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// -- Per-type code snippets ----------------------------------------------------

const _reminder30DaysCode =
    r'''// Reminder Alert . 30 days before expiry (infoLight)
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.infoLight,
  title: '30 days before expiry',
  subtitle: 'Your Income Certificate expires on 15 May 2026 (30 days away). '
            'Renew early to avoid a service gap: bit.ly/renew-mh.',
  leadingIcon: Icon(Icons.info_outline_rounded,
    color: Color(0xFF14B8A6), size: 20),
  trailingIcon: IconButton(
    icon: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
    onPressed: _dismiss, padding: EdgeInsets.zero,
    constraints: BoxConstraints()),
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
)''';

const _reminder5DaysCode =
    r'''// Reminder Alert . 5 days before expiry (warningLight)
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.warningLight,
  title: '5 days before expiry',
  subtitle: 'Your Income Certificate draft expires in 5 days (16 Apr). '
            'Resume now: bit.ly/resume-mh.',
  leadingIcon: Icon(Icons.warning_amber_rounded,
    color: Color(0xFFF59E0B), size: 20),
  trailingIcon: IconButton(
    icon: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
    onPressed: _dismiss, padding: EdgeInsets.zero,
    constraints: BoxConstraints()),
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
)''';

const _reminder2DaysCode =
    r'''// Reminder Alert . 2 days before expiry (errorLight)
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.errorLight,
  title: '2 days before expiry',
  subtitle: 'Only 2 days left. Submit your Income Certificate before 16 Apr '
            'or your draft will be deleted. Resume: bit.ly/resume-mh.',
  leadingIcon: Icon(Icons.error_outline_rounded,
    color: Color(0xFFEF4444), size: 20),
  trailingIcon: IconButton(
    icon: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
    onPressed: _dismiss, padding: EdgeInsets.zero,
    constraints: BoxConstraints()),
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
)''';

const _reminderExpiryDayCode =
    r'''// Reminder Alert . On expiry day (errorLight + Action button)
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.errorLight,
  title: 'On expiry day',
  subtitle: 'Your Income Certificate draft expired on 16 Apr. Your saved data '
            'has been removed. Start a new application: bit.ly/apply-mh.',
  leadingIcon: Icon(Icons.error_outline_rounded,
    color: Color(0xFFEF4444), size: 20),
  trailingIcon: IconButton(
    icon: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
    onPressed: _dismiss, padding: EdgeInsets.zero,
    constraints: BoxConstraints()),
  actions: [
    TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: Text('Action',
        style: TextStyle(fontSize: 12, color: Color(0xFF2563EB),
          fontWeight: FontWeight.w600)),
    ),
  ],
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
)''';

const _reminder1HourCode = r'''// Reminder Alert . 1 hour before (successLight)
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.successLight,
  title: '1 hour before: Sent 10:13 AM',
  subtitle: 'In 1 hour: Your 11:00 AM field inspection. Revenue Inspector, '
            'Sector 12 office. Directions: bit.ly/dir-mh.',
  leadingIcon: Icon(Icons.check_circle_outline_rounded,
    color: Color(0xFF22C55E), size: 20),
  trailingIcon: IconButton(
    icon: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
    onPressed: _dismiss, padding: EdgeInsets.zero,
    constraints: BoxConstraints()),
  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
)''';

const Map<String, String> _reminderCodeMap = {
  '30 days before expiry': _reminder30DaysCode,
  '5 days before expiry': _reminder5DaysCode,
  '2 days before expiry': _reminder2DaysCode,
  'On expiry day': _reminderExpiryDayCode,
  '1 hour before': _reminder1HourCode,
};

final reminderAlertsComponent = WidgetbookComponent(
  name: 'Reminder Alerts',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final scenario = context.knobs.list(
          label: 'Alert Type',
          options: const [
            '30 days before expiry',
            '5 days before expiry',
            '2 days before expiry',
            'On expiry day',
            '1 hour before',
          ],
          initialOption: '30 days before expiry',
          description:
              'Each type maps to a Ux4gStatusBanner variant:\n'
              'infoLight (30 days) . warningLight (5 days) . '
              'errorLight (2 days / expiry day) . successLight (1 hour)',
        );
        final alert = _buildReminderAlerts().firstWhere(
          (a) => scenario == '1 hour before'
              ? a.title.startsWith('1 hour before')
              : a.title == scenario,
        );
        return ComponentDocs(
          name: 'Reminder Alert',
          description:
              'Deadline-aware reminder alerts using Ux4gStatusBanner. '
              'Variant changes by urgency: infoLight . warningLight . '
              'errorLight . successLight. Tap X to dismiss.',
          code: _reminderCodeMap[scenario] ?? _reminder30DaysCode,
          center: true,
          child: _ReminderAlertMockup(key: ValueKey(scenario), alert: alert),
        );
      },
    ),
  ],
);

// ------------------------------------------------------------------------------
// Notification Preferences
// ------------------------------------------------------------------------------

const _prefBg = Color(0xFFFAFAFA);
const _prefBorder = Color(0xFFE5E7EB);
const _prefPurple = Color(0xFF6B21A8);
const _prefTitle = Color(0xFF111827);
const _prefSub = Color(0xFF6B7280);
const _prefMuted = Color(0xFF9CA3AF);

// ── Chip model ────────────────────────────────────────────────────────────────

class _PrefChipData {
  final String label;
  final int count;
  const _PrefChipData(this.label, this.count);
}

const _defaultPrefChips = [
  _PrefChipData('All', 62),
  _PrefChipData('Pending', 3),
  _PrefChipData('Under Review', 12),
  _PrefChipData('Approved', 18),
  _PrefChipData('Rejected', 5),
];

// ── Chip bar (stateful, dynamic) ──────────────────────────────────────────────

class _PrefChipBar extends StatefulWidget {
  final List<_PrefChipData> chips;
  final int initialIndex;
  const _PrefChipBar({required this.chips, this.initialIndex = 0});
  @override
  State<_PrefChipBar> createState() => _PrefChipBarState();
}

class _PrefChipBarState extends State<_PrefChipBar> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        itemCount: widget.chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final chip = widget.chips[i];
          final sel = _selected == i;
          return Ux4gChoiceChip(
            text: chip.label,
            selected: sel,
            onClick: () => setState(() => _selected = i),
            size: Ux4gChoiceChipSize.s,
            borderRadius: 4,
            unselectedBackgroundColor: Colors.white,
            unselectedBorderColor: const Color(0xFFD1D5DB),
            unselectedTextColor: const Color(0xFF374151),
            trailingContent: sel
                ? Text(
                    '${chip.count}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${chip.count}',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

// ── Shared page header: brand logos + title + chip bar ────────────────────────

class _PrefPageHeader extends StatelessWidget {
  final List<_PrefChipData> chips;
  const _PrefPageHeader({this.chips = _defaultPrefChips});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _BrandHeader(),
      Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        alignment: Alignment.centerLeft,
        child: const Text(
          'Notification Preferences',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _prefTitle,
          ),
        ),
      ),
      _PrefChipBar(chips: chips),
    ],
  );
}

// ── Placeholder content container ─────────────────────────────────────────────

class _PrefPlaceholderContent extends StatelessWidget {
  const _PrefPlaceholderContent();
  @override
  Widget build(BuildContext context) => Expanded(
    child: Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Content area',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

// ── Shared small widgets ──────────────────────────────────────────────────────

class _PrefToggleRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String? sub;
  final bool value;
  final ValueChanged<bool>? onChanged;
  const _PrefToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.sub,
    required this.value,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _prefTitle,
                ),
              ),
              if (sub != null)
                Text(
                  sub!,
                  style: const TextStyle(fontSize: 10, color: _prefSub),
                ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: _prefPurple,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    ),
  );
}

// -- Screen 1 � Channel Preferences -------------------------------------------

class _PrefChannelScreen extends StatefulWidget {
  const _PrefChannelScreen();
  @override
  State<_PrefChannelScreen> createState() => _PrefChannelScreenState();
}

class _PrefChannelScreenState extends State<_PrefChannelScreen> {
  bool _push = true, _email = true, _app = true, _whatsapp = false;
  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _prefBorder),
                  ),
                  child: Column(
                    children: [
                      _PrefToggleRow(
                        icon: Icons.notifications_outlined,
                        iconColor: _prefPurple,
                        label: '+91 9696-XXXXX',
                        sub: 'Push alerts on this device',
                        value: _push,
                        onChanged: (v) => setState(() => _push = v),
                      ),
                      Divider(height: 1, color: _prefBorder),
                      _PrefToggleRow(
                        icon: Icons.email_outlined,
                        iconColor: const Color(0xFF2563EB),
                        label: 'Email',
                        sub: 'user@digimail.gov',
                        value: _email,
                        onChanged: (v) => setState(() => _email = v),
                      ),
                      Divider(height: 1, color: _prefBorder),
                      _PrefToggleRow(
                        icon: Icons.apps,
                        iconColor: const Color(0xFF0891B2),
                        label: 'App notifications',
                        sub: 'Push alerts on this device',
                        value: _app,
                        onChanged: (v) => setState(() => _app = v),
                      ),
                      Divider(height: 1, color: _prefBorder),
                      _PrefToggleRow(
                        icon: Icons.chat_bubble_outline,
                        iconColor: const Color(0xFF16A34A),
                        label: 'WhatsApp',
                        sub: 'Opted out',
                        value: _whatsapp,
                        onChanged: (v) => setState(() => _whatsapp = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// -- Screen 2 � Frequency -----------------------------------------------------

class _PrefFrequencyScreen extends StatefulWidget {
  const _PrefFrequencyScreen();
  @override
  State<_PrefFrequencyScreen> createState() => _PrefFrequencyScreenState();
}

class _PrefFrequencyScreenState extends State<_PrefFrequencyScreen> {
  String _selected = 'Immediately';
  static const _options = [
    _FreqOption(
      'Immediately',
      'Get each notification the moment it�',
      Icons.flash_on_outlined,
    ),
    _FreqOption(
      'Daily Summary',
      'One digest every day at 6:00 PM.',
      Icons.today_outlined,
    ),
    _FreqOption(
      'Weekly Digest',
      'A round-up every Monday morning.',
      Icons.calendar_month_outlined,
    ),
  ];
  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _prefBorder),
                  ),
                  child: Column(
                    children: _options.asMap().entries.map((e) {
                      final opt = e.value;
                      final isLast = e.key == _options.length - 1;
                      final selected = _selected == opt.label;
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => setState(() => _selected = opt.label),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    opt.icon,
                                    color: selected ? _prefPurple : _prefMuted,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          opt.label,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: selected
                                                ? _prefPurple
                                                : _prefTitle,
                                          ),
                                        ),
                                        Text(
                                          opt.sub,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: _prefSub,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (selected)
                                    const Icon(
                                      Icons.check_circle,
                                      color: _prefPurple,
                                      size: 18,
                                    )
                                  else
                                    const Icon(
                                      Icons.radio_button_unchecked,
                                      color: _prefMuted,
                                      size: 18,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (!isLast) Divider(height: 1, color: _prefBorder),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _FreqOption {
  final String label, sub;
  final IconData icon;
  const _FreqOption(this.label, this.sub, this.icon);
}

// -- Screen 3 � Categories ----------------------------------------------------

class _PrefCategory {
  final String name;
  final String summary;
  final List<_PrefNotifItem> items;
  bool expanded;
  _PrefCategory(this.name, this.summary, this.items, {this.expanded = false});
}

class _PrefNotifItem {
  final String label;
  bool enabled;
  final bool locked;
  _PrefNotifItem(this.label, {this.enabled = true, this.locked = false});
}

List<_PrefCategory> _buildCategories() => [
  _PrefCategory('Income Certificate', '3 of 3 notifications on', [
    _PrefNotifItem('Status updates'),
    _PrefNotifItem('Action reminders'),
    _PrefNotifItem('Legal & payment\ndeadlines'),
  ], expanded: true),
  _PrefCategory('Ration Card Renewal', '1 of 3 notifications on', [
    _PrefNotifItem('Status updates'),
    _PrefNotifItem('Action reminders', enabled: false),
    _PrefNotifItem('Certificate expiry', enabled: false),
  ]),
  _PrefCategory('PAN Correction', '3 of 3 notifications on', [
    _PrefNotifItem('Status updates'),
    _PrefNotifItem('Action reminders'),
    _PrefNotifItem('Certificate expiry'),
  ]),
  _PrefCategory('Birth Certificate', 'All notifications off', [
    _PrefNotifItem('Status updates', enabled: false),
    _PrefNotifItem('Action reminders', enabled: false),
    _PrefNotifItem('Certificate expiry', enabled: false),
  ]),
];

class _PrefCategoryScreen extends StatefulWidget {
  const _PrefCategoryScreen();
  @override
  State<_PrefCategoryScreen> createState() => _PrefCategoryScreenState();
}

class _PrefCategoryScreenState extends State<_PrefCategoryScreen> {
  late List<_PrefCategory> _cats;
  @override
  void initState() {
    super.initState();
    _cats = _buildCategories();
  }

  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            itemCount: _cats.length,
            itemBuilder: (_, i) {
              final cat = _cats[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _prefBorder),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setState(() => cat.expanded = !cat.expanded),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cat.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _prefTitle,
                                    ),
                                  ),
                                  Text(
                                    cat.summary,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: _prefSub,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              cat.expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: _prefMuted,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (cat.expanded) ...[
                      Divider(height: 1, color: _prefBorder),
                      ...cat.items
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: _prefTitle,
                                      ),
                                    ),
                                  ),
                                  if (item.locked)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Locked',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: _prefMuted,
                                        ),
                                      ),
                                    )
                                  else
                                    Switch(
                                      value: item.enabled,
                                      onChanged: (v) =>
                                          setState(() => item.enabled = v),
                                      activeColor: _prefPurple,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 4),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// -- Screen 4 � Locked Notifications ------------------------------------------

List<_PrefCategory> _buildLockedCategories() => [
  _PrefCategory('Income Certificate', '3 of 3 notifications on', [
    _PrefNotifItem('Status updates'),
    _PrefNotifItem('Rejection notices', locked: true),
    _PrefNotifItem('Legal & payment\ndeadlines', locked: true),
  ], expanded: true),
  _PrefCategory('Ration Card Renewal', '1 of 3 notifications on', [
    _PrefNotifItem('Status updates'),
    _PrefNotifItem('Action reminders', enabled: false),
    _PrefNotifItem('Certificate expiry', enabled: false),
  ]),
];

class _PrefLockedScreen extends StatefulWidget {
  const _PrefLockedScreen();
  @override
  State<_PrefLockedScreen> createState() => _PrefLockedScreenState();
}

class _PrefLockedScreenState extends State<_PrefLockedScreen> {
  late List<_PrefCategory> _cats;
  @override
  void initState() {
    super.initState();
    _cats = _buildLockedCategories();
  }

  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Container(
          margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFED7AA)),
          ),
          child: Row(
            children: const [
              Icon(Icons.lock_outline, size: 14, color: Color(0xFFF59E0B)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Some notifications are required and cannot be turned off.',
                  style: TextStyle(fontSize: 10, color: Color(0xFF92400E)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _cats.length,
            itemBuilder: (_, i) {
              final cat = _cats[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _prefBorder),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setState(() => cat.expanded = !cat.expanded),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cat.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _prefTitle,
                                    ),
                                  ),
                                  Text(
                                    cat.summary,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: _prefSub,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              cat.expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: _prefMuted,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (cat.expanded) ...[
                      Divider(height: 1, color: _prefBorder),
                      ...cat.items
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: _prefTitle,
                                      ),
                                    ),
                                  ),
                                  if (item.locked)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Locked',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: _prefMuted,
                                        ),
                                      ),
                                    )
                                  else
                                    Switch(
                                      value: item.enabled,
                                      onChanged: (v) =>
                                          setState(() => item.enabled = v),
                                      activeColor: _prefPurple,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 4),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// -- Screen 5 � WhatsApp Consent -----------------------------------------------

class _PrefWhatsAppScreen extends StatefulWidget {
  const _PrefWhatsAppScreen();
  @override
  State<_PrefWhatsAppScreen> createState() => _PrefWhatsAppScreenState();
}

class _PrefWhatsAppScreenState extends State<_PrefWhatsAppScreen> {
  bool _consented = false;
  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What you will receive on WhatsApp',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _prefTitle,
                  ),
                ),
                const SizedBox(height: 12),
                ...const [
                  'Application status changes',
                  'Appointment reminders (D-1 and H-1)',
                  'Action-required alerts with quick links',
                ].map(
                  (s) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Color(0xFF16A34A), size: 14),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            s,
                            style: TextStyle(fontSize: 11, color: _prefSub),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: _prefBorder),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _consented,
                        onChanged: (v) =>
                            setState(() => _consented = v ?? false),
                        activeColor: _prefPurple,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'I consent to receiving notifications on WhatsApp '
                          'at +91 98765 43210.\nYou can withdraw this consent '
                          'at any time. This checkbox is linked to DPDP Act 2023.',
                          style: TextStyle(fontSize: 10, color: _prefSub),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _consented ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _prefPurple,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: _prefBorder,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Enable WhatsApp Notifications',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// -- Screen 6 � Manage All ----------------------------------------------------

class _PrefManageItem {
  final String label;
  final String? sub;
  final bool alwaysOn;
  bool enabled;
  _PrefManageItem(
    this.label, {
    this.sub,
    this.alwaysOn = false,
    this.enabled = true,
  });
}

class _PrefManageAllScreen extends StatefulWidget {
  const _PrefManageAllScreen();
  @override
  State<_PrefManageAllScreen> createState() => _PrefManageAllScreenState();
}

class _PrefManageAllScreenState extends State<_PrefManageAllScreen> {
  final _optional = [
    _PrefManageItem(
      'Status updates',
      sub: 'Track progress of your applications',
    ),
    _PrefManageItem('Action reminders', sub: 'Upload and payment reminders'),
    _PrefManageItem(
      'Certificates expiry',
      sub: 'Renewal reminders before documents expire',
    ),
    _PrefManageItem(
      'Promotional updates',
      sub: 'New services and announcements',
      enabled: false,
    ),
  ];
  final _mandatory = [
    _PrefManageItem(
      'SLA breach alerts',
      sub: 'Mandatory statutory deadline notifications',
      alwaysOn: true,
    ),
    _PrefManageItem(
      'Rejection notices',
      sub: 'Application rejections with reasons',
      alwaysOn: true,
    ),
  ];

  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: [
        const _PrefPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'OPTIONAL � YOU CAN TURN OFF',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: _prefMuted,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _prefBorder),
                  ),
                  child: Column(
                    children: _optional.asMap().entries.map((e) {
                      final item = e.value;
                      final isLast = e.key == _optional.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.label,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _prefTitle,
                                        ),
                                      ),
                                      if (item.sub != null)
                                        Text(
                                          item.sub!,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: _prefSub,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: item.enabled,
                                  onChanged: (v) =>
                                      setState(() => item.enabled = v),
                                  activeColor: _prefPurple,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ],
                            ),
                          ),
                          if (!isLast) Divider(height: 1, color: _prefBorder),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'MANDATORY � REQUIRED IN SCREENSHOT POLICY',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: _prefMuted,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _prefBorder),
                  ),
                  child: Column(
                    children: _mandatory.asMap().entries.map((e) {
                      final item = e.value;
                      final isLast = e.key == _mandatory.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.label,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _prefTitle,
                                        ),
                                      ),
                                      if (item.sub != null)
                                        Text(
                                          item.sub!,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: _prefSub,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Always on',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: _prefMuted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isLast) Divider(height: 1, color: _prefBorder),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => setState(() {
                      for (final i in _optional) {
                        i.enabled = false;
                      }
                    }),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFDC2626),
                      side: const BorderSide(color: Color(0xFFDC2626)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Turn off all optional notifications',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// -- WidgetbookComponent registration -----------------------------------------

// ── Story mockup ──────────────────────────────────────────────────────────────

class _NotifPrefMockup extends StatelessWidget {
  const _NotifPrefMockup();
  @override
  Widget build(BuildContext context) => _PhoneFrame(
    child: Column(
      children: const [_PrefPageHeader(), _PrefPlaceholderContent()],
    ),
  );
}

const _notifPrefCode = r'''
// 1. Define your chip data
final chips = [
  _PrefChipData('All', 62),
  _PrefChipData('Pending', 3),
  _PrefChipData('Under Review', 12),
  _PrefChipData('Approved', 18),
  _PrefChipData('Rejected', 5),
];

// 2. Use _PrefPageHeader with dynamic chip list
_PrefPageHeader(chips: chips)

// 3. Each Ux4gChoiceChip inside _PrefChipBar uses:
Ux4gChoiceChip(
  text: 'Pending',
  selected: isSelected,
  onClick: () => setState(() => _selected = i),
  size: Ux4gChoiceChipSize.s,
  borderRadius: 4,
  unselectedBackgroundColor: Colors.white,
  unselectedBorderColor: Color(0xFFD1D5DB),
  trailingContent: Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
    decoration: BoxDecoration(
      color: Color(0xFF6B21A8),   // badge only when NOT selected
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text('3', style: TextStyle(fontSize: 9, color: Colors.white)),
  ),
)
''';

final notificationPreferencesComponent = WidgetbookComponent(
  name: 'Notification Preferences',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Notification Preferences',
        description:
            'Filter chip bar with dynamic chip list. Each chip shows a label '
            'and a count badge (purple bg when unselected, plain white text '
            'when selected). Tap any chip to select it. '
            'Replace the content area with your own widget.',
        code: _notifPrefCode,
        center: true,
        child: const _NotifPrefMockup(),
      ),
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════════════
// PAYMENT AND CONFIRMATION PATTERNS
// ═══════════════════════════════════════════════════════════════════════

// -----------------------------------------------------------------------
// Shared helpers
// -----------------------------------------------------------------------

/// Horizontal 5-step progress bar — circles with no labels except the last
/// step which shows "Payment". Lines have small gaps and don't touch circles.
class _PmtStepBar extends StatelessWidget {
  const _PmtStepBar({this.currentStep = 5});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary =
        ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < 5; i++) ...[
            if (i > 0) ...[
              const SizedBox(width: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 2,
                    color: i < currentStep ? primary : const Color(0xFFD1D5DB),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
            _PmtCircle(
              stepIndex: i + 1,
              isCompleted: currentStep > i + 1,
              isActive: currentStep == i + 1,
              primary: primary,
              onPrimary: onPrimary,
              label: i == 4 ? 'Payment' : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _PmtCircle extends StatelessWidget {
  const _PmtCircle({
    required this.stepIndex,
    required this.isCompleted,
    required this.isActive,
    required this.primary,
    required this.onPrimary,
    this.label,
  });
  final int stepIndex;
  final bool isCompleted;
  final bool isActive;
  final Color primary;
  final Color onPrimary;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCompleted ? primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: (isCompleted || isActive) ? primary : const Color(0xFFD1D5DB),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? Icon(Icons.check, size: 18, color: onPrimary)
          : isActive
          ? Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
            )
          : Text(
              '$stepIndex',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD1D5DB),
              ),
            ),
    );
    if (label == null) return circle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle,
        const SizedBox(height: 3),
        Text(
          label!,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
      ],
    );
  }
}

/// One row in the fee-breakdown table.
class _FeeRow extends StatelessWidget {
  const _FeeRow({
    required this.label,
    required this.amount,
    this.bold = false,
    this.redAmount = false,
    this.bgColor,
  });

  final String label;
  final String amount;
  final bool bold;
  final bool redAmount;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                color: bold ? const Color(0xFF111827) : _subtleText,
                height: 1.3,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: redAmount
                  ? Ux4gPalette.red600
                  : (bold ? const Color(0xFF111827) : const Color(0xFF374151)),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// One row in a transaction-detail table (label left, value right).
class _PayDetailRow extends StatelessWidget {
  const _PayDetailRow({
    required this.label,
    required this.value,
    this.valueBold = false,
    this.valueColor,
    this.bgColor,
  });

  final String label;
  final String value;
  final bool valueBold;
  final Color? valueColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: _subtleText,
                height: 1.3,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: valueBold ? FontWeight.w600 : FontWeight.w400,
                color: valueColor ?? const Color(0xFF111827),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Radio-style bordered payment-method tile.
class _PmtOptionTile extends StatelessWidget {
  const _PmtOptionTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.subtitle,
  });

  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? primary.withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? primary : _border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? primary : const Color(0xFFD1D5DB),
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: selected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selected ? primary : const Color(0xFF111827),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _subtleText,
                      height: 1.3,
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

// -----------------------------------------------------------------------
// PAYMENT SUMMARY — flat + card
// -----------------------------------------------------------------------

class _PaymentSummaryMockup extends StatelessWidget {
  const _PaymentSummaryMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Income Certificate — Application #INC-2024-00842',
                            style: TextStyle(
                              fontSize: 13,
                              color: _subtleText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: _border),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              children: [
                                const _FeeRow(
                                  label: 'Application fee',
                                  amount: 'Rs 30.00',
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: _border,
                                ),
                                const _FeeRow(
                                  label: 'Processing charge',
                                  amount: 'Rs 5.00',
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: _border,
                                ),
                                const _FeeRow(
                                  label: 'GST 18%',
                                  amount: 'Rs 6.30',
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: _border,
                                ),
                                const _FeeRow(
                                  label: 'Total',
                                  amount: 'Rs 41.30',
                                  bold: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.infoLight,
                            title:
                                'Secure payment via PayGov. Your payment '
                                'information is protected by 256-bit encryption.',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          ),
                          const SizedBox(height: 20),
                          Ux4gButton(
                            text: 'Continue to payment',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Back to review',
                                style: TextStyle(fontSize: 14, color: primary),
                              ),
                            ),
                          ),
                        ],
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

class _PaymentSummaryCardMockup extends StatelessWidget {
  const _PaymentSummaryCardMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Income Certificate — Application #INC-2024-00842',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: _border),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  const _FeeRow(
                                    label: 'Application fee',
                                    amount: 'Rs 30.00',
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: _border,
                                  ),
                                  const _FeeRow(
                                    label: 'Processing charge',
                                    amount: 'Rs 5.00',
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: _border,
                                  ),
                                  const _FeeRow(
                                    label: 'GST 18%',
                                    amount: 'Rs 6.30',
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: _border,
                                  ),
                                  const _FeeRow(
                                    label: 'Total',
                                    amount: 'Rs 41.30',
                                    bold: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.infoLight,
                              title:
                                  'Secure payment via PayGov. Your payment '
                                  'information is protected by 256-bit encryption.',
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                10,
                                12,
                                10,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Continue to payment',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Back to review',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
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

const _paymentSummaryCode = r'''
Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Column(
    children: [
      // Government header
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      // Step bar (5 steps, current = 5 "Payment")
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5,
          currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'),
            Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'),
            Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Income Certificate — Application #INC-2024-00842',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Fee breakdown table
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            _feeRow('Application fee', 'Rs 30.00'),
                            Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                            _feeRow('Processing charge', 'Rs 5.00'),
                            Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                            _feeRow('GST 18%', 'Rs 6.30'),
                            Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                            _feeRow('Total', 'Rs 41.30', bold: true),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.infoLight,
                        title:
                            'Secure payment via PayGov. Your payment '
                            'information is protected by 256-bit encryption.',
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                      ),
                      SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Continue to payment',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Back to review',
                            style: TextStyle(fontSize: 14, color: primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: fee row
Widget _feeRow(String label, String amount, {bool bold = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                color: bold ? Color(0xFF111827) : Color(0xFF6B7280),
              )),
        ),
        Text(amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: bold ? Color(0xFF111827) : Color(0xFF374151),
            )),
      ],
    ),
  );
}''';

const _paymentSummaryCardCode = r'''
Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Column(
    children: [
      // Government header
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      // Step bar
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5,
          currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'),
            Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'),
            Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Income Certificate — Application #INC-2024-00842',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              _feeRow('Application fee', 'Rs 30.00'),
                              Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                              _feeRow('Processing charge', 'Rs 5.00'),
                              Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                              _feeRow('GST 18%', 'Rs 6.30'),
                              Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                              _feeRow('Total', 'Rs 41.30', bold: true),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Ux4gStatusBanner(
                          variant: Ux4gBannerVariant.infoLight,
                          title:
                              'Secure payment via PayGov. Your payment '
                              'information is protected by 256-bit encryption.',
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                        ),
                        SizedBox(height: 20),
                        Ux4gButton(
                          text: 'Continue to payment',
                          onPressed: () {},
                          size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Back to review',
                              style: TextStyle(fontSize: 14, color: primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: fee row (same as Default variant)
Widget _feeRow(String label, String amount, {bool bold = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                color: bold ? Color(0xFF111827) : Color(0xFF6B7280),
              )),
        ),
        Text(amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: bold ? Color(0xFF111827) : Color(0xFF374151),
            )),
      ],
    ),
  );
}''';

// -----------------------------------------------------------------------
// PAYMENT METHOD — StatefulWidget (interactive radio selection)
// -----------------------------------------------------------------------

class _PaymentMethodMockup extends StatefulWidget {
  const _PaymentMethodMockup();

  @override
  State<_PaymentMethodMockup> createState() => _PaymentMethodMockupState();
}

class _PaymentMethodMockupState extends State<_PaymentMethodMockup> {
  String _method = 'upi';
  String _upiId = '';

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Choose payment method',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Select how you would like to pay Rs 41.30.',
                            style: TextStyle(
                              fontSize: 13,
                              color: _subtleText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _PmtOptionTile(
                            value: 'upi',
                            groupValue: _method,
                            onChanged: (v) =>
                                setState(() => _method = v ?? _method),
                            label: 'UPI',
                            subtitle:
                                'Pay using any UPI app (GPay, PhonePe, Paytm...)',
                          ),
                          _PmtOptionTile(
                            value: 'netbanking',
                            groupValue: _method,
                            onChanged: (v) =>
                                setState(() => _method = v ?? _method),
                            label: 'Net Banking',
                            subtitle: 'Pay directly from your bank account',
                          ),
                          _PmtOptionTile(
                            value: 'card',
                            groupValue: _method,
                            onChanged: (v) =>
                                setState(() => _method = v ?? _method),
                            label: 'Debit / Credit Card',
                            subtitle: 'Visa, Mastercard, RuPay accepted',
                          ),
                          _PmtOptionTile(
                            value: 'csc',
                            groupValue: _method,
                            onChanged: (v) =>
                                setState(() => _method = v ?? _method),
                            label: 'Pay at CSC Centre',
                            subtitle:
                                'Visit your nearest Common Service Centre',
                          ),
                          if (_method == 'upi') ...[
                            const SizedBox(height: 4),
                            Ux4gInputField(
                              value: _upiId,
                              onValueChange: (v) => setState(() => _upiId = v),
                              label: 'Enter UPI ID',
                              placeholder: 'yourname@upi',
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Ux4gPalette.neutral500
                                    : Ux4gPalette.neutral400,
                                height: 1.3,
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          Ux4gButton(
                            text: 'Pay Rs 41.30',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Back to summary',
                                style: TextStyle(fontSize: 14, color: primary),
                              ),
                            ),
                          ),
                        ],
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

class _PaymentMethodCardMockup extends StatefulWidget {
  const _PaymentMethodCardMockup();

  @override
  State<_PaymentMethodCardMockup> createState() =>
      _PaymentMethodCardMockupState();
}

class _PaymentMethodCardMockupState extends State<_PaymentMethodCardMockup> {
  String _method = 'upi';
  String _upiId = '';

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Choose payment method',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Select how you would like to pay Rs 41.30.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _PmtOptionTile(
                              value: 'upi',
                              groupValue: _method,
                              onChanged: (v) =>
                                  setState(() => _method = v ?? _method),
                              label: 'UPI',
                              subtitle:
                                  'Pay using any UPI app (GPay, PhonePe, Paytm...)',
                            ),
                            _PmtOptionTile(
                              value: 'netbanking',
                              groupValue: _method,
                              onChanged: (v) =>
                                  setState(() => _method = v ?? _method),
                              label: 'Net Banking',
                              subtitle: 'Pay directly from your bank account',
                            ),
                            _PmtOptionTile(
                              value: 'card',
                              groupValue: _method,
                              onChanged: (v) =>
                                  setState(() => _method = v ?? _method),
                              label: 'Debit / Credit Card',
                              subtitle: 'Visa, Mastercard, RuPay accepted',
                            ),
                            _PmtOptionTile(
                              value: 'csc',
                              groupValue: _method,
                              onChanged: (v) =>
                                  setState(() => _method = v ?? _method),
                              label: 'Pay at CSC Centre',
                              subtitle:
                                  'Visit your nearest Common Service Centre',
                            ),
                            if (_method == 'upi') ...[
                              const SizedBox(height: 4),
                              Ux4gInputField(
                                value: _upiId,
                                onValueChange: (v) =>
                                    setState(() => _upiId = v),
                                label: 'Enter UPI ID',
                                placeholder: 'yourname@upi',
                                placeholderStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Ux4gPalette.neutral500
                                      : Ux4gPalette.neutral400,
                                  height: 1.3,
                                ),
                              ),
                            ],
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Pay Rs 41.30',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Back to summary',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
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

const _paymentMethodCode = r'''
// StatefulWidget — tracks selected payment method
String _method = 'upi';
String _upiId = '';

Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5,
          currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'),
            Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'),
            Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose payment method',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Select how you would like to pay Rs 41.30.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Radio-style payment method tiles
                      _pmtOptionTile(
                        value: 'upi',
                        groupValue: _method,
                        onChanged: (v) => setState(() => _method = v ?? _method),
                        label: 'UPI',
                        subtitle: 'Pay using any UPI app (GPay, PhonePe, Paytm...)',
                      ),
                      _pmtOptionTile(
                        value: 'netbanking',
                        groupValue: _method,
                        onChanged: (v) => setState(() => _method = v ?? _method),
                        label: 'Net Banking',
                        subtitle: 'Pay directly from your bank account',
                      ),
                      _pmtOptionTile(
                        value: 'card',
                        groupValue: _method,
                        onChanged: (v) => setState(() => _method = v ?? _method),
                        label: 'Debit / Credit Card',
                        subtitle: 'Visa, Mastercard, RuPay accepted',
                      ),
                      _pmtOptionTile(
                        value: 'csc',
                        groupValue: _method,
                        onChanged: (v) => setState(() => _method = v ?? _method),
                        label: 'Pay at CSC Centre',
                        subtitle: 'Visit your nearest Common Service Centre',
                      ),
                      if (_method == 'upi') ...[
                        SizedBox(height: 4),
                        Ux4gInputField(
                          value: _upiId,
                          onValueChange: (v) => setState(() => _upiId = v),
                          label: 'Enter UPI ID',
                          placeholder: 'yourname@upi',
                        ),
                      ],
                      SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Pay Rs 41.30',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Back to summary',
                            style: TextStyle(fontSize: 14, color: primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: radio-style bordered payment tile
Widget _pmtOptionTile({
  required String value,
  required String groupValue,
  required ValueChanged<String?> onChanged,
  required String label,
  required String subtitle,
}) {
  final selected = value == groupValue;
  return GestureDetector(
    onTap: () => onChanged(value),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? primary.withOpacity(0.06) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? primary : Color(0xFFE5E7EB),
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20, height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? primary : Color(0xFFD1D5DB), width: 2),
            ),
            alignment: Alignment.center,
            child: selected
                ? Container(width: 10, height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, color: primary))
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: selected ? primary : Color(0xFF111827))),
                SizedBox(height: 2),
                Text(subtitle,
                    style: TextStyle(
                      fontSize: 12, color: Color(0xFF6B7280), height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}''';

const _paymentMethodCardCode = r'''
// StatefulWidget — tracks selected payment method (Card style)
String _method = 'upi';
String _upiId = '';

Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5,
          currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'),
            Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'),
            Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose payment method',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select how you would like to pay Rs 41.30.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 20),
                        _pmtOptionTile(
                          value: 'upi',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v ?? _method),
                          label: 'UPI',
                          subtitle: 'Pay using any UPI app (GPay, PhonePe, Paytm...)',
                        ),
                        _pmtOptionTile(
                          value: 'netbanking',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v ?? _method),
                          label: 'Net Banking',
                          subtitle: 'Pay directly from your bank account',
                        ),
                        _pmtOptionTile(
                          value: 'card',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v ?? _method),
                          label: 'Debit / Credit Card',
                          subtitle: 'Visa, Mastercard, RuPay accepted',
                        ),
                        _pmtOptionTile(
                          value: 'csc',
                          groupValue: _method,
                          onChanged: (v) => setState(() => _method = v ?? _method),
                          label: 'Pay at CSC Centre',
                          subtitle: 'Visit your nearest Common Service Centre',
                        ),
                        if (_method == 'upi') ...[
                          SizedBox(height: 4),
                          Ux4gInputField(
                            value: _upiId,
                            onValueChange: (v) => setState(() => _upiId = v),
                            label: 'Enter UPI ID',
                            placeholder: 'yourname@upi',
                          ),
                        ],
                        SizedBox(height: 20),
                        Ux4gButton(
                          text: 'Pay Rs 41.30',
                          onPressed: () {},
                          size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Back to summary',
                              style: TextStyle(fontSize: 14, color: primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: _pmtOptionTile — same as Default variant''';

// -----------------------------------------------------------------------
// PAYMENT PROCESSING — overlay spinner on dimmed background
// -----------------------------------------------------------------------

class _PaymentProcessingMockup extends StatelessWidget {
  const _PaymentProcessingMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Stack(
        children: [
          // Background: previous screen layout
          Column(
            children: [
              const _BrandHeader(),
              const _PmtStepBar(),
              const Divider(height: 1, thickness: 1, color: _border),
              Expanded(
                child: Container(
                  color: _bg,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Choose payment method',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Select how you would like to pay Rs 41.30.',
                        style: TextStyle(fontSize: 13, color: _subtleText),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Semi-transparent scrim
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.45)),
          ),
          // Centered modal card
          Positioned.fill(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Redirecting to PayGov...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please do not press back or refresh.\n'
                      'Your payment is being processed securely.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _subtleText,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentProcessingCardMockup extends StatelessWidget {
  const _PaymentProcessingCardMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Stack(
        children: [
          Column(
            children: [
              const _BrandHeader(),
              const _PmtStepBar(),
              const Divider(height: 1, thickness: 1, color: _border),
              Expanded(
                child: Container(
                  color: _suCardBg,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: _suCardDeco(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Choose payment method',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _titleColor,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select how you would like to pay Rs 41.30.',
                          style: TextStyle(fontSize: 13, color: _subtleText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.45)),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Redirecting to PayGov...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please do not press back or refresh.\n'
                      'Your payment is being processed securely.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _subtleText,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _paymentProcessingCode = r'''
Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Stack(
    children: [
      // Background: previous screen layout (dimmed)
      Column(
        children: [
          Ux4gAppHeader(
            variant: Ux4gAppHeaderVariant.light,
            title: '',
            leadingWidgets: [
              SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
              Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
              SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
            ],
            horizontalPadding: 16,
            leadingSpacing: 12,
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Ux4gStepper(
              totalSteps: 5,
              currentStep: 5,
              orientation: StepperOrientation.horizontal,
              steps: [
                Ux4gStepItem(title: 'Review'),
                Ux4gStepItem(title: 'Details'),
                Ux4gStepItem(title: 'Documents'),
                Ux4gStepItem(title: 'Preview'),
                Ux4gStepItem(title: 'Payment'),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Expanded(
            child: Container(
              color: Color(0xFFFAFAFA),
              padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose payment method',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                          color: Color(0xFF111827), height: 1.2)),
                  SizedBox(height: 4),
                  Text('Select how you would like to pay Rs 41.30.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                ],
              ),
            ),
          ),
        ],
      ),
      // Semi-transparent scrim
      Positioned.fill(
        child: Container(color: Colors.black.withOpacity(0.45)),
      ),
      // Centered modal card
      Positioned.fill(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            padding: EdgeInsets.fromLTRB(24, 28, 24, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 48, height: 48,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Redirecting to PayGov...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Please do not press back or refresh.\n'
                  'Your payment is being processed securely.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
)''';

const _paymentProcessingCardCode = r'''
Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Stack(
    children: [
      // Background: card-style previous screen (dimmed)
      Column(
        children: [
          Ux4gAppHeader(
            variant: Ux4gAppHeaderVariant.light,
            title: '',
            leadingWidgets: [
              SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
              Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
              SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
            ],
            horizontalPadding: 16,
            leadingSpacing: 12,
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Ux4gStepper(
              totalSteps: 5,
              currentStep: 5,
              orientation: StepperOrientation.horizontal,
              steps: [
                Ux4gStepItem(title: 'Review'),
                Ux4gStepItem(title: 'Details'),
                Ux4gStepItem(title: 'Documents'),
                Ux4gStepItem(title: 'Preview'),
                Ux4gStepItem(title: 'Payment'),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Expanded(
            child: Container(
              color: Color(0xFFE9E5FF),
              padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Choose payment method',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                            color: Color(0xFF111827), height: 1.2)),
                    SizedBox(height: 4),
                    Text('Select how you would like to pay Rs 41.30.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Semi-transparent scrim
      Positioned.fill(
        child: Container(color: Colors.black.withOpacity(0.45)),
      ),
      // Centered modal card
      Positioned.fill(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            padding: EdgeInsets.fromLTRB(24, 28, 24, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 48, height: 48,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Redirecting to PayGov...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Please do not press back or refresh.\n'
                  'Your payment is being processed securely.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
)''';

// -----------------------------------------------------------------------
// PAYMENT SUCCESS — flat + card
// -----------------------------------------------------------------------

class _PaymentSuccessMockup extends StatelessWidget {
  const _PaymentSuccessMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Ux4gPalette.green100,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Payment Successful',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Ux4gPalette.green700,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Rs 41.30 paid for Income Certificate '
                            '(Application #INC-2024-00842).',
                            style: TextStyle(
                              fontSize: 13,
                              color: _subtleText,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              border: Border.all(color: Ux4gPalette.green100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const _PayDetailRow(
                                  label: 'Amount paid',
                                  value: 'Rs 41.30',
                                  valueBold: true,
                                ),
                                const _PayDetailRow(
                                  label: 'Transaction ID',
                                  value: 'PG2026MH04127TX',
                                ),
                                const _PayDetailRow(
                                  label: 'Method',
                                  value: 'UPI - ramesh@upi',
                                ),
                                const _PayDetailRow(
                                  label: 'Date and time',
                                  value: '12 Apr 2026, 2:34 PM IST',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Ux4gButton(
                            text: 'Track my application',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 10),
                          Ux4gButton(
                            text: 'Download receipt (PDF)',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Return to services',
                                style: TextStyle(fontSize: 14, color: primary),
                              ),
                            ),
                          ),
                        ],
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

class _PaymentSuccessCardMockup extends StatelessWidget {
  const _PaymentSuccessCardMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        decoration: _suCardDeco(),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Ux4gPalette.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Payment Successful',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Ux4gPalette.green700,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Rs 41.30 paid for Income Certificate '
                              '(Application #INC-2024-00842).',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FDF4),
                                border: Border.all(color: Ux4gPalette.green100),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const _PayDetailRow(
                                    label: 'Amount paid',
                                    value: 'Rs 41.30',
                                    valueBold: true,
                                  ),
                                  const _PayDetailRow(
                                    label: 'Transaction ID',
                                    value: 'PG2026MH04127TX',
                                  ),
                                  const _PayDetailRow(
                                    label: 'Method',
                                    value: 'UPI - ramesh@upi',
                                  ),
                                  const _PayDetailRow(
                                    label: 'Date and time',
                                    value: '12 Apr 2026, 2:34 PM IST',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Track my application',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 10),
                            Ux4gButton(
                              text: 'Download receipt (PDF)',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Return to services',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
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

const _paymentSuccessCode = r'''
Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    children: [
                      // Green concentric badge
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.green100, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Ux4gPalette.green, shape: BoxShape.circle),
                          child: Icon(Icons.check, color: Colors.white, size: 22),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Payment Successful',
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800,
                          color: Ux4gPalette.green700,
                          height: 1.2, letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Rs 41.30 paid for Income Certificate '
                        '(Application #INC-2024-00842).',
                        style: TextStyle(
                          fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Transaction details table
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0FDF4),
                          border: Border.all(color: Ux4gPalette.green100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _payDetailRow('Amount paid', 'Rs 41.30', valueBold: true),
                            _payDetailRow('Transaction ID', 'PG2026MH04127TX'),
                            _payDetailRow('Method', 'UPI - ramesh@upi'),
                            _payDetailRow('Date and time', '12 Apr 2026, 2:34 PM IST'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Track my application',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 10),
                      Ux4gButton(
                        text: 'Download receipt (PDF)',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Return to services',
                              style: TextStyle(fontSize: 14, color: primary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: detail row
Widget _payDetailRow(String label, String value, {bool valueBold = false, Color? valueColor}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4,
          child: Text(label, style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)))),
        Expanded(flex: 5,
          child: Text(value, textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13,
                fontWeight: valueBold ? FontWeight.w600 : FontWeight.w400,
                color: valueColor ?? Color(0xFF111827)))),
      ],
    ),
  );
}''';

const _paymentSuccessCardCode = r'''
Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04),
                            blurRadius: 16, offset: Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64, height: 64,
                          decoration: BoxDecoration(
                            color: Ux4gPalette.green100, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: Ux4gPalette.green, shape: BoxShape.circle),
                            child: Icon(Icons.check, color: Colors.white, size: 22),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Payment Successful',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                              color: Ux4gPalette.green700, height: 1.2,
                              letterSpacing: -0.3),
                          textAlign: TextAlign.center),
                        SizedBox(height: 6),
                        Text('Rs 41.30 paid for Income Certificate '
                            '(Application #INC-2024-00842).',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6B7280),
                              height: 1.4),
                          textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF0FDF4),
                            border: Border.all(color: Ux4gPalette.green100),
                            borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            _payDetailRow('Amount paid', 'Rs 41.30', valueBold: true),
                            _payDetailRow('Transaction ID', 'PG2026MH04127TX'),
                            _payDetailRow('Method', 'UPI - ramesh@upi'),
                            _payDetailRow('Date and time', '12 Apr 2026, 2:34 PM IST'),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Ux4gButton(text: 'Track my application', onPressed: () {},
                            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                        SizedBox(height: 10),
                        Ux4gButton(text: 'Download receipt (PDF)', onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                        SizedBox(height: 12),
                        Center(
                          child: TextButton(onPressed: () {},
                            child: Text('Return to services',
                                style: TextStyle(fontSize: 14, color: primary))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11,
                      color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ]),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: _payDetailRow — same as Default variant''';

// -----------------------------------------------------------------------
// PAYMENT FAILED — flat + card
// -----------------------------------------------------------------------

class _PaymentFailedMockup extends StatelessWidget {
  const _PaymentFailedMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Ux4gPalette.red100,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.error_outline,
                              color: Ux4gPalette.red600,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Payment Failed',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Ux4gPalette.red800,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Your payment of Rs 41.30 could not be processed.',
                            style: TextStyle(
                              fontSize: 13,
                              color: _subtleText,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1F1),
                              border: Border.all(color: Ux4gPalette.red100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const _PayDetailRow(
                                  label: 'Reason',
                                  value: 'Bank declined',
                                  valueColor: Ux4gPalette.red600,
                                ),
                                const _PayDetailRow(
                                  label: 'Attempted amount',
                                  value: 'Rs 41.30',
                                ),
                                const _PayDetailRow(
                                  label: 'Method',
                                  value: 'UPI - ramesh@upi',
                                ),
                                const _PayDetailRow(
                                  label: 'Date and time',
                                  value: '12 Apr 2026, 2:34 PM IST',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Ux4gButton(
                            text: 'Try again with UPI',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 10),
                          Ux4gButton(
                            text: 'Try a different method',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Pay at CSC centre',
                                style: TextStyle(fontSize: 14, color: primary),
                              ),
                            ),
                          ),
                        ],
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

class _PaymentFailedCardMockup extends StatelessWidget {
  const _PaymentFailedCardMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        decoration: _suCardDeco(),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.red100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.error_outline,
                                color: Ux4gPalette.red600,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Payment Failed',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Ux4gPalette.red800,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Your payment of Rs 41.30 could not be processed.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1F1),
                                border: Border.all(color: Ux4gPalette.red100),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const _PayDetailRow(
                                    label: 'Reason',
                                    value: 'Bank declined',
                                    valueColor: Ux4gPalette.red600,
                                  ),
                                  const _PayDetailRow(
                                    label: 'Attempted amount',
                                    value: 'Rs 41.30',
                                  ),
                                  const _PayDetailRow(
                                    label: 'Method',
                                    value: 'UPI - ramesh@upi',
                                  ),
                                  const _PayDetailRow(
                                    label: 'Date and time',
                                    value: '12 Apr 2026, 2:34 PM IST',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Try again with UPI',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 10),
                            Ux4gButton(
                              text: 'Try a different method',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Pay at CSC centre',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
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

const _paymentFailedCode = r'''
Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    children: [
                      // Red error badge
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.red100, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(Icons.error_outline,
                            color: Ux4gPalette.red600, size: 32),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Payment Failed',
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800,
                          color: Ux4gPalette.red800,
                          height: 1.2, letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Your payment of Rs 41.30 could not be processed.',
                        style: TextStyle(
                          fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Error details table
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF1F1),
                          border: Border.all(color: Ux4gPalette.red100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _payDetailRow('Reason', 'Bank declined',
                                valueColor: Ux4gPalette.red600),
                            _payDetailRow('Attempted amount', 'Rs 41.30'),
                            _payDetailRow('Method', 'UPI - ramesh@upi'),
                            _payDetailRow('Date and time', '12 Apr 2026, 2:34 PM IST'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Try again with UPI',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 10),
                      Ux4gButton(
                        text: 'Try a different method',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Pay at CSC centre',
                              style: TextStyle(fontSize: 14, color: primary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: _payDetailRow — same as Payment Successful variant''';

const _paymentFailedCardCode = r'''
Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04),
                            blurRadius: 16, offset: Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64, height: 64,
                          decoration: BoxDecoration(
                            color: Ux4gPalette.red100, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Icon(Icons.error_outline,
                              color: Ux4gPalette.red600, size: 32),
                        ),
                        SizedBox(height: 16),
                        Text('Payment Failed',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                              color: Ux4gPalette.red800, height: 1.2,
                              letterSpacing: -0.3),
                          textAlign: TextAlign.center),
                        SizedBox(height: 6),
                        Text('Your payment of Rs 41.30 could not be processed.',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6B7280),
                              height: 1.4),
                          textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF1F1),
                            border: Border.all(color: Ux4gPalette.red100),
                            borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            _payDetailRow('Reason', 'Bank declined',
                                valueColor: Ux4gPalette.red600),
                            _payDetailRow('Attempted amount', 'Rs 41.30'),
                            _payDetailRow('Method', 'UPI - ramesh@upi'),
                            _payDetailRow('Date and time', '12 Apr 2026, 2:34 PM IST'),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Ux4gButton(text: 'Try again with UPI', onPressed: () {},
                            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                        SizedBox(height: 10),
                        Ux4gButton(text: 'Try a different method', onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                        SizedBox(height: 12),
                        Center(
                          child: TextButton(onPressed: () {},
                            child: Text('Pay at CSC centre',
                                style: TextStyle(fontSize: 14, color: primary))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11,
                      color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ]),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: _payDetailRow — same as Payment Successful variant''';

// -----------------------------------------------------------------------
// FEE WAIVED — flat + card
// -----------------------------------------------------------------------

class _FeeWaivedMockup extends StatelessWidget {
  const _FeeWaivedMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Ux4gPalette.green100,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Fee Waived',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Ux4gPalette.green700,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'As an SC/ST applicant, you are eligible for '
                            'a full fee waiver for this certificate.',
                            style: TextStyle(
                              fontSize: 13,
                              color: _subtleText,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              border: Border.all(color: Ux4gPalette.green100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const _FeeRow(
                                  label: 'Application fee',
                                  amount: 'Rs 30.00',
                                ),
                                const _FeeRow(
                                  label: 'Processing charge',
                                  amount: 'Rs 5.00',
                                ),
                                const _FeeRow(
                                  label: 'GST 18%',
                                  amount: 'Rs 6.30',
                                ),
                                const _FeeRow(
                                  label: 'Waiver applied',
                                  amount: '− Rs 41.30',
                                  redAmount: true,
                                ),
                                const _FeeRow(
                                  label: 'Total payable',
                                  amount: 'Rs 0.00',
                                  bold: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Ux4gButton(
                            text: 'Proceed without payment',
                            onPressed: () {},
                            size: Ux4gButtonSize.large,
                            height: 48,
                            width: 326,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Pay anyway',
                                style: TextStyle(fontSize: 14, color: primary),
                              ),
                            ),
                          ),
                        ],
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

class _FeeWaivedCardMockup extends StatelessWidget {
  const _FeeWaivedCardMockup();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const _PmtStepBar(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _suCardBg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        decoration: _suCardDeco(),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Ux4gPalette.green100,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Ux4gPalette.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Fee Waived',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Ux4gPalette.green700,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'As an SC/ST applicant, you are eligible for '
                              'a full fee waiver for this certificate.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FDF4),
                                border: Border.all(color: Ux4gPalette.green100),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const _FeeRow(
                                    label: 'Application fee',
                                    amount: 'Rs 30.00',
                                  ),
                                  const _FeeRow(
                                    label: 'Processing charge',
                                    amount: 'Rs 5.00',
                                  ),
                                  const _FeeRow(
                                    label: 'GST 18%',
                                    amount: 'Rs 6.30',
                                  ),
                                  const _FeeRow(
                                    label: 'Waiver applied',
                                    amount: '− Rs 41.30',
                                    redAmount: true,
                                  ),
                                  const _FeeRow(
                                    label: 'Total payable',
                                    amount: 'Rs 0.00',
                                    bold: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Ux4gButton(
                              text: 'Proceed without payment',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              height: 48,
                              width: 326,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Pay anyway',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
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

const _feeWaivedCode = r'''
Scaffold(
  backgroundColor: Color(0xFFFAFAFA),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    children: [
                      // Green concentric badge
                      Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                          color: Ux4gPalette.green100, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Ux4gPalette.green, shape: BoxShape.circle),
                          child: Icon(Icons.check, color: Colors.white, size: 22),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Fee Waived',
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800,
                          color: Ux4gPalette.green700,
                          height: 1.2, letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'As an SC/ST applicant, you are eligible for '
                        'a full fee waiver for this certificate.',
                        style: TextStyle(
                          fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Waiver breakdown table
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0FDF4),
                          border: Border.all(color: Ux4gPalette.green100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _feeRow('Application fee', 'Rs 30.00'),
                            _feeRow('Processing charge', 'Rs 5.00'),
                            _feeRow('GST 18%', 'Rs 6.30'),
                            _feeRow('Waiver applied', '\u2212 Rs 41.30', redAmount: true),
                            _feeRow('Total payable', 'Rs 0.00', bold: true),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Proceed without payment',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Pay anyway',
                              style: TextStyle(fontSize: 14, color: primary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: fee row
Widget _feeRow(String label, String amount, {bool bold = false, bool redAmount = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                color: bold ? Color(0xFF111827) : Color(0xFF6B7280)))),
        Text(amount,
            style: TextStyle(fontSize: 13,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: redAmount ? Ux4gPalette.red600
                  : (bold ? Color(0xFF111827) : Color(0xFF374151)))),
      ],
    ),
  );
}''';

const _feeWaivedCardCode = r'''
Scaffold(
  backgroundColor: Color(0xFFE9E5FF),
  body: Column(
    children: [
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
          SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Ux4gStepper(
          totalSteps: 5, currentStep: 5,
          orientation: StepperOrientation.horizontal,
          steps: [
            Ux4gStepItem(title: 'Review'), Ux4gStepItem(title: 'Details'),
            Ux4gStepItem(title: 'Documents'), Ux4gStepItem(title: 'Preview'),
            Ux4gStepItem(title: 'Payment'),
          ],
        ),
      ),
      Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      Expanded(
        child: Container(
          color: Color(0xFFE9E5FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04),
                            blurRadius: 16, offset: Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64, height: 64,
                          decoration: BoxDecoration(
                            color: Ux4gPalette.green100, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: Ux4gPalette.green, shape: BoxShape.circle),
                            child: Icon(Icons.check, color: Colors.white, size: 22),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Fee Waived',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                              color: Ux4gPalette.green700, height: 1.2,
                              letterSpacing: -0.3),
                          textAlign: TextAlign.center),
                        SizedBox(height: 6),
                        Text('As an SC/ST applicant, you are eligible for '
                            'a full fee waiver for this certificate.',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6B7280),
                              height: 1.4),
                          textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF0FDF4),
                            border: Border.all(color: Ux4gPalette.green100),
                            borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            _feeRow('Application fee', 'Rs 30.00'),
                            _feeRow('Processing charge', 'Rs 5.00'),
                            _feeRow('GST 18%', 'Rs 6.30'),
                            _feeRow('Waiver applied', '\u2212 Rs 41.30', redAmount: true),
                            _feeRow('Total payable', 'Rs 0.00', bold: true),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Ux4gButton(text: 'Proceed without payment', onPressed: () {},
                            size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                        SizedBox(height: 12),
                        Center(
                          child: TextButton(onPressed: () {},
                            child: Text('Pay anyway',
                                style: TextStyle(fontSize: 14, color: primary))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11,
                      color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
                ]),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)

// Helper: _feeRow — same as Default variant''';

// ═══════════════════════════════════════════════════════════════════════
// WidgetbookComponent registrations — Payment and Confirmation
// ═══════════════════════════════════════════════════════════════════════

final paymentSummaryComponent = WidgetbookComponent(
  name: 'Payment',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Payment',
          description:
              'Fee breakdown and payment gateway entry screen. Shows the '
              'application fee table, a PayGov info banner, and a Continue '
              'CTA. Use the [Variant] knob to toggle between flat and '
              'card-style layouts.',
          code: variant == 'Card style'
              ? _paymentSummaryCardCode
              : _paymentSummaryCode,
          center: true,
          child: variant == 'Card style'
              ? const _PaymentSummaryCardMockup()
              : const _PaymentSummaryMockup(),
        );
      },
    ),
  ],
);

final paymentMethodComponent = WidgetbookComponent(
  name: 'Choose Payment Method',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Choose Payment Method',
          description:
              'Radio-tile payment method selector. Includes UPI, Net Banking, '
              'Debit/Credit Card, and CSC Centre options. Selecting UPI '
              'reveals an inline UPI ID input. Use the [Variant] knob to '
              'toggle between flat and card-style layouts.',
          code: variant == 'Card style'
              ? _paymentMethodCardCode
              : _paymentMethodCode,
          center: true,
          child: variant == 'Card style'
              ? const _PaymentMethodCardMockup()
              : const _PaymentMethodMockup(),
        );
      },
    ),
  ],
);

final paymentProcessingComponent = WidgetbookComponent(
  name: 'Payment Processing',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Payment Processing',
          description:
              'Dimmed overlay with a centered modal card and a '
              'CircularProgressIndicator shown while the app redirects to '
              'PayGov. Use the [Variant] knob to toggle layouts.',
          code: variant == 'Card style'
              ? _paymentProcessingCardCode
              : _paymentProcessingCode,
          center: true,
          child: variant == 'Card style'
              ? const _PaymentProcessingCardMockup()
              : const _PaymentProcessingMockup(),
        );
      },
    ),
  ],
);

final paymentSuccessComponent = WidgetbookComponent(
  name: 'Payment Successful',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Payment Successful',
          description:
              'Confirmation screen after a successful payment. Displays a '
              'green badge, transaction details table, and options to track '
              'the application or download the receipt. Use the [Variant] '
              'knob to toggle layouts.',
          code: variant == 'Card style'
              ? _paymentSuccessCardCode
              : _paymentSuccessCode,
          center: true,
          child: variant == 'Card style'
              ? const _PaymentSuccessCardMockup()
              : const _PaymentSuccessMockup(),
        );
      },
    ),
  ],
);

final paymentFailedComponent = WidgetbookComponent(
  name: 'Payment Failed',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Payment Failed',
          description:
              'Error screen when a payment is declined. Displays a red badge, '
              'a red-tinted details table with the failure reason, and '
              'retry/alternative-method CTAs. Use the [Variant] knob to '
              'toggle layouts.',
          code: variant == 'Card style'
              ? _paymentFailedCardCode
              : _paymentFailedCode,
          center: true,
          child: variant == 'Card style'
              ? const _PaymentFailedCardMockup()
              : const _PaymentFailedMockup(),
        );
      },
    ),
  ],
);

final feeWaivedComponent = WidgetbookComponent(
  name: 'Fee Waived',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the flat phone layout and the card-style layout.',
        );
        return ComponentDocs(
          name: 'Fee Waived',
          description:
              'Screen shown for applicants eligible for a full fee waiver '
              '(e.g. SC/ST category). Shows the waiver breakdown with a '
              'negative row and Rs 0.00 total. Use the [Variant] knob to '
              'toggle layouts.',
          code: variant == 'Card style' ? _feeWaivedCardCode : _feeWaivedCode,
          center: true,
          child: variant == 'Card style'
              ? const _FeeWaivedCardMockup()
              : const _FeeWaivedMockup(),
        );
      },
    ),
  ],
);

// -----------------------------------------------------------------------
// APPLICATION STATUS TRACKER
// -----------------------------------------------------------------------

// -- Status helpers ------------------------------------------------------

Ux4gTagColor _astTagColor(String status) => switch (status) {
  'Approved' => Ux4gTagColor.success,
  'Rejected' => Ux4gTagColor.error,
  'Delayed' || 'Action Required' => Ux4gTagColor.warning,
  _ => Ux4gTagColor.neutral,
};

// -- Alert banner --------------------------------------------------------

class _AstBanner extends StatelessWidget {
  const _AstBanner({required this.status, this.hPad = 16.0});
  final String status;
  final double hPad;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'Action Required' => Container(
        margin: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Ux4gPalette.orange50,
          border: Border.all(color: Ux4gPalette.orange500),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Ux4gPalette.orange500,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Action required upload your income proof document',
                    style: TextStyle(
                      fontSize: 12,
                      color: Ux4gPalette.orange700,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Upload Document',
                      style: TextStyle(
                        fontSize: 12,
                        color: Ux4gPalette.orange500,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      'Rejected' => Container(
        margin: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          border: Border.all(color: Ux4gPalette.red100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel_outlined,
                  color: Ux4gPalette.red600,
                  size: 18,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Why was this rejected?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Ux4gPalette.red600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'The income proof document submitted was not legible; '
              'the scan was too blurry to read.',
              style: TextStyle(
                fontSize: 11,
                color: Ux4gPalette.red600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            const _AstBullet(
              text: 'Re-scan the document in good lighting',
              color: Ux4gPalette.red600,
            ),
            const _AstBullet(
              text: 'Upload a clear JPG or PDF under 2 MB',
              color: Ux4gPalette.red600,
            ),
            const _AstBullet(
              text: 'Reapply with the corrected document',
              color: Ux4gPalette.red600,
            ),
          ],
        ),
      ),
      'Delayed' => Container(
        margin: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Ux4gPalette.cyan50,
          border: Border.all(color: Ux4gPalette.cyan500),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.access_time_outlined,
                  color: Ux4gPalette.cyan600,
                  size: 18,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Why is this delayed?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Ux4gPalette.cyan600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Additional field verification is required due to an '
              'address discrepancy in your application.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF0E7490),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Revised expected date',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF0E7490),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              '25 Apr 2026',
              style: TextStyle(
                fontSize: 13,
                color: Ux4gPalette.cyan600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _AstBullet extends StatelessWidget {
  const _AstBullet({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 11, color: color)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11, color: color, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// -- Timeline step -------------------------------------------------------

class _AstTimelineStep extends StatelessWidget {
  const _AstTimelineStep({
    required this.date,
    required this.title,
    required this.isCompleted,
    required this.isActive,
    required this.isLast,
    required this.primary,
    this.pendingNote,
    this.pendingBadge,
  });

  final String date;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;
  final Color primary;
  final String? pendingNote;
  final String? pendingBadge;

  @override
  Widget build(BuildContext context) {
    final dotColor = (isCompleted || isActive)
        ? primary
        : const Color(0xFFD1D5DB);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 10)
                      : isActive
                      ? Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 2,
                        color: isCompleted ? primary : const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? primary.withValues(alpha: 0.07)
                      : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive
                        ? primary.withValues(alpha: 0.2)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        color: isActive ? primary : _subtleText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isActive ? primary : _titleColor,
                      ),
                    ),
                    if (pendingNote != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 12,
                            color: Ux4gPalette.orange500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pendingNote!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Ux4gPalette.orange500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Ux4gTag(
                            text: pendingBadge!,
                            colorScheme: Ux4gTagColor.warning,
                            style: Ux4gTagStyle.tonal,
                            size: Ux4gTagSize.m,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -- Journey widget -------------------------------------------------------

class _AstJourney extends StatelessWidget {
  const _AstJourney({required this.status, required this.primary});
  final String status;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == 'Approved';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(14),
      child: Ux4gJourneyTimeline(
        activeColor: primary,
        header: const Ux4gJourneyHeader(
          title: 'Application journey',
          description: 'Every step from submission to issuance',
        ),
        steps: [
          const Ux4gJourneyStep(
            state: Ux4gJourneyStepState.completed,
            date: '07 Apr 2026, 10:24 AM',
            title: 'Application Submitted',
          ),
          const Ux4gJourneyStep(
            state: Ux4gJourneyStepState.completed,
            date: '10 Apr 2026, 02:15 PM',
            title: 'Documents Verified',
          ),
          Ux4gJourneyStep(
            state: isApproved
                ? Ux4gJourneyStepState.completed
                : Ux4gJourneyStepState.current,
            date: '11 Apr 2026, 09:03 AM',
            title: 'Officer Review',
          ),
          Ux4gJourneyStep(
            state: isApproved
                ? Ux4gJourneyStepState.current
                : Ux4gJourneyStepState.upcoming,
            date: 'Est. 22 Apr 2026',
            title: isApproved
                ? 'Certificate Issued'
                : 'Certificate Will Be Issued',
            status: isApproved
                ? null
                : const Ux4gJourneyStepStatus(
                    text: '11 days remaining',
                    dotColor: Ux4gPalette.orange500,
                    badgeText: 'Pending',
                    badgeTextColor: Ux4gPalette.orange500,
                  ),
          ),
        ],
      ),
    );
  }
}

// -- App info card --------------------------------------------------------

class _AstInfoCard extends StatelessWidget {
  const _AstInfoCard({
    required this.status,
    required this.tagColor,
    required this.progressColor,
    this.bgColor = Colors.white,
  });
  final String status;
  final Ux4gTagColor tagColor;
  final Color progressColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == 'Approved';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Income Certificate',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _titleColor,
                  ),
                ),
              ),
              Ux4gTag(
                text: status,
                colorScheme: tagColor,
                style: Ux4gTagStyle.tonal,
                size: Ux4gTagSize.m,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Application ID · INC-2026-MH-04127',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          if (!isApproved) ...[
            const SizedBox(height: 10),
            Ux4gLinearProgress(
              value: 0.6,
              label: '8 days left',
              gradientColors: [Colors.white, progressColor],
              shape: Ux4gProgressShape.rounded,
              height: 6,
            ),
          ],
        ],
      ),
    );
  }
}

// -- Bottom actions -------------------------------------------------------

Widget _astActions(String status, Color primary) => switch (status) {
  'Rejected' => Column(
    children: [
      Ux4gButton(
        text: 'Reapply',
        onPressed: () {},
        size: Ux4gButtonSize.large,
        height: 48,
        width: 326,
      ),
      const SizedBox(height: 10),
      Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Contact district office',
            style: TextStyle(fontSize: 14, color: primary),
          ),
        ),
      ),
    ],
  ),
  'Delayed' => Center(
    child: TextButton(
      onPressed: () {},
      child: const Text(
        'Escalate this application',
        style: TextStyle(
          fontSize: 14,
          color: Ux4gPalette.red600,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  'Approved' => Column(
    children: [
      Ux4gButton(
        text: 'Download Certificate (PDF)',
        onPressed: () {},
        size: Ux4gButtonSize.large,
        height: 48,
        width: 326,
      ),
      const SizedBox(height: 10),
      Ux4gButton(
        text: 'Save to DigiLocker',
        onPressed: () {},
        variant: Ux4gButtonVariant.outline,
        size: Ux4gButtonSize.large,
        height: 48,
        width: 326,
      ),
    ],
  ),
  _ => const SizedBox.shrink(),
};

// -- Flat mockup ----------------------------------------------------------

class _AppStatusTrackerMockup extends StatelessWidget {
  const _AppStatusTrackerMockup({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final mt = Theme.of(context);
    final primary =
        mt.extension<Ux4gColors>()?.primary ?? mt.colorScheme.primary;
    final tagColor = _astTagColor(status);
    final progressColor = primary;
    final hasActions =
        status == 'Rejected' || status == 'Delayed' || status == 'Approved';

    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: const _BackButton(),
                          ),
                          _AstBanner(status: status),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                            child: _AstInfoCard(
                              status: status,
                              tagColor: tagColor,
                              progressColor: progressColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: _AstJourney(
                              status: status,
                              primary: primary,
                            ),
                          ),
                          if (hasActions)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: _astActions(status, primary),
                            ),
                        ],
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

// -- Card-style mockup ----------------------------------------------------

class _AppStatusTrackerCardMockup extends StatelessWidget {
  const _AppStatusTrackerCardMockup({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final mt = Theme.of(context);
    final primary =
        mt.extension<Ux4gColors>()?.primary ?? mt.colorScheme.primary;
    final tagColor = _astTagColor(status);
    final progressColor = primary;
    final hasActions =
        status == 'Rejected' || status == 'Delayed' || status == 'Approved';

    return _PhoneFrame(
      child: Column(
        children: [
          const _BrandHeader(),
          const Divider(height: 1, thickness: 1, color: _border),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Container(
                        decoration: _suCardDeco(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                              child: const _BackButton(),
                            ),
                            _AstBanner(status: status, hPad: 14),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                              child: _AstInfoCard(
                                status: status,
                                tagColor: tagColor,
                                progressColor: progressColor,
                                bgColor: _bg,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                16,
                                14,
                                16,
                              ),
                              child: _AstJourney(
                                status: status,
                                primary: primary,
                              ),
                            ),
                            if (hasActions)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  14,
                                  0,
                                  14,
                                  14,
                                ),
                                child: _astActions(status, primary),
                              ),
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

// -- Widgetbook component -------------------------------------------------

const _astDefaultCode = r'''
// Application Status Tracker — flat layout (360 × 760)
// status: 'Under Review' | 'Action Required' | 'Rejected' | 'Delayed' | 'Approved'
// primaryColor: Theme.of(context).extension<Ux4gColors>()?.primary
// tagColor: neutral=UnderReview, warning=ActionRequired/Delayed, error=Rejected, success=Approved
Container(
  width: 360,
  decoration: BoxDecoration(color: Colors.white),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_emblem_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(child: Container(
      color: Color(0xFFFAFAFA),
      child: Column(children: [
        Expanded(child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ← Back
            Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Ux4gButton(
                text: 'Back',
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.small,
                leadingIcon: Icons.arrow_back,
                iconSize: 18,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                onPressed: () {},
              ),
            ),

            // ── Alert banner (state-dependent) ───────────────────────────
            // ▸ Action Required
            Container(
              margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Ux4gPalette.orange50,
                border: Border.all(color: Ux4gPalette.orange500),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.warning_amber_rounded,
                    color: Ux4gPalette.orange500, size: 18),
                SizedBox(width: 8),
                Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Action required upload your income proof document',
                    style: TextStyle(fontSize: 12, color: Ux4gPalette.orange700,
                        fontWeight: FontWeight.w500, height: 1.4),
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Upload Document',
                        style: TextStyle(fontSize: 12,
                            color: Ux4gPalette.orange500,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline)),
                  ),
                ])),
              ]),
            ),
            // ▸ Rejected: bg Color(0xFFFEF2F2), border Ux4gPalette.red100,
            //             icon Icons.cancel_outlined, textColor Ux4gPalette.red600
            // ▸ Delayed:  bg Ux4gPalette.cyan50, border Ux4gPalette.cyan500,
            //             icon Icons.access_time_outlined, textColor Ux4gPalette.cyan600
            // ▸ Under Review / Approved: SizedBox.shrink()

            // ── Application info card ─────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    Expanded(child: Text('Income Certificate',
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w700))),
                    Ux4gTag(text: status, colorScheme: tagColor,
                        style: Ux4gTagStyle.tonal, size: Ux4gTagSize.m),
                  ]),
                  SizedBox(height: 4),
                  Text('Application ID · INC-2026-MH-04127',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  // ▸ Progress bar hidden for Approved state
                  if (!isApproved) ...[
                    SizedBox(height: 10),
                    Ux4gLinearProgress(
                      value: 0.6,
                      label: '8 days left',
                      gradientColors: [Colors.white, primaryColor],
                      shape: Ux4gProgressShape.rounded,
                      height: 6,
                    ),
                  ],
                ]),
              ),
            ),

            // ── Application journey ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(14),
                child: Ux4gJourneyTimeline(
                  activeColor: primaryColor,
                  header: Ux4gJourneyHeader(
                    title: 'Application journey',
                    description: 'Every step from submission to issuance',
                  ),
                  steps: [
                    Ux4gJourneyStep(
                      state: Ux4gJourneyStepState.completed,
                      date: '07 Apr 2026, 10:24 AM',
                      title: 'Application Submitted',
                    ),
                    Ux4gJourneyStep(
                      state: Ux4gJourneyStepState.completed,
                      date: '10 Apr 2026, 02:15 PM',
                      title: 'Documents Verified',
                    ),
                    // state: current=UnderReview/ActionRequired/Rejected/Delayed
                    //        completed=Approved
                    Ux4gJourneyStep(
                      state: Ux4gJourneyStepState.current,
                      date: '11 Apr 2026, 09:03 AM',
                      title: 'Officer Review',
                    ),
                    // title: 'Certificate Issued' & state: current when Approved
                    Ux4gJourneyStep(
                      state: Ux4gJourneyStepState.upcoming,
                      date: 'Est. 22 Apr 2026',
                      title: 'Certificate Will Be Issued',
                      status: Ux4gJourneyStepStatus(
                        text: '11 days remaining',
                        dotColor: Ux4gPalette.orange500,
                        badgeText: 'Pending',
                        badgeTextColor: Ux4gPalette.orange500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom actions (state-dependent) ─────────────────────────
            // ▸ Rejected:
            Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 8), child: Column(children: [
              Ux4gButton(text: 'Reapply', onPressed: () {},
                  size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
              SizedBox(height: 10),
              Center(child: TextButton(onPressed: () {},
                  child: Text('Contact district office',
                      style: TextStyle(fontSize: 14, color: primaryColor)))),
            ])),
            // ▸ Delayed:
            // Center(child: TextButton(onPressed: () {},
            //   child: Text('Escalate this application',
            //     style: TextStyle(fontSize: 14, color: Ux4gPalette.red600,
            //                      fontWeight: FontWeight.w600))))
            // ▸ Approved:
            // Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 8), child: Column(children: [
            //   Ux4gButton(text: 'Download Certificate (PDF)', onPressed: () {},
            //       size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            //   SizedBox(height: 10),
            //   Ux4gButton(text: 'Save to DigiLocker', onPressed: () {},
            //       variant: Ux4gButtonVariant.outline,
            //       size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
            // ]))
          ]),
        )),

        // Powered by - Digital India
        Padding(padding: EdgeInsets.only(bottom: 20, top: 8), child: Column(
          mainAxisSize: MainAxisSize.min, children: [
          Text('Powered by -',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ])),
      ]),
    )),
  ]),
)''';

const _astCardCode = r'''
// Application Status Tracker — card style (360 × 760)
// Same inner content as flat layout but hPad=14; content sits inside a
// white elevated card over a purple-tinted (Color(0xFFE9E5FF)) background.
// primaryColor: Theme.of(context).extension<Ux4gColors>()?.primary
// tagColor: neutral=UnderReview, warning=ActionRequired/Delayed, error=Rejected, success=Approved
Container(
  width: 360,
  decoration: BoxDecoration(color: Colors.white),
  child: Column(children: [
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_emblem_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32, colorFilter: ColorFilter.mode(Theme.of(context).brightness == Brightness.dark ? Colors.white : Ux4gPalette.primary500, BlendMode.srcIn)),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: Color(0xFFE5E7EB)),
    Expanded(child: Container(
      color: Color(0xFFE9E5FF),
      child: Column(children: [
        Expanded(child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16, offset: Offset(0, 4))],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

              // ← Back
              Padding(
                padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: Ux4gButton(
                  text: 'Back',
                  variant: Ux4gButtonVariant.ghost,
                  size: Ux4gButtonSize.small,
                  leadingIcon: Icons.arrow_back,
                  iconSize: 18,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  onPressed: () {},
                ),
              ),

              // ── Alert banner (same colors/icons as flat layout) ──────────
              // ▸ Action Required: bg Ux4gPalette.orange50, border Ux4gPalette.orange500
              //   icon Icons.warning_amber_rounded, textColor Ux4gPalette.orange700
              // ▸ Rejected: bg Color(0xFFFEF2F2), border Ux4gPalette.red100,
              //   icon Icons.cancel_outlined, textColor Ux4gPalette.red600
              // ▸ Delayed: bg Ux4gPalette.cyan50, border Ux4gPalette.cyan500,
              //   icon Icons.access_time_outlined, textColor Ux4gPalette.cyan600
              // ▸ Under Review / Approved: SizedBox.shrink()

              // ── Application info card ──────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    border: Border.all(color: Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(child: Text('Income Certificate',
                          style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w700))),
                      Ux4gTag(text: status, colorScheme: tagColor,
                          style: Ux4gTagStyle.tonal, size: Ux4gTagSize.m),
                    ]),
                    SizedBox(height: 4),
                    Text('Application ID · INC-2026-MH-04127',
                        style: TextStyle(fontSize: 12,
                            color: Color(0xFF6B7280))),
                    // ▸ Progress bar hidden for Approved state
                    if (!isApproved) ...[
                      SizedBox(height: 10),
                      Ux4gLinearProgress(
                        value: 0.6,
                        label: '8 days left',
                        gradientColors: [Colors.white, primaryColor],
                        shape: Ux4gProgressShape.rounded,
                        height: 6,
                      ),
                    ],
                  ]),
                ),
              ),

              // ── Application journey ───────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(14),
                  child: Ux4gJourneyTimeline(
                    activeColor: primaryColor,
                    header: Ux4gJourneyHeader(
                      title: 'Application journey',
                      description: 'Every step from submission to issuance',
                    ),
                    steps: [
                      Ux4gJourneyStep(
                        state: Ux4gJourneyStepState.completed,
                        date: '07 Apr 2026, 10:24 AM',
                        title: 'Application Submitted',
                      ),
                      Ux4gJourneyStep(
                        state: Ux4gJourneyStepState.completed,
                        date: '10 Apr 2026, 02:15 PM',
                        title: 'Documents Verified',
                      ),
                      // state: current=UnderReview/ActionRequired/Rejected/Delayed
                      //        completed=Approved
                      Ux4gJourneyStep(
                        state: Ux4gJourneyStepState.current,
                        date: '11 Apr 2026, 09:03 AM',
                        title: 'Officer Review',
                      ),
                      // title: 'Certificate Issued' & state: current when Approved
                      Ux4gJourneyStep(
                        state: Ux4gJourneyStepState.upcoming,
                        date: 'Est. 22 Apr 2026',
                        title: 'Certificate Will Be Issued',
                        status: Ux4gJourneyStepStatus(
                          text: '11 days remaining',
                          dotColor: Ux4gPalette.orange500,
                          badgeText: 'Pending',
                          badgeTextColor: Ux4gPalette.orange500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bottom actions (state-dependent) ──────────────────────
              // ▸ Rejected:
              Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: Column(children: [
                Ux4gButton(text: 'Reapply', onPressed: () {},
                    size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
                SizedBox(height: 10),
                Center(child: TextButton(onPressed: () {},
                    child: Text('Contact district office',
                        style: TextStyle(
                            fontSize: 14, color: primaryColor)))),
              ])),
              // ▸ Delayed:
              // Center(child: TextButton(onPressed: () {},
              //   child: Text('Escalate this application',
              //     style: TextStyle(fontSize: 14, color: Ux4gPalette.red600,
              //                      fontWeight: FontWeight.w600))))
              // ▸ Approved:
              // Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
              //   child: Column(children: [
              //     Ux4gButton(text: 'Download Certificate (PDF)',
              //         onPressed: () {},
              //         size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
              //     SizedBox(height: 10),
              //     Ux4gButton(text: 'Save to DigiLocker', onPressed: () {},
              //         variant: Ux4gButtonVariant.outline,
              //         size: Ux4gButtonSize.large,
              height: 48,
              width: 326,
            ),
              //   ]))
            ]),
          ),
        )),

        // Powered by - Digital India
        Padding(padding: EdgeInsets.only(bottom: 20, top: 8), child: Column(
          mainAxisSize: MainAxisSize.min, children: [
          Text('Powered by -',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null),
        ])),
      ]),
    )),
  ]),
)''';

final appStatusTrackerComponent = WidgetbookComponent(
  name: 'Application Status Tracker',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final status = context.knobs.list(
          label: 'Status',
          options: const [
            'Under Review',
            'Action Required',
            'Rejected',
            'Delayed',
            'Approved',
          ],
          initialOption: 'Under Review',
          description: 'Switch between the 5 application states.',
        );
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Toggle between flat and card-style layouts.',
        );
        return ComponentDocs(
          name: 'Application Status Tracker',
          description:
              'Tracks the end-to-end lifecycle of a government service '
              'application through five states: Under Review, Action '
              'Required, Rejected, Delayed, and Approved. Use the '
              '[Status] knob to preview each state and [Variant] for '
              'card layout.',
          code: variant == 'Card style' ? _astCardCode : _astDefaultCode,
          center: true,
          child: variant == 'Card style'
              ? _AppStatusTrackerCardMockup(status: status)
              : _AppStatusTrackerMockup(status: status),
        );
      },
    ),
  ],
);

// ============================================================
// Grievance Status Tracker Pattern
// ============================================================

// Status → Ux4gTag colour mapping
Ux4gTagColor _gstTagColor(String status) => switch (status) {
  'Resolved' => Ux4gTagColor.success,
  'Assigned' => Ux4gTagColor.brand,
  'Escalated' => Ux4gTagColor.warning,
  'Reopened' => Ux4gTagColor.warning,
  _ => Ux4gTagColor.warning, // In Progress
};

Widget _gstTagIcon(String status) {
  final (icon, color) = switch (status) {
    'Resolved' => (Icons.check_circle_outline, Ux4gPalette.green600),
    'Assigned' => (Icons.assignment_ind_outlined, Ux4gPalette.primary600),
    'Escalated' => (Icons.warning_amber_rounded, Ux4gPalette.orange700),
    'Reopened' => (Icons.replay_rounded, Ux4gPalette.orange700),
    _ => (Icons.assignment_outlined, Ux4gPalette.orange700), // In Progress
  };
  return Icon(icon, size: 13, color: color);
}

// ── Purple filled app-header with back button ───────────────────────────
class _GstHeader extends StatelessWidget {
  const _GstHeader();

  @override
  Widget build(BuildContext context) {
    return Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.filled,
      title: 'Application Status',
      showBackButton: true,
      onBackPressed: () {},
      horizontalPadding: 16,
    );
  }
}

// ── Top info card: title + status badge + grievance ID + progress bar ───
class _GstInfoCard extends StatelessWidget {
  const _GstInfoCard({
    required this.status,
    required this.tagColor,
    required this.primary,
  });

  final String status;
  final Ux4gTagColor tagColor;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final isResolved = status == 'Resolved';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEF0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Delay in certificate issuance',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _titleColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Ux4gTag(
                text: status,
                colorScheme: tagColor,
                style: Ux4gTagStyle.tonal,
                size: Ux4gTagSize.m,
                shape: Ux4gTagShape.rectangular,
                leadingContent: _gstTagIcon(status),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Grievance ID · GRV-2026-MH-04127',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          if (!isResolved) ...[
            const SizedBox(height: 10),
            const Text(
              '8 days left',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 6),
            Ux4gLinearProgress(
              value: 0.55,
              gradientColors: const [
                Color(0xFFFFCC80), // light amber
                Color(0xFFFF8F00), // deep orange
              ],
              trackColor: const Color(0xFFEEEEEE),
              shape: Ux4gProgressShape.rounded,
              height: 8,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Grievance details table (In Progress state) ─────────────────────────
class _GstDetailTable extends StatelessWidget {
  const _GstDetailTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEF0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grievance details',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 10),
          const _GstDetailRow(label: 'Category', value: 'Certificate Issuance'),
          const _GstDetailRow(label: 'Lodged on', value: '02 Apr 2026'),
          const _GstDetailRow(label: 'Against', value: 'Revenue Dept, Pune'),
          const _GstDetailRow(
            label: 'Current stage',
            value: 'District Officer',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _GstDetailRow extends StatelessWidget {
  const _GstDetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: _subtleText),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Assigned officer card ────────────────────────────────────────────────
class _GstAssignedOfficer extends StatelessWidget {
  const _GstAssignedOfficer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEF0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assigned officer',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'District Grievance Officer',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Revenue Department, Pune',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Office contact',
                      style: TextStyle(fontSize: 11, color: _subtleText),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '020-2612-XXXX',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _titleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Handling since',
                      style: TextStyle(fontSize: 11, color: _subtleText),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '08 Apr 2026',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _titleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Officers are identified by designation only — never by personal name.',
            style: TextStyle(
              fontSize: 11,
              color: _mutedText,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Escalation path card (Escalated state) ──────────────────────────────
class _GstEscalationPath extends StatelessWidget {
  const _GstEscalationPath();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEF0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escalation path',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your grievance moves up a level if it is not resolved within the SLA.',
            style: TextStyle(fontSize: 11, color: _subtleText, height: 1.4),
          ),
          const SizedBox(height: 12),
          const _GstEscalationLevel(
            level: 'Level 1 - District Grievance Officer',
            subtitle: 'Revenue Dept, Pune · Active since 10 Apr 2026',
            isActive: false,
          ),
          const SizedBox(height: 8),
          const _GstEscalationLevel(
            level: 'Level 2 - State Appellate Authority',
            subtitle: 'Pending — escalates after SLA breach',
            isActive: false,
          ),
          const SizedBox(height: 8),
          const _GstEscalationLevel(
            level: 'Level 3 · CPGRAMS (National portal)',
            subtitle: 'Pending — final escalation level',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _GstEscalationLevel extends StatelessWidget {
  const _GstEscalationLevel({
    required this.level,
    required this.subtitle,
    required this.isActive,
  });

  final String level;
  final String subtitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? Ux4gPalette.orange50 : const Color(0xFFF9FAFB),
        border: Border.all(
          color: isActive ? Ux4gPalette.orange500 : const Color(0xFFE5E7EB),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Ux4gPalette.orange700 : _subtleText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isActive ? Ux4gPalette.orange500 : _mutedText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            const Icon(Icons.circle, size: 10, color: Ux4gPalette.orange500),
        ],
      ),
    );
  }
}

// ── Resolution + satisfaction survey (Resolved state) ───────────────────
class _GstResolutionSection extends StatelessWidget {
  const _GstResolutionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Green resolution banner
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Ux4gPalette.green50,
            border: Border.all(color: Ux4gPalette.green500),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                Icons.check_circle_outline,
                color: Ux4gPalette.green600,
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Grievance resolved on 14 Apr 2026 – certificate issued',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Ux4gPalette.green700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Satisfaction survey card
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are you satisfied with the resolution?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 12),
              Ux4gButton(
                text: 'Yes, satisfied',
                onPressed: () {},
                variant: Ux4gButtonVariant.outline,
                size: Ux4gButtonSize.medium,
                width: double.infinity,
              ),
              const SizedBox(height: 8),
              Ux4gButton(
                text: 'No, reopen',
                onPressed: () {},
                variant: Ux4gButtonVariant.outline,
                size: Ux4gButtonSize.medium,
                width: double.infinity,
              ),
              const SizedBox(height: 10),
              const Text(
                'You have 30 days from the resolution date to reopen this complaint.',
                style: TextStyle(fontSize: 11, color: _mutedText, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Reopen complaint form (Reopened state) ───────────────────────────────
class _GstReopenForm extends StatelessWidget {
  const _GstReopenForm({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEF0)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reopen your complaint',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Why are you not satisfied?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 6),
          // Dropdown mock
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Certificate still not issued',
                    style: TextStyle(fontSize: 13, color: _titleColor),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Additional details',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add any details that will help us re-examine your grievance.',
                style: TextStyle(fontSize: 12, color: _mutedText, height: 1.4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Ux4gButton(
            text: 'Reopen complaint',
            onPressed: () {},
            size: Ux4gButtonSize.large,
            height: 48,
            width: 326,
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 14, color: primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Grievance journey timeline ───────────────────────────────────────────
class _GstJourney extends StatelessWidget {
  const _GstJourney({required this.status, required this.primary});

  final String status;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final assignedOrLater =
        status == 'Assigned' ||
        status == 'Escalated' ||
        status == 'Resolved' ||
        status == 'Reopened';
    final underReviewOrLater =
        status == 'Escalated' || status == 'Resolved' || status == 'Reopened';
    final escalatedOrLater =
        status == 'Resolved' || status == 'Reopened' || status == 'Escalated';
    final isResolved = status == 'Resolved' || status == 'Reopened';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grievance journey',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Every update from lodging to resolution',
          style: TextStyle(fontSize: 12, color: _subtleText, height: 1.4),
        ),
        const SizedBox(height: 16),
        _AstTimelineStep(
          date: '02 Apr 2026',
          title: 'Grievance lodged',
          isCompleted: true,
          isActive: false,
          isLast: false,
          primary: primary,
        ),
        _AstTimelineStep(
          date: '05 Apr 2026',
          title: 'Assigned to grievance officer',
          isCompleted: assignedOrLater,
          isActive: !assignedOrLater,
          isLast: false,
          primary: primary,
        ),
        _AstTimelineStep(
          date: assignedOrLater ? '08 Apr 2026' : 'Est. 08 Apr 2026',
          title: 'Under review by officer',
          isCompleted: underReviewOrLater,
          isActive: assignedOrLater && !underReviewOrLater,
          isLast: false,
          primary: primary,
        ),
        _AstTimelineStep(
          date: escalatedOrLater ? '10 Apr 2026' : 'Est. 10 Apr 2026',
          title: 'Escalated to District Officer',
          isCompleted: isResolved,
          isActive: escalatedOrLater && !isResolved,
          isLast: false,
          primary: primary,
        ),
        _AstTimelineStep(
          date: isResolved ? '14 Apr 2026' : 'Est. 14 Apr 2026',
          title: 'Resolution issued',
          isCompleted: isResolved,
          isActive: false,
          isLast: true,
          primary: primary,
        ),
      ],
    );
  }
}

// ── Main phone mockup ────────────────────────────────────────────────────
class _GstMockup extends StatelessWidget {
  const _GstMockup({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final mt = Theme.of(context);
    final primary =
        mt.extension<Ux4gColors>()?.primary ?? mt.colorScheme.primary;
    final tagColor = _gstTagColor(status);
    final isReopened = status == 'Reopened';

    return _PhoneFrame(
      child: Column(
        children: [
          const _GstHeader(),
          Expanded(
            child: Container(
              color: _bg,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _GstInfoCard(
                            status: status,
                            tagColor: tagColor,
                            primary: primary,
                          ),
                          if (status == 'In Progress') const _GstDetailTable(),
                          if (status == 'Assigned') const _GstAssignedOfficer(),
                          if (status == 'Escalated') const _GstEscalationPath(),
                          if (status == 'Resolved')
                            const _GstResolutionSection(),
                          if (isReopened) _GstReopenForm(primary: primary),
                          // Journey only shows from Assigned onwards
                          if (!isReopened && status != 'In Progress')
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                16,
                                16,
                                16,
                              ),
                              child: _GstJourney(
                                status: status,
                                primary: primary,
                              ),
                            ),
                          const SizedBox(height: 16),
                        ],
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

// ── Code snippet ─────────────────────────────────────────────────────────
const _gstCode = r'''
// Grievance Status Tracker — mobile (360 × 760)
// status: 'In Progress' | 'Assigned' | 'Escalated' | 'Resolved' | 'Reopened'
Column(children: [
  Ux4gAppHeader(
    variant: Ux4gAppHeaderVariant.filled,   // purple header, white text
    title: 'Application Status',
    showBackButton: true,
    onBackPressed: () {},
    horizontalPadding: 16,
  ),
  Expanded(child: Container(
    color: Color(0xFFFAFAFA),
    child: SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Info card ────────────────────────────────────────────────
        Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Text('Delay in certificate issuance',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700))),
              SizedBox(width: 8),
              Ux4gTag(text: status, colorScheme: tagColor,
                style: Ux4gTagStyle.tonal, size: Ux4gTagSize.m),
            ]),
            SizedBox(height: 4),
            Text('Grievance ID · GRV-2026-MH-04127',
              style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
            SizedBox(height: 10),
            Ux4gLinearProgress(value: 0.55, label: '8 days left',
              gradientColors: [Colors.white, primaryColor],
              shape: Ux4gProgressShape.rounded, height: 6),
          ]),
        ),

        // ── State-specific content ────────────────────────────────────
        // In Progress  → Grievance details table
        // Assigned     → Assigned officer card
        // Escalated    → Escalation path (3 levels)
        // Resolved     → Green banner + satisfaction survey
        // Reopened     → Reopen complaint form

        // ── Grievance journey timeline ────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Ux4gJourneyTimeline(
            activeColor: primaryColor,
            header: Ux4gJourneyHeader(
              title: 'Grievance journey',
              description: 'Every update from lodging to resolution',
            ),
            steps: [
              Ux4gJourneyStep(state: Ux4gJourneyStepState.completed,
                date: '02 Apr 2026', title: 'Grievance lodged'),
              Ux4gJourneyStep(state: Ux4gJourneyStepState.current,
                date: '05 Apr 2026', title: 'Assigned to grievance officer'),
              Ux4gJourneyStep(state: Ux4gJourneyStepState.upcoming,
                date: 'Est. 08 Apr 2026', title: 'Under review by officer'),
              Ux4gJourneyStep(state: Ux4gJourneyStepState.upcoming,
                date: 'Est. 10 Apr 2026', title: 'Escalated to District Officer'),
              Ux4gJourneyStep(state: Ux4gJourneyStepState.upcoming,
                date: 'Est. 14 Apr 2026', title: 'Resolution issued'),
            ],
          ),
        ),
      ],
    )),
  )),
])
''';

// ── Widgetbook component ─────────────────────────────────────────────────
final grievanceStatusTrackerComponent = WidgetbookComponent(
  name: 'Grievance Status Tracker',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final status = context.knobs.list(
          label: 'Status',
          options: const [
            'In Progress',
            'Assigned',
            'Escalated',
            'Resolved',
            'Reopened',
          ],
          initialOption: 'In Progress',
          description: 'Switch between the 5 grievance lifecycle states.',
        );
        return ComponentDocs(
          name: 'Grievance Status Tracker',
          description:
              'Tracks the end-to-end lifecycle of a citizen grievance '
              'through five states: In Progress, Assigned, Escalated, '
              'Resolved, and Reopened. Features a filled purple header, '
              'Ux4gTag status badges, Ux4gLinearProgress SLA indicator, '
              'and Ux4gJourneyTimeline. Use the [Status] knob to preview '
              'each state. Mobile-sized layout (360 × 760).',
          code: _gstCode,
          center: true,
          child: _GstMockup(status: status),
        );
      },
    ),
  ],
);
