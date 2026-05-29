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
        // Powered by - Digital India footer pinned to the bottom.
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
    // Powered by - Digital India footer pinned to the bottom.
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
    // Powered by - Digital India footer pinned to the bottom.
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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
    // Powered by - Digital India footer pinned to the bottom.
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
    ),  ],
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

const _authIncorrectOtpCode = r'''// Mobile-sized OTP error screen (360 x 760)
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
        width: double.infinity,
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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

const _authOtpAttemptWarningCode =
    r'''// Mobile-sized OTP error screen with attempt-counter banner (360 x 760)
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
        width: double.infinity,
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
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// OTP error — attempt warning (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpAttemptWarningCardMockup extends StatelessWidget {
  const _AuthOtpAttemptWarningCardMockup();

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

const _authOtpAttemptWarningCardCode =
    r'''// Mobile-sized card-style OTP error screen with attempt-counter banner (360 x 760)
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

// ───────────────────────────────────────────────────────────────────────
// OTP error — last-attempt warning (Card-style variant)
// ───────────────────────────────────────────────────────────────────────
class _AuthOtpLastAttemptCardMockup extends StatelessWidget {
  const _AuthOtpLastAttemptCardMockup();

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

const _authOtpLastAttemptCode =
    r'''// Mobile-sized OTP error screen — final attempt before lockout (360 x 760)
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
        width: double.infinity,
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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

const _authOtpRetryUnlockedCode =
    r'''// Mobile-sized OTP retry screen after a lockout (360 x 760)
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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

const _authOtpSuspiciousActivityCode =
    r'''// Mobile-sized OTP step-up screen — suspicious activity (360 x 760)
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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
        SvgPicture.asset('assets/Union.svg', height: 32),
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
                  width: double.infinity,
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
                      width: double.infinity,
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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
                width: double.infinity,
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
          Image.asset('assets/digital_india_logo.png', height: 22),
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
              width: double.infinity,
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

  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
                      width: double.infinity,
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

const _aadhaarAccountLockedCode = r'''// Mobile-sized Aadhaar account-locked screen (360 x 760)
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
          width: double.infinity,
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
            Image.asset('assets/digital_india_logo.png', height: 22),
          ],
        ),
      ),
    ],
  ),
)''';

const _aadhaarAccountLockedCardCode = r'''// Mobile-sized card-style Aadhaar account-locked screen (360 x 760)
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
                  width: double.infinity,
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
                    Image.asset('assets/digital_india_logo.png', height: 22),
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
  State<_OperatorAssistedAuthMockup> createState() => _OperatorAssistedAuthMockupState();
}

class _OperatorAssistedAuthMockupState extends State<_OperatorAssistedAuthMockup> {
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
                  const SizedBox(height: 24),

                  // Consent Checkbox
                  Ux4gCheckbox(
                    value: _consent,
                    onChanged: (v) => setState(() => _consent = v ?? false),
                    isRequired: true,
                    label: 'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
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
  State<_OperatorAssistedAuthCardMockup> createState() => _OperatorAssistedAuthCardMockupState();
}

class _OperatorAssistedAuthCardMockupState extends State<_OperatorAssistedAuthCardMockup> {
  bool _consent = false;
  static const _cardBg = Color(0xFFE9E5FF);

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _BrandHeaderWithMenu(onMenuPressed: () {}),
          Expanded(
            child: Container(
              width: double.infinity,
              color: _cardBg,
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
                            onChanged: (v) => setState(() => _consent = v ?? false),
                            isRequired: true,
                            label: 'I consent to operator-assisted Aadhaar authentication. My identity documents have been verified by the VLE.',
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

const _operatorAssistedAuthCode = r'''// Mobile-sized Operator-assisted authentication (360 x 760)
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
            Image.asset('assets/digital_india_logo.png', height: 22),
          ],
        ),
      ),
    ],
  ),
)''';

const _operatorAssistedAuthCardCode = r'''// Mobile-sized card-style Operator-assisted authentication (360 x 760)
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
                    Image.asset('assets/digital_india_logo.png', height: 22),
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
