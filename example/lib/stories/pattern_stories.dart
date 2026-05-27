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
const _titleColor = Color(0xFF111827);
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 1 of 5',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF991B1B),
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
  static const _successDark = Color(0xFF065F46);
  static const _successMid = Color(0xFF059669);
  static const _successLight = Color(0xFFD1FAE5);

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
                color: Color(0xFF991B1B),
              ),
              subtitleStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: Color(0xFF991B1B),
              ),
              leadingIcon: Icon(Icons.error_outline,
                color: Color(0xFFDC2626), size: 20),
              trailingIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Attempt 1 of 5',
                  style: TextStyle(fontSize: 12,
                    color: Color(0xFF991B1B),
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
            decoration: BoxDecoration(color: Color(0xFFD1FAE5), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle),
              child: Icon(Icons.check, color: Colors.white, size: 22),
            ),
          ),
          SizedBox(height: 24),

          Text('Signed in successfully!',
            style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800,
              color: Color(0xFF065F46),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Attempt 1 of 5',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF991B1B),
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
              color: Color(0xFF991B1B),
            ),
            subtitleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: Color(0xFF991B1B),
            ),
            leadingIcon: Icon(Icons.error_outline,
              color: Color(0xFFDC2626), size: 20),
            trailingIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Attempt 1 of 5',
                style: TextStyle(fontSize: 12,
                  color: Color(0xFF991B1B),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Attempt 1 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF991B1B),
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
                          color: Color(0xFFDC2626), size: 20),
                        trailingIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Attempt 1 of 5',
                            style: TextStyle(fontSize: 12,
                              color: Color(0xFF991B1B),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Attempt 1 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF991B1B),
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
                          color: Color(0xFFDC2626), size: 20),
                        trailingIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Attempt 1 of 5',
                            style: TextStyle(fontSize: 12,
                              color: Color(0xFF991B1B),
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
  static const _successMid = Color(0xFF059669);
  static const _successLight = Color(0xFFD1FAE5);
  static const _successDark = Color(0xFF065F46);

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
                        color: Color(0xFFD1FAE5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Color(0xFF059669),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 22),
                      ),
                    ),
                    SizedBox(height: 24),

                    Text('Signed in successfully!',
                      style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w800,
                        color: Color(0xFF065F46),
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
