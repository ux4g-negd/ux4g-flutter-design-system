import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);

final selectAppointmentTimeComponent = WidgetbookComponent(
  name: 'Select Appointment Time',
  useCases: [
    WidgetbookUseCase(
      name: 'Expanded View',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Select Appointment Time (Expanded)',
          description:
              'Appointment time selection pattern using Ux4gSlotGrid calendar. '
              'Tapping a date opens the time-slot bottom sheet in expanded (vertical list) view. '
              'Shows date statuses: available, no slots, public holiday, weekly off.',
          code: _selectAppointmentTimeExpandedCode,
          center: true,
          child: const _SelectAppointmentTimeMockup(
            viewMode: SlotPickerViewMode.expanded,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Compact View',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Select Appointment Time (Compact)',
          description:
              'Appointment time selection pattern using Ux4gSlotGrid calendar. '
              'Tapping a date opens the time-slot bottom sheet in compact (2-column grid) view. '
              'Shows date statuses: available, no slots, public holiday, weekly off.',
          code: _selectAppointmentTimeCompactCode,
          center: true,
          child: const _SelectAppointmentTimeMockup(
            viewMode: SlotPickerViewMode.compact,
          ),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Expanded View
// ───────────────────────────────────────────────────────────────────────

const _selectAppointmentTimeExpandedCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class SelectAppointmentTimeScreen extends StatefulWidget {
  const SelectAppointmentTimeScreen({super.key});

  @override
  State<SelectAppointmentTimeScreen> createState() => _SelectAppointmentTimeScreenState();
}

class _SelectAppointmentTimeScreenState extends State<SelectAppointmentTimeScreen> {
  DateTime? _selectedDate;
  SlotTimeEntry? _selectedSlot;
  SlotPickerViewMode _viewMode = SlotPickerViewMode.expanded;
  late SlotGridData _data;
  Map<String, List<Map<String, dynamic>>> _mutableTimeSlots = {};

  Map<String, dynamic> _getJsonInput() {
    final now = DateTime.now();
    return {
      "year": now.year,
      "month": now.month,
      "today": '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      "weeklyOffWeekdays": [6, 7],
      "allowTapOnPublicHoliday": false,
      "allowTapOnWeeklyOff": false,
      "viewMode": "expanded",
      "dates": [
        {"date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${(now.day + 2).toString().padLeft(2, '0')}', "status": "publicHoliday"},
        {"date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${(now.day + 4).toString().padLeft(2, '0')}', "status": "noSlots"},
      ],
      "timeSlots": {
        "default": [
          {"time": "9:00 AM", "slotCount": 4, "status": "available"},
          {"time": "9:30 AM", "slotCount": 6, "status": "available"},
          {"time": "10:00 AM", "slotCount": 3, "status": "available"},
          {"time": "10:30 AM", "slotCount": 0, "status": "noSlots"},
          {"time": "11:00 AM", "slotCount": 8, "status": "available"},
          {"time": "11:30 AM", "slotCount": 5, "status": "available"},
          {"time": "2:00 PM", "slotCount": 5, "status": "available"},
          {"time": "2:30 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:00 PM", "slotCount": 1, "status": "limited"},
        ]
      }
    };
  }

  @override
  void initState() {
    super.initState();
    _mutableTimeSlots = _buildMutableSlots();
    _data = SlotGridData.fromJson(_getJsonInput());
  }

  Map<String, List<Map<String, dynamic>>> _buildMutableSlots() {
    final json = _getJsonInput();
    final raw = json['timeSlots'] as Map<String, dynamic>;
    return raw.map((key, value) => MapEntry(
          key,
          (value as List).map((e) => Map<String, dynamic>.from(e as Map)).toList(),
        ));
  }

  List<SlotTimeEntry> _timeSlotsFor(DateTime date) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (!_mutableTimeSlots.containsKey(dateStr)) {
      final defaultSlots = _mutableTimeSlots['default'] ?? [];
      _mutableTimeSlots[dateStr] = defaultSlots.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return _mutableTimeSlots[dateStr]!.map((e) => SlotTimeEntry.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text('Select appointment time', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('Adv. M. Sharma · 30-minute slot', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Appointment date & time label
                    Text('Appointment date & time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    // Tap to pick date & time dropdown trigger
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDate != null && _selectedSlot != null
                                  ? '${_formatDate(_selectedDate!)} · ${_selectedSlot!.time}'
                                  : 'Tap to pick date & time',
                              style: TextStyle(fontSize: 14, color: _selectedDate != null ? Color(0xFF111827) : Color(0xFF9CA3AF)),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // SlotGrid calendar with expanded view bottom sheet
                    SlotGrid(
                      data: _data,
                      timeSlotProvider: _timeSlotsFor,
                      onSlotConfirmed: (date, slot) {
                        setState(() {
                          _selectedDate = date;
                          _selectedSlot = slot;
                        });
                      },
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                          _data = SlotGridData.fromJson({
                            ..._getJsonInput(),
                            'selectedDate': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                            'year': _data.year,
                            'month': _data.month,
                          });
                        });
                      },
                      onMonthChanged: (year, month) {
                        setState(() {
                          _data = SlotGridData.fromJson({
                            ..._getJsonInput(),
                            'year': year,
                            'month': month,
                          });
                        });
                      },
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

  String _formatDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Compact View
// ───────────────────────────────────────────────────────────────────────

const _selectAppointmentTimeCompactCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Same as expanded view but with viewMode set to "compact".
/// The bottom sheet shows time slots in a 2-column grid layout.
///
/// Key difference:
///   "viewMode": "compact"  → compact 2-col grid in bottom sheet
///   "viewMode": "expanded" → vertical list in bottom sheet

class SelectAppointmentTimeCompactScreen extends StatefulWidget {
  const SelectAppointmentTimeCompactScreen({super.key});

  @override
  State<SelectAppointmentTimeCompactScreen> createState() => _SelectAppointmentTimeCompactScreenState();
}

class _SelectAppointmentTimeCompactScreenState extends State<SelectAppointmentTimeCompactScreen> {
  DateTime? _selectedDate;
  SlotTimeEntry? _selectedSlot;
  late SlotGridData _data;
  Map<String, List<Map<String, dynamic>>> _mutableTimeSlots = {};

  Map<String, dynamic> _getJsonInput() {
    final now = DateTime.now();
    return {
      "year": now.year,
      "month": now.month,
      "today": '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      "weeklyOffWeekdays": [6, 7],
      "allowTapOnPublicHoliday": false,
      "allowTapOnWeeklyOff": false,
      "viewMode": "compact",  // ← compact view for 2-column grid bottom sheet
      "dates": [
        {"date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${(now.day + 2).toString().padLeft(2, '0')}', "status": "publicHoliday"},
        {"date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${(now.day + 4).toString().padLeft(2, '0')}', "status": "noSlots"},
      ],
      "timeSlots": {
        "default": [
          {"time": "9:00 AM", "slotCount": 4, "status": "available"},
          {"time": "9:30 AM", "slotCount": 6, "status": "available"},
          {"time": "10:00 AM", "slotCount": 3, "status": "available"},
          {"time": "10:30 AM", "slotCount": 0, "status": "noSlots"},
          {"time": "11:00 AM", "slotCount": 8, "status": "available"},
          {"time": "11:30 AM", "slotCount": 5, "status": "available"},
          {"time": "2:00 PM", "slotCount": 5, "status": "available"},
          {"time": "2:30 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:00 PM", "slotCount": 1, "status": "limited"},
        ]
      }
    };
  }

  @override
  void initState() {
    super.initState();
    _mutableTimeSlots = _buildMutableSlots();
    _data = SlotGridData.fromJson(_getJsonInput());
  }

  Map<String, List<Map<String, dynamic>>> _buildMutableSlots() {
    final json = _getJsonInput();
    final raw = json['timeSlots'] as Map<String, dynamic>;
    return raw.map((key, value) => MapEntry(
          key,
          (value as List).map((e) => Map<String, dynamic>.from(e as Map)).toList(),
        ));
  }

  List<SlotTimeEntry> _timeSlotsFor(DateTime date) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (!_mutableTimeSlots.containsKey(dateStr)) {
      final defaultSlots = _mutableTimeSlots['default'] ?? [];
      _mutableTimeSlots[dateStr] = defaultSlots.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return _mutableTimeSlots[dateStr]!.map((e) => SlotTimeEntry.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text('Select appointment time', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('Adv. M. Sharma · 30-minute slot', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    Text('Appointment date & time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDate != null && _selectedSlot != null
                                  ? '${_formatDate(_selectedDate!)} · ${_selectedSlot!.time}'
                                  : 'Tap to pick date & time',
                              style: TextStyle(fontSize: 14, color: _selectedDate != null ? Color(0xFF111827) : Color(0xFF9CA3AF)),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // SlotGrid calendar with compact view bottom sheet
                    SlotGrid(
                      data: _data,
                      timeSlotProvider: _timeSlotsFor,
                      onSlotConfirmed: (date, slot) {
                        setState(() {
                          _selectedDate = date;
                          _selectedSlot = slot;
                        });
                      },
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                          _data = SlotGridData.fromJson({
                            ..._getJsonInput(),
                            'selectedDate': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                            'year': _data.year,
                            'month': _data.month,
                          });
                        });
                      },
                      onMonthChanged: (year, month) {
                        setState(() {
                          _data = SlotGridData.fromJson({
                            ..._getJsonInput(),
                            'year': year,
                            'month': month,
                          });
                        });
                      },
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

  String _formatDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _SelectAppointmentTimeMockup extends StatefulWidget {
  final SlotPickerViewMode viewMode;

  const _SelectAppointmentTimeMockup({
    this.viewMode = SlotPickerViewMode.expanded,
  });

  @override
  State<_SelectAppointmentTimeMockup> createState() =>
      _SelectAppointmentTimeMockupState();
}

class _SelectAppointmentTimeMockupState
    extends State<_SelectAppointmentTimeMockup> {
  DateTime? _selectedDate;
  SlotTimeEntry? _selectedSlot;
  late SlotGridData _data;
  Map<String, List<Map<String, dynamic>>> _mutableTimeSlots = {};

  Map<String, dynamic> _getJsonInput() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final dayAfter = now.add(const Duration(days: 2));
    final day4 = now.add(const Duration(days: 3));

    return {
      "year": now.year,
      "month": now.month,
      "today":
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      "weeklyOffWeekdays": [6, 7],
      "allowTapOnPublicHoliday": false,
      "allowTapOnWeeklyOff": false,
      "viewMode": widget.viewMode == SlotPickerViewMode.compact
          ? "compact"
          : "expanded",
      "dates": [
        {
          "date":
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 2)}',
          "status": "publicHoliday",
        },
        {
          "date":
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 4)}',
          "status": "noSlots",
        },
        {
          "date":
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 6)}',
          "status": "noSlots",
        },
      ],
      "timeSlots": {
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}':
            [
              {"time": "9:00 AM", "slotCount": 2, "status": "available"},
              {"time": "10:00 AM", "slotCount": 1, "status": "limited"},
              {"time": "11:00 AM", "slotCount": 0, "status": "noSlots"},
              {"time": "2:00 PM", "slotCount": 3, "status": "available"},
            ],
        '${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}':
            [
              {"time": "9:30 AM", "slotCount": 5, "status": "available"},
              {"time": "10:30 AM", "slotCount": 2, "status": "available"},
              {"time": "1:00 PM", "slotCount": 4, "status": "available"},
              {"time": "3:00 PM", "slotCount": 1, "status": "limited"},
            ],
        '${day4.year}-${day4.month.toString().padLeft(2, '0')}-${day4.day.toString().padLeft(2, '0')}':
            [
              {"time": "11:00 AM", "slotCount": 8, "status": "available"},
              {"time": "12:00 PM", "slotCount": 6, "status": "available"},
              {"time": "1:00 PM", "slotCount": 3, "status": "available"},
              {"time": "2:30 PM", "slotCount": 1, "status": "limited"},
            ],
        "default": [
          {"time": "9:00 AM", "slotCount": 4, "status": "available"},
          {"time": "9:30 AM", "slotCount": 6, "status": "available"},
          {"time": "10:00 AM", "slotCount": 3, "status": "available"},
          {"time": "10:30 AM", "slotCount": 0, "status": "noSlots"},
          {"time": "11:00 AM", "slotCount": 8, "status": "available"},
          {"time": "11:30 AM", "slotCount": 5, "status": "available"},
          {"time": "12:00 PM", "slotCount": 10, "status": "available"},
          {"time": "2:00 PM", "slotCount": 5, "status": "available"},
          {"time": "2:30 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:00 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:30 PM", "slotCount": 1, "status": "limited"},
          {"time": "4:00 PM", "slotCount": 7, "status": "available"},
        ],
      },
    };
  }

  static String _pad(int day) => day.toString().padLeft(2, '0');

  Map<String, List<Map<String, dynamic>>> _buildMutableSlots() {
    final json = _getJsonInput();
    final raw = json['timeSlots'] as Map<String, dynamic>;
    return raw.map(
      (key, value) => MapEntry(
        key,
        (value as List)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mutableTimeSlots = _buildMutableSlots();
    _data = SlotGridData.fromJson(_getJsonInput());
  }

  List<SlotTimeEntry> _timeSlotsFor(DateTime date) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (!_mutableTimeSlots.containsKey(dateStr)) {
      final defaultSlots = _mutableTimeSlots['default'] ?? [];
      _mutableTimeSlots[dateStr] = defaultSlots
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return _mutableTimeSlots[dateStr]!
        .map((e) => SlotTimeEntry.fromJson(e))
        .toList();
  }

  String _formatDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                color: _primaryColor,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'National Services Portal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Select appointment time',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Adv. M. Sharma · 30-minute slot',
                        style: TextStyle(fontSize: 13, color: _subtleText),
                      ),
                      const SizedBox(height: 20),

                      // Appointment date & time label
                      const Text(
                        'Appointment date & time',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tap to pick date & time dropdown trigger
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: _borderColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _selectedDate != null && _selectedSlot != null
                                    ? '${_formatDate(_selectedDate!)} · ${_selectedSlot!.time}'
                                    : 'Tap to pick date & time',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _selectedDate != null
                                      ? _titleColor
                                      : const Color(0xFF9CA3AF),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF6B7280),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // SlotGrid calendar component
                      SlotGrid(
                        data: _data,
                        timeSlotProvider: _timeSlotsFor,
                        onSlotConfirmed: (date, slot) {
                          setState(() {
                            _selectedDate = date;
                            _selectedSlot = slot;
                          });
                        },
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                            final json = _getJsonInput();
                            _data = SlotGridData.fromJson({
                              ...json,
                              'selectedDate':
                                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                              'year': _data.year,
                              'month': _data.month,
                            });
                          });
                        },
                        onMonthChanged: (year, month) {
                          setState(() {
                            final json = _getJsonInput();
                            _data = SlotGridData.fromJson({
                              ...json,
                              'year': year,
                              'month': month,
                            });
                          });
                        },
                      ),
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
}
