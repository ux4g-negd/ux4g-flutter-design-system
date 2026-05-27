import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import '../widgets/component_docs.dart';

// ── Asset paths (copied into example/assets/) ──────────────────────────
const _nationalEmblemPath = 'assets/national_amblam_logo.svg';
const _unionLogoPath = 'assets/Union.svg';
const _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

// ── SignIn pattern variants ─────────────────────────────────────────────

final signInDefaultComponent = WidgetbookComponent(
  name: 'Sign in to your account',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          name: 'Sign in to your account',
          description:
              'A government-grade sign-in pattern with username/password '
              'authentication and Aadhaar options. Mobile-sized layout (360px).',
          code: '''// Mobile-sized sign-in screen (360 x 760)
Container(
  width: 360,
  decoration: BoxDecoration(color: Colors.white),
  child: Column(
    children: [
      // ── Header using Ux4gAppHeader ──
      Ux4gAppHeader(
        variant: Ux4gAppHeaderVariant.light,
        title: '',
        leadingWidgets: [
          SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
          SvgPicture.asset('assets/Union.svg', height: 32),
        ],
        horizontalPadding: 16,
        leadingSpacing: 12,
      ),
      Divider(height: 1, color: Color(0xFFE5E7EB)),

      // ── Body ──
      Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign in to your account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            SizedBox(height: 4),
            Text('Access your government services securely',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
            SizedBox(height: 24),

            Ux4gInputField(
              value: username,
              onValueChange: (v) => setState(() => username = v),
              label: 'Username',
              placeholder: 'Enter your username',
              placeholderStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 16),

            Ux4gInputField(
              value: password,
              onValueChange: (v) => setState(() => password = v),
              label: 'Password',
              placeholder: '...........',
              placeholderStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              type: Ux4gInputFieldType.password,
            ),
            SizedBox(height: 16),

            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.errorLight,
              title: 'Username not found.',
              subtitle: 'Take action',
              leadingIcon: Icon(Icons.error_outline, color: Colors.red, size: 20),
              trailingIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Attempt 1 of 5',
                  style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 16),

            Ux4gButton(
              text: 'Send OTP',
              onPressed: () {},
              width: double.infinity,
            ),
            SizedBox(height: 12),

            Row(children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('OR'),
              ),
              Expanded(child: Divider()),
            ]),
            SizedBox(height: 12),

            Ux4gButton(
              text: 'Sign in with Aadhaar',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              width: double.infinity,
            ),
            SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('New user? Register here'),
              ),
            ),
            Spacer(),

            // Footer
            Center(child: Text('Powered by -',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)))),
            SizedBox(height: 6),
            Center(child: Image.asset('assets/digital_india_logo.png', height: 22)),
            SizedBox(height: 16),
          ],
        ),
      ),
    ],
  ),
)''',
          center: true,
          child: const _SignInMobileMockup(),
        );
      },
    ),
  ],
);

/// ─────────────────────────────────────────────────────────────────────
/// Mobile-sized mockup (360 x 760) — matches the reference design exactly.
/// Stateful so users can actually type into the inputs.
/// ─────────────────────────────────────────────────────────────────────
class _SignInMobileMockup extends StatefulWidget {
  const _SignInMobileMockup();

  @override
  State<_SignInMobileMockup> createState() => _SignInMobileMockupState();
}

class _SignInMobileMockupState extends State<_SignInMobileMockup> {
  String _username = '';
  String _password = '';

  // ── Colors from the reference design ──
  static const _bg = Color(0xFFFAFAFA);
  static const _border = Color(0xFFE5E7EB);
  static const _titleColor = Color(0xFF111827);
  static const _subtleText = Color(0xFF6B7280);
  static const _mutedText = Color(0xFF9CA3AF);

  // Placeholder style matching the reference design (14px regular, gray).
  static const _placeholderStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9CA3AF),
    height: 1.3,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // Phone frame
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
      child: Column(
        children: [
          // ═══════════════════════════════════════════════════════════
          // HEADER — Using Ux4gAppHeader component
          // ═══════════════════════════════════════════════════════════
          Ux4gAppHeader(
            variant: Ux4gAppHeaderVariant.light,
            title: '',
            leadingWidgets: [
              SvgPicture.asset(_nationalEmblemPath, height: 32),
              SvgPicture.asset(_unionLogoPath, height: 32),
            ],
            horizontalPadding: 16,
            leadingSpacing: 12,
          ),
          const Divider(height: 1, thickness: 1, color: _border),

          // ═══════════════════════════════════════════════════════════
          // BODY
          // ═══════════════════════════════════════════════════════════
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title ──
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

                  // ── Username ──
                  Ux4gInputField(
                    value: _username,
                    onValueChange: (v) => setState(() => _username = v),
                    label: 'Username',
                    placeholder: 'Enter your username',
                    placeholderStyle: _placeholderStyle,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ──
                  Ux4gInputField(
                    value: _password,
                    onValueChange: (v) => setState(() => _password = v),
                    label: 'Password',
                    placeholder: '...........',
                    placeholderStyle: _placeholderStyle,
                    type: Ux4gInputFieldType.password,
                  ),
                  const SizedBox(height: 16),

                  // ── Status Banner (inline custom container to match
                  // the reference design exactly; the shipped
                  // Ux4gStatusBanner has a hardcoded 16px outer margin
                  // that breaks alignment with the inputs above) ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.error_outline,
                            color: Color(0xFFDC2626),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Username not found.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF991B1B),
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Take action',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF991B1B),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Send OTP ──
                  Ux4gButton(
                    text: 'Send OTP',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),

                  // ── OR divider ──
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

                  // ── Sign in with Aadhaar ──
                  Ux4gButton(
                    text: 'Sign in with Aadhaar',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 28),

                  // ── Register link ──
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        'New user? Register here',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ═══════════════════════════════════════════════════════════
          // FOOTER
          // ═══════════════════════════════════════════════════════════
          Padding(
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
          ),
        ],
      ),
    );
  }
}
