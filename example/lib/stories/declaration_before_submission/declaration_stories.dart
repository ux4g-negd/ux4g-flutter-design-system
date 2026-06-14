import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import '../../widgets/component_docs.dart';

// ── Asset paths (referenced from example/assets/) ───────────────────────
const _nationalEmblemPath = 'assets/national_amblam_logo.svg';
const _unionLogoPath = 'assets/Union.svg';
const _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

// ── Shared design tokens ───────────────────────────────────────────────



final declarationBeforeSubmissionComponent = WidgetbookComponent(
  name: 'Declaration Before Submission',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
        );

        final code = variant == 'Card style'
            ? _declarationBeforeSubmissionCardCode
            : _declarationBeforeSubmissionCode;
        final child = variant == 'Card style'
            ? const _DeclarationBeforeSubmissionCardMockup()
            : const _DeclarationBeforeSubmissionMockup();

        return ComponentDocs(
          name: 'Declaration Before Submission',
          description:
              'A screen pattern for a formal declaration before application submission. '
              'Features a scrollable declaration box that must be read before agreeing. '
              'Use the [Variant] knob on the right to toggle layouts.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

final declarationWithDigitalSignComponent = WidgetbookComponent(
  name: 'Declaration with Digital Sign',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
        );
        final state = context.knobs.list(
          label: 'State',
          options: const ['Unsigned', 'Signed'],
          initialOption: 'Unsigned',
        );

        final code = variant == 'Card style'
            ? _declarationWithDigitalSignCardCode
            : _declarationWithDigitalSignCode;
        final child = variant == 'Card style'
            ? _DeclarationWithDigitalSignCardMockup(initialState: state)
            : _DeclarationWithDigitalSignMockup(initialState: state);

        return ComponentDocs(
          name: 'Declaration with Digital Sign',
          description:
              'A formal declaration pattern where the user must agree and then sign by typing their name. '
              'The signature is validated before the application can be submitted. '
              'Use the [Variant] knob to toggle between Default and Card style layouts.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

class _DeclarationBeforeSubmissionMockup extends StatefulWidget {
  const _DeclarationBeforeSubmissionMockup();

  @override
  State<_DeclarationBeforeSubmissionMockup> createState() =>
      _DeclarationBeforeSubmissionMockupState();
}

class _DeclarationBeforeSubmissionMockupState
    extends State<_DeclarationBeforeSubmissionMockup> {
  bool _agreed = false;
  final ScrollController _scrollController = ScrollController();
  bool _reachedEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 10) {
        if (!_reachedEnd) {
          setState(() {
            _reachedEnd = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Declaration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Read the declaration in full. Scroll to the end before you can agree.',
                    style: TextStyle(
                      fontSize: 14,
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 220,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                    ),
                    child: Stack(
                      children: [
                        Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Text(
                                'I, the applicant, do hereby solemnly declare and affirm that:\n\n'
                                '1. All information furnished in this application is true, complete and correct to the best of my knowledge and belief.\n\n'
                                '2. I have not concealed, suppressed or misrepresented any material fact.\n\n'
                                '3. I am aware that any false information or suppression of material facts will lead to rejection of my application or termination of service if already granted.\n\n'
                                '4. I undertake to inform the department immediately of any changes in the information provided in this application.\n\n'
                                '5. I understand that the data provided by me will be used for the purpose of processing this application and related government services.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!_reachedEnd)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(
                                      0xFFF9FAFB,
                                    ).withValues(alpha: 0),
                                    (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Scroll to read all',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreed,
                          activeColor: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600),
                          onChanged: _reachedEnd
                              ? (val) {
                                  setState(() {
                                    _agreed = val ?? false;
                                  });
                                }
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'I have read and agree to the above declaration.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.error,
                            color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600),
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Ux4gButton(
                    text: 'Submit application',
                    onPressed: _agreed ? () {} : null,
                    width: double.infinity,
                    variant: Ux4gButtonVariant.primary,
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
                Text(
                  'Powered by -',
                  style: TextStyle(
                    fontSize: 11,
                    color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeclarationBeforeSubmissionCardMockup extends StatefulWidget {
  const _DeclarationBeforeSubmissionCardMockup();

  @override
  State<_DeclarationBeforeSubmissionCardMockup> createState() =>
      _DeclarationBeforeSubmissionCardMockupState();
}

class _DeclarationBeforeSubmissionCardMockupState
    extends State<_DeclarationBeforeSubmissionCardMockup> {
  bool _agreed = false;
  final ScrollController _scrollController = ScrollController();
  bool _reachedEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 10) {
        if (!_reachedEnd) {
          setState(() {
            _reachedEnd = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
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
                            Text(
                              'Declaration',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Read the declaration in full. Scroll to the end before you can agree.',
                              style: TextStyle(
                                fontSize: 14,
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Scrollbar(
                                    controller: _scrollController,
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: Text(
                                          'I, the applicant, do hereby solemnly declare and affirm that:\n\n'
                                          '1. All information furnished in this application is true, complete and correct to the best of my knowledge and belief.\n\n'
                                          '2. I have not concealed, suppressed or misrepresented any material fact.\n\n'
                                          '3. I am aware that any false information or suppression of material facts will lead to rejection of my application or termination of service if already granted.\n\n'
                                          '4. I undertake to inform the department immediately of any changes in the information provided in this application.\n\n'
                                          '5. I understand that the data provided by me will be used for the purpose of processing this application and related government services.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                                            height: 1.6,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!_reachedEnd)
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              const Color(
                                                0xFFF9FAFB,
                                              ).withValues(alpha: 0),
                                              (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Scroll to read all',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: _agreed,
                                    activeColor: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600),
                                    onChanged: _reachedEnd
                                        ? (val) {
                                            setState(() {
                                              _agreed = val ?? false;
                                            });
                                          }
                                        : null,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'I have read and agree to the above declaration.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                            height: 1.4,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.error,
                                      color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600),
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800),
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            Ux4gButton(
                              text: 'Submit application',
                              onPressed: _agreed ? () {} : null,
                              width: double.infinity,
                              variant: Ux4gButtonVariant.primary,
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
                        Text(
                          'Powered by -',
                          style: TextStyle(
                            fontSize: 11,
                            color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
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
    );
  }
}

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
        color: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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

class _ConsentHeader extends StatelessWidget {
  _ConsentHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ux4gAppHeader(
          variant: Ux4gAppHeaderVariant.light,
          title: '',
          leadingWidgets: [
            SvgPicture.asset(
              _nationalEmblemPath,
              height: 32,
              colorFilter: _isDark(context)
                  ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
            Container(width: 1, height: 28, color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
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
          actions: [
            Ux4gAppHeaderAction(
              customWidget: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
          horizontalPadding: 16,
          leadingSpacing: 12,
        ),
        Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
      ],
    );
  }
}

class _DeclarationWithDigitalSignMockup extends StatefulWidget {
  final String initialState;
  const _DeclarationWithDigitalSignMockup({required this.initialState});

  @override
  State<_DeclarationWithDigitalSignMockup> createState() =>
      _DeclarationWithDigitalSignMockupState();
}

class _DeclarationWithDigitalSignMockupState
    extends State<_DeclarationWithDigitalSignMockup> {
  late bool _agreed;
  late TextEditingController _nameController;
  late bool _isSigned;

  @override
  void initState() {
    super.initState();
    _isSigned = widget.initialState == 'Signed';
    _agreed = _isSigned;
    _nameController = TextEditingController(
      text: _isSigned ? 'Ramesh Kumar' : '',
    );
  }

  @override
  void didUpdateWidget(_DeclarationWithDigitalSignMockup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _isSigned = widget.initialState == 'Signed';
        _agreed = _isSigned;
        _nameController.text = _isSigned ? 'Ramesh Kumar' : '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Declaration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    _isSigned
                        ? 'Declaration agreed and signed. Your application is ready to submit.'
                        : 'You have agreed. Now sign by typing your full name as per Aadhaar.',
                    style: TextStyle(
                      fontSize: 14,
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '4. I authorise the Revenue Department to verify these particulars from any source.\n\n'
                        '5. I am aware that furnishing false information is a punishable offence.\n\n'
                        '6. If any information is later found false, the certificate is liable to be cancelled and legal action may be taken.\n\n'
                        'I make this declaration believing the contents to be true.',
                        style: TextStyle(
                          fontSize: 14,
                          color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreed,
                          activeColor: (_isDark(context) ? Ux4gPalette.primary200 : Ux4gPalette.primary800),
                          onChanged: (val) {
                            setState(() {
                              _agreed = val ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'I have read and agree to the above declaration.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Enter your full name to attest this declaration',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: TextField(
                      controller: _nameController,
                      onChanged: (val) {
                        setState(() {
                          _isSigned = val.trim().split(' ').length >= 2;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400)),
                        border: InputBorder.none,
                        suffixIcon: _isSigned
                            ? Icon(
                                Icons.check_circle,
                                color: (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
                                size: 20,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your name will be matched against your aadhaar records.',
                          style: TextStyle(
                            fontSize: 13,
                            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.error,
                            color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600),
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Ux4gButton(
                    text: 'Submit application',
                    onPressed: (_agreed && _isSigned) ? () {} : null,
                    width: double.infinity,
                    variant: Ux4gButtonVariant.primary,
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
                Text(
                  'Powered by -',
                  style: TextStyle(
                    fontSize: 11,
                    color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeclarationWithDigitalSignCardMockup extends StatefulWidget {
  final String initialState;
  const _DeclarationWithDigitalSignCardMockup({required this.initialState});

  @override
  State<_DeclarationWithDigitalSignCardMockup> createState() =>
      _DeclarationWithDigitalSignCardMockupState();
}

class _DeclarationWithDigitalSignCardMockupState
    extends State<_DeclarationWithDigitalSignCardMockup> {
  late bool _agreed;
  late TextEditingController _nameController;
  late bool _isSigned;

  @override
  void initState() {
    super.initState();
    _isSigned = widget.initialState == 'Signed';
    _agreed = _isSigned;
    _nameController = TextEditingController(
      text: _isSigned ? 'Ramesh Kumar' : '',
    );
  }

  @override
  void didUpdateWidget(_DeclarationWithDigitalSignCardMockup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _isSigned = widget.initialState == 'Signed';
        _agreed = _isSigned;
        _nameController.text = _isSigned ? 'Ramesh Kumar' : '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
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
                            Text(
                              'Declaration',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              _isSigned
                                  ? 'Declaration agreed and signed. Your application is ready to submit.'
                                  : 'You have agreed. Now sign by typing your full name as per Aadhaar.',
                              style: TextStyle(
                                fontSize: 14,
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              height: 150,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  '4. I authorise the Revenue Department to verify these particulars from any source.\n\n'
                                  '5. I am aware that furnishing false information is a punishable offence.\n\n'
                                  '6. If any information is later found false, the certificate is liable to be cancelled and legal action may be taken.\n\n'
                                  'I make this declaration believing the contents to be true.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                                    height: 1.6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: _agreed,
                                    activeColor: (_isDark(context) ? Ux4gPalette.primary200 : Ux4gPalette.primary800),
                                    onChanged: (val) {
                                      setState(() {
                                        _agreed = val ?? false;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'I have read and agree to the above declaration.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                            height: 1.4,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Enter your full name to attest this declaration',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                controller: _nameController,
                                onChanged: (val) {
                                  setState(() {
                                    _isSigned =
                                        val.trim().split(' ').length >= 2;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter your full name',
                                  hintStyle: TextStyle(
                                    color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: _isSigned
                                      ? Icon(
                                          Icons.check_circle,
                                          color: (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
                                          size: 20,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Your name will be matched against your aadhaar records.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.error,
                                      color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600),
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800),
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            Ux4gButton(
                              text: 'Submit application',
                              onPressed: (_agreed && _isSigned) ? () {} : null,
                              width: double.infinity,
                              variant: Ux4gButtonVariant.primary,
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
                        Text(
                          'Powered by -',
                          style: TextStyle(
                            fontSize: 11,
                            color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
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
    );
  }
}

const _declarationWithDigitalSignCode =
    r'''// Declaration with Digital Sign Pattern
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),

    // Scrollable Content
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Declaration',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900), letterSpacing: -0.5),
            ),
            SizedBox(height: 12),
            Text(
              'Declaration agreed and signed. Your application is ready to submit.',
              style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600), height: 1.5),
            ),
            SizedBox(height: 24),

            // Declaration Text
            Container(
              height: 150,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              ),
              child: SingleChildScrollView(
                child: Text(
                  '4. I authorise the Revenue Department to verify these particulars from any source.\n\n'
                  '5. I am aware that furnishing false information is a punishable offence.\n\n'
                  '6. If any information is later found false, the certificate is liable to be cancelled and legal action may be taken.\n\n'
                  'I make this declaration believing the contents to be true.',
                  style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700), height: 1.6, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Agreement Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(value: true, onChanged: (val) {}, activeColor: (_isDark(context) ? Ux4gPalette.primary200 : Ux4gPalette.primary800)),
                SizedBox(width: 12),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'I have read and agree to the above declaration.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900))),
                        TextSpan(text: ' *', style: TextStyle(color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700), fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Signature Input
            Text('Enter your full name to attest this declaration', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700))),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300))),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: TextField(
                controller: TextEditingController(text: 'Ramesh Kumar'),
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.check_circle, color: (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700), size: 20),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500)),
                SizedBox(width: 8),
                Text('Your name will be matched against your aadhaar records.', style: TextStyle(fontSize: 13, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500))),
              ],
            ),
            SizedBox(height: 24),

            // Warning Notice
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error, color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600), size: 18),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                      style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800), height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Submit Button
            const Ux4gButton(
              text: 'Submit application',
              onPressed: null, // Enable when agreed and signed
              width: double.infinity,
              variant: Ux4gButtonVariant.primary,
            ),
          ],
        ),
      ),
    ),

    // Footer Logo
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Powered by -', style: TextStyle(fontSize: 11, color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400), fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _declarationWithDigitalSignCardCode =
    r'''// Declaration with Digital Sign – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),

    Expanded(
      child: Container(
        color: (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100), // Soft purple background
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
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
                      Text(
                        'Declaration',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900), letterSpacing: -0.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Declaration agreed and signed. Your application is ready to submit.',
                        style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600), height: 1.5),
                      ),
                      SizedBox(height: 24),

                      // Declaration Text
                      Container(
                        height: 150,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            '4. I authorise the Revenue Department to verify these particulars from any source.\n\n'
                            '5. I am aware that furnishing false information is a punishable offence.\n\n'
                            '6. If any information is later found false, the certificate is liable to be cancelled and legal action may be taken.\n\n'
                            'I make this declaration believing the contents to be true.',
                            style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700), height: 1.6, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Agreement Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(value: true, onChanged: (val) {}, activeColor: (_isDark(context) ? Ux4gPalette.primary200 : Ux4gPalette.primary800)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'I have read and agree to the above declaration.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900))),
                                  TextSpan(text: ' *', style: TextStyle(color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700), fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Signature Input
                      Text('Enter your full name to attest this declaration', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700))),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300))),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: TextField(
                          controller: TextEditingController(text: 'Ramesh Kumar'),
                          decoration: const InputDecoration(
                            hintText: 'Enter your full name',
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.check_circle, color: (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700), size: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500)),
                          SizedBox(width: 8),
                          Text('Your name will be matched against your aadhaar records.', style: TextStyle(fontSize: 13, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500))),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Warning Notice
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error, color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600), size: 18),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                                style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800), height: 1.5, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),

                      // Submit Button
                      Ux4gButton(
                        text: 'Submit application',
                        onPressed: null, // Enable when agreed and signed
                        width: double.infinity,
                        variant: Ux4gButtonVariant.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Powered by
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400), fontWeight: FontWeight.w500)),
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

const _declarationBeforeSubmissionCode =
    r'''// Declaration Before Submission Screen Pattern
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),

    // Scrollable Content
    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Declaration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Read the declaration in full. Scroll to the end before you can agree.',
              style: TextStyle(
                fontSize: 14,
                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            // Declaration Box
            Container(
              height: 220,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              ),
              child: const Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Text(
                      'I, the applicant, do hereby solemnly declare and affirm that:\n\n'
                      '1. All information furnished in this application is true, complete and correct to the best of my knowledge and belief.\n\n'
                      '2. I have not concealed, suppressed or misrepresented any material fact.\n\n'
                      '3. I am aware that any false information or suppression of material facts will lead to rejection of my application or termination of service if already granted.\n\n'
                      '4. I undertake to inform the department immediately of any changes in the information provided in this application.\n\n'
                      '5. I understand that the data provided by me will be used for the purpose of processing this application and related government services.',
                      style: TextStyle(
                        fontSize: 14,
                        color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Agreement Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: false,
                    activeColor: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600),
                    onChanged: (val) {},
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and agree to the above declaration.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Warning Notice
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.error, color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600), size: 18),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                      style: TextStyle(
                        fontSize: 14,
                        color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800),
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Submit Button
            Ux4gButton(
              text: 'Submit application',
              onPressed: null, // Disabled until agreed
              width: double.infinity,
              variant: Ux4gButtonVariant.primary,
            ),
          ],
        ),
      ),
    ),

    // Footer Logo
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(fontSize: 11, color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _declarationBeforeSubmissionCardCode =
    r'''// Declaration – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),

    Expanded(
      child: Container(
        color: (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100), // Soft purple background
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray800 : Colors.white,
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
                      Text(
                        'Declaration',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900), letterSpacing: -0.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Read the declaration in full. Scroll to the end before you can agree.',
                        style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600), height: 1.5),
                      ),
                      SizedBox(height: 24),

                      // Declaration Scrollable Box
                      Container(
                        height: 200,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                        ),
                        child: const Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Text(
                                'I, the applicant, do hereby solemnly declare and affirm that:\n\n'
                                '1. All information furnished in this application is true, complete and correct...\n\n'
                                '2. I have not concealed, suppressed or misrepresented any material fact.\n\n'
                                '3. I am aware that any false information... will lead to rejection of my application.',
                                style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700), height: 1.6, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Agreement Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(value: false, onChanged: (val) {}, activeColor: (_isDark(context) ? Ux4gPalette.primary400 : Ux4gPalette.primary600)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'I have read and agree to the above declaration.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900))),
                                  TextSpan(text: ' *', style: TextStyle(color: (_isDark(context) ? Ux4gPalette.red400 : Ux4gPalette.red700), fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Warning Banner
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (_isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: (_isDark(context) ? Ux4gPalette.orange800 : Ux4gPalette.orange100)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error, color: (_isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600), size: 18),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Furnishing false information is a punishable offence under Section 193 IPC — up to 7 years imprisonment.',
                                style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800), height: 1.5, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),

                      // Submit Button
                      Ux4gButton(
                        text: 'Submit application',
                        onPressed: null, // Disabled until agreed
                        width: double.infinity,
                        variant: Ux4gButtonVariant.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Powered by
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400), fontWeight: FontWeight.w500)),
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


bool _isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
