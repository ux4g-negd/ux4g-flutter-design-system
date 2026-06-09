import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _greenColor = Color(0xFF16A34A);
const Color _errorColor = Color(0xFFDC2626);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final citizenProfileComponent = WidgetbookComponent(
  name: 'Citizen Profile',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Citizen Profile & Preferences',
          description:
              'A comprehensive profile pattern showing user identity, Aadhaar-linked info, '
              'personal details, linked accounts, notification preferences, and account deletion.',
          code: _citizenProfileCode,
          center: true,
          child: const _CitizenProfileMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _citizenProfileCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CitizenProfileScreen extends StatefulWidget {
  const CitizenProfileScreen({super.key});

  @override
  State<CitizenProfileScreen> createState() => _CitizenProfileScreenState();
}

class _CitizenProfileScreenState extends State<CitizenProfileScreen> {
  bool _smsEnabled = true;
  bool _emailEnabled = true;
  bool _appPushEnabled = true;
  bool _whatsAppEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
                const SizedBox(width: 8),
                const Text('Government of India', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
              ],
              actions: [
                Ux4gAppHeaderAction(icon: Icons.notifications_outlined, onPressed: () {}),
              ],
              showAvatar: true,
              avatarInitials: 'R',
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Profile & Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    const SizedBox(height: 20),

                    // Profile card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Ux4gProfileAvatar(
                            size: Ux4gAvatarSize.xl,
                            initials: 'RK',
                            variant: Ux4gProfileBadge.verified,
                          ),
                          const SizedBox(height: 12),
                          const Text('Ramesh Kumar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: Color(0xFF16A34A).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle, size: 14, color: Color(0xFF16A34A)),
                                    const SizedBox(width: 4),
                                    Text('Mobile verified', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF16A34A))),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: Color(0xFF16A34A).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle, size: 14, color: Color(0xFF16A34A)),
                                    const SizedBox(width: 4),
                                    Text('Aadhaar linked', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF16A34A))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: Ux4gButton(text: 'Edit profile', onPressed: () {}, variant: Ux4gButtonVariant.outline),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Aadhaar-linked Information
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Aadhaar-linked Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 4),
                          const Text('Fetched from UIDAI — update via the UIDAI portal.', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                          const SizedBox(height: 16),
                          Ux4gInputField(value: 'Ramesh Kumar', onValueChange: (_) {}, label: 'Full name', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Ux4gInputField(value: '15 Aug 1990', onValueChange: (_) {}, label: 'Date of birth', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Ux4gInputField(value: 'Male', onValueChange: (_) {}, label: 'Gender', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Ux4gInputField(value: 'XXXX XXXX 4127', onValueChange: (_) {}, label: 'Aadhaar number (UID)', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Text('Update via UIDAI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF432CBB))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Personal information
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Personal information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 16),
                          Ux4gInputField(value: 'ramesh.kumar@gmail.com', onValueChange: (_) {}, label: 'Email address', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Ux4gInputField(value: '+91 98765 43210', onValueChange: (_) {}, label: 'Mobile number', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                          const SizedBox(height: 12),
                          Ux4gInputField(value: 'English', onValueChange: (_) {}, label: 'Language preference', readOnly: true, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF111827))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Linked accounts
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Linked accounts', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 16),
                          // DigiLocker
                          Row(
                            children: [
                              const Text('DigiLocker', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                              const SizedBox(width: 8),
                              Icon(Icons.check_circle, size: 16, color: Color(0xFF16A34A)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Color(0xFF16A34A).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                                child: Text('Linked', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF16A34A))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text('Access and share your digital documents', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          const SizedBox(height: 4),
                          Text('View in DigiLocker', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF432CBB))),
                          const SizedBox(height: 20),
                          // UMANG App
                          Row(
                            children: [
                              const Text('UMANG App', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                              const SizedBox(width: 8),
                              Icon(Icons.warning_amber_rounded, size: 16, color: Color(0xFFFF9800)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Color(0xFFFF9800).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                                child: Text('Not linked', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFFFF9800))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text('Unified access to government services', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          const SizedBox(height: 8),
                          Ux4gButton(text: 'Connect', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small),
                          const SizedBox(height: 20),
                          // Bank account
                          const Text('Bank account for DBT', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                          const SizedBox(height: 4),
                          const Text('XXXXXX7842 · State Bank of India', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          const SizedBox(height: 4),
                          Text('Change', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF432CBB))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Notification preferences
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Notification preferences', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 16),
                          _ToggleRow(title: 'SMS', subtitle: 'Text message updates', value: _smsEnabled, onChanged: (v) => setState(() => _smsEnabled = v)),
                          const SizedBox(height: 16),
                          _ToggleRow(title: 'Email', subtitle: 'Email updates', value: _emailEnabled, onChanged: (v) => setState(() => _emailEnabled = v)),
                          const SizedBox(height: 16),
                          _ToggleRow(title: 'App push', subtitle: 'In-app alerts', value: _appPushEnabled, onChanged: (v) => setState(() => _appPushEnabled = v)),
                          const SizedBox(height: 16),
                          _ToggleRow(title: 'WhatsApp', subtitle: 'WhatsApp updates', value: _whatsAppEnabled, onChanged: (v) => setState(() => _whatsAppEnabled = v)),
                          const SizedBox(height: 16),
                          const Text('Notification frequency', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(border: Border.all(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Immediately', style: TextStyle(fontSize: 14, color: Color(0xFF111827))),
                                const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF4B5563)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Delete account
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFDC2626).withValues(alpha: 0.03),
                        border: Border.all(color: Color(0xFFDB372D)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Delete account', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 4),
                          const Text('Permanently delete your account and all data.\n30-day grace period to restore before it is final.', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: Ux4gButton(text: 'Delete my account', onPressed: () {}, variant: Ux4gButtonVariant.outline, borderColor: Color(0xFFDB372D), contentColor: Color(0xFFDB372D)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleRow({required this.title, required this.subtitle, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          ],
        ),
        Ux4gToggle(checked: value, onCheckedChange: onChanged),
      ],
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _CitizenProfileMockup extends StatefulWidget {
  const _CitizenProfileMockup();

  @override
  State<_CitizenProfileMockup> createState() => _CitizenProfileMockupState();
}

class _CitizenProfileMockupState extends State<_CitizenProfileMockup> {
  bool _smsEnabled = true;
  bool _emailEnabled = true;
  bool _appPushEnabled = true;
  bool _whatsAppEnabled = false;
  List<String> _selectedFrequency = ['immediately'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Ux4gAppHeader(
                      variant: Ux4gAppHeaderVariant.light,
                      title: '',
                      leadingWidgets: [
                        SvgPicture.asset(
                          _nationalEmblemLogoPath,
                          height: 36,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.account_balance,
                            size: 28,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          _unionLogoPath,
                          height: 28,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.blur_on,
                            size: 28,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Government of India',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _titleColor,
                          ),
                        ),
                      ],
                      actions: [
                        Ux4gAppHeaderAction(
                          icon: Icons.notifications_outlined,
                          onPressed: () {},
                        ),
                      ],
                      showAvatar: true,
                      avatar: const Ux4gStatusAvatar(
                        size: Ux4gAvatarSize.s,
                        initials: 'R',
                        variant: Ux4gStatusVariant.online,
                      ),
                    ),
                    const Ux4gDivider(),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Profile & Preferences',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Profile card
                      _buildProfileCard(),
                      const SizedBox(height: 16),

                      // Aadhaar-linked information
                      _buildAadhaarSection(),
                      const SizedBox(height: 16),

                      // Personal information
                      _buildPersonalInfoSection(),
                      const SizedBox(height: 16),

                      // Linked accounts
                      _buildLinkedAccountsSection(),
                      const SizedBox(height: 16),

                      // Notification preferences
                      _buildNotificationPreferences(),
                      const SizedBox(height: 16),

                      // Delete account
                      _buildDeleteAccountSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar with verified badge
            Ux4gProfileAvatar(
              size: Ux4gAvatarSize.xl,
              initials: 'RK',
              variant: Ux4gProfileBadge.verified,
            ),
            const SizedBox(height: 12),
            const Text(
              'Ramesh Kumar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 10),

            // Verification badges using Ux4gTag
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ux4gTag(
                  text: 'Mobile verified',
                  colorScheme: Ux4gTagColor.success,
                  style: Ux4gTagStyle.tonal,
                  leadingContent: Icon(
                    Icons.check_circle,
                    size: 14,
                    color: _greenColor,
                  ),
                ),
                const SizedBox(width: 8),
                Ux4gTag(
                  text: 'Aadhaar linked',
                  colorScheme: Ux4gTagColor.success,
                  style: Ux4gTagStyle.tonal,
                  leadingContent: Icon(
                    Icons.check_circle,
                    size: 14,
                    color: _greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Edit profile button
            SizedBox(
              width: double.infinity,
              child: Ux4gButton(
                text: 'Edit profile',
                onPressed: () {},
                variant: Ux4gButtonVariant.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAadhaarSection() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aadhaar-linked Information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Fetched from UIDAI — update via the UIDAI portal.',
              style: TextStyle(fontSize: 13, color: _subtleText),
            ),
            const SizedBox(height: 16),

            Ux4gInputField(
              value: 'Ramesh Kumar',
              onValueChange: (_) {},
              label: 'Full name',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),
            Ux4gInputField(
              value: '15 Aug 1990',
              onValueChange: (_) {},
              label: 'Date of birth',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),
            Ux4gInputField(
              value: 'Male',
              onValueChange: (_) {},
              label: 'Gender',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),
            Ux4gInputField(
              value: 'XXXX XXXX 4127',
              onValueChange: (_) {},
              label: 'Aadhaar number (UID)',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              'Update via UIDAI',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 16),

            Ux4gInputField(
              value: 'ramesh.kumar@gmail.com',
              onValueChange: (_) {},
              label: 'Email address',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),
            Ux4gInputField(
              value: '+91 98765 43210',
              onValueChange: (_) {},
              label: 'Mobile number',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 12),
            Ux4gInputField(
              value: 'English',
              onValueChange: (_) {},
              label: 'Language preference',
              readOnly: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedAccountsSection() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Linked accounts',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 16),

            // DigiLocker
            Row(
              children: [
                const Text(
                  'DigiLocker',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _titleColor,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.check_circle, size: 16, color: _greenColor),
                const SizedBox(width: 4),
                Ux4gTag(
                  text: 'Linked',
                  colorScheme: Ux4gTagColor.success,
                  style: Ux4gTagStyle.tonal,
                  size: Ux4gTagSize.m,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Access and share your digital documents',
              style: TextStyle(fontSize: 12, color: _subtleText),
            ),
            const SizedBox(height: 4),
            Text(
              'View in DigiLocker',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _primaryColor,
              ),
            ),
            const SizedBox(height: 20),

            // UMANG App
            Row(
              children: [
                const Text(
                  'UMANG App',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _titleColor,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Ux4gPalette.orange500,
                ),
                const SizedBox(width: 4),
                Ux4gTag(
                  text: 'Not linked',
                  colorScheme: Ux4gTagColor.warning,
                  style: Ux4gTagStyle.tonal,
                  size: Ux4gTagSize.m,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Unified access to government services',
              style: TextStyle(fontSize: 12, color: _subtleText),
            ),
            const SizedBox(height: 8),
            Ux4gButton(
              text: 'Connect',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.small,
            ),
            const SizedBox(height: 20),

            // Bank account
            const Text(
              'Bank account for DBT',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'XXXXXX7842 · State Bank of India',
              style: TextStyle(fontSize: 12, color: _subtleText),
            ),
            const SizedBox(height: 4),
            Text(
              'Change',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationPreferences() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification preferences',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 16),

            _buildNotifToggleRow(
              'SMS',
              'Text message updates',
              _smsEnabled,
              (v) => setState(() => _smsEnabled = v),
            ),
            const SizedBox(height: 16),
            _buildNotifToggleRow(
              'Email',
              'Email updates',
              _emailEnabled,
              (v) => setState(() => _emailEnabled = v),
            ),
            const SizedBox(height: 16),
            _buildNotifToggleRow(
              'App push',
              'In-app alerts',
              _appPushEnabled,
              (v) => setState(() => _appPushEnabled = v),
            ),
            const SizedBox(height: 16),
            _buildNotifToggleRow(
              'WhatsApp',
              'WhatsApp updates',
              _whatsAppEnabled,
              (v) => setState(() => _whatsAppEnabled = v),
            ),
            const SizedBox(height: 16),

            Ux4gSelectionDropdown(
              options: const [
                Ux4gDropdownOption(id: 'immediately', label: 'Immediately'),
                Ux4gDropdownOption(id: 'daily', label: 'Daily'),
                Ux4gDropdownOption(id: 'weekly', label: 'Weekly'),
              ],
              selectedOptionIds: _selectedFrequency,
              onSelectionChange: (v) => setState(() => _selectedFrequency = v),
              label: 'Notification frequency',
              mode: Ux4gDropdownMode.single,
              labelTextStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: _subtleText,
              ),
              valueTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccountSection() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: const Color(0xFFDB372D),
      borderWidth: 1,
      backgroundColor: _errorColor.withValues(alpha: 0.03),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delete account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Permanently delete your account and all data.\n30-day grace period to restore before it is final.',
              style: TextStyle(fontSize: 12, color: _subtleText),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Ux4gButton(
                text: 'Delete my account',
                onPressed: () {},
                variant: Ux4gButtonVariant.outline,
                borderColor: const Color(0xFFDB372D),
                contentColor: const Color(0xFFDB372D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifToggleRow(
    String label,
    String description,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _subtleText),
              ),
            ],
          ),
        ),
        Ux4gToggle(
          checked: value,
          onCheckedChange: onChanged,
          size: Ux4gToggleSize.s,
        ),
      ],
    );
  }
}
