import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

/// View mode for time slot picker.
enum SlotPickerViewMode {
  /// Expanded view showing slots in a vertical list.
  expanded,

  /// Compact view showing slots in a grid format with 2 columns.
  compact,
}

/// State of an individual date cell in the slot grid.
enum SlotDateStatus {
  /// Date has no available booking slots.
  noSlots,

  /// Date is a public holiday.
  publicHoliday,

  /// Date falls on a weekly-off day (e.g. Saturday / Sunday).
  weeklyOff,

  /// Date has available slots (default / bookable).
  available,
}

/// Represents a single date entry supplied via JSON.
class SlotDateEntry {
  final DateTime date;
  final SlotDateStatus status;

  const SlotDateEntry({required this.date, required this.status});

  /// Creates a [SlotDateEntry] from a JSON map.
  ///
  /// Expected JSON shape:
  /// ```json
  /// { "date": "2026-04-09", "status": "publicHoliday" }
  /// ```
  /// Valid status values: `"available"`, `"noSlots"`, `"publicHoliday"`, `"weeklyOff"`.
  factory SlotDateEntry.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date'] as String);
    final rawStatus = json['status'] as String? ?? 'available';
    final status = _parseStatus(rawStatus);
    return SlotDateEntry(date: date, status: status);
  }

  Map<String, dynamic> toJson() => {
    'date':
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
    'status': _statusToString(status),
  };

  static SlotDateStatus _parseStatus(String raw) {
    switch (raw) {
      case 'noSlots':
        return SlotDateStatus.noSlots;
      case 'publicHoliday':
        return SlotDateStatus.publicHoliday;
      case 'weeklyOff':
        return SlotDateStatus.weeklyOff;
      default:
        return SlotDateStatus.available;
    }
  }

  static String _statusToString(SlotDateStatus s) {
    switch (s) {
      case SlotDateStatus.noSlots:
        return 'noSlots';
      case SlotDateStatus.publicHoliday:
        return 'publicHoliday';
      case SlotDateStatus.weeklyOff:
        return 'weeklyOff';
      case SlotDateStatus.available:
        return 'available';
    }
  }
}

/// Top-level data model passed to [SlotGrid].
///
/// Example JSON:
/// ```json
/// {
///   "year": 2026,
///   "month": 4,
///   "selectedDate": "2026-04-23",
///   "today": "2026-04-15",
///   "weeklyOffWeekdays": [6, 7],
///   "dates": [
///     { "date": "2026-04-09", "status": "publicHoliday" },
///     { "date": "2026-04-21", "status": "noSlots" },
///     { "date": "2026-04-05", "status": "weeklyOff" }
///   ]
/// }
/// ```
/// `weeklyOffWeekdays` uses ISO 8601 weekday numbering: 1 = Monday … 7 = Sunday.
class SlotGridData {
  final int year;
  final int month;
  final DateTime? selectedDate;
  final DateTime? today;

  /// ISO weekday numbers (1=Mon … 7=Sun) that are weekly-off by default for
  /// every week in the month (e.g. [6, 7] for Saturday & Sunday).
  final List<int> weeklyOffWeekdays;

  /// Explicit per-date overrides. Takes precedence over [weeklyOffWeekdays].
  final List<SlotDateEntry> dates;

  /// Whether tapping on a public holiday date is allowed. Defaults to false.
  final bool allowTapOnPublicHoliday;

  /// Whether tapping on a weekly-off date is allowed. Defaults to false.
  final bool allowTapOnWeeklyOff;

  /// View mode for the time slot picker. Defaults to expanded.
  /// Use 'expanded' for vertical list view, 'compact' for grid view.
  final SlotPickerViewMode viewMode;

  const SlotGridData({
    required this.year,
    required this.month,
    this.selectedDate,
    this.today,
    this.weeklyOffWeekdays = const [6, 7],
    this.dates = const [],
    this.allowTapOnPublicHoliday = false,
    this.allowTapOnWeeklyOff = false,
    required this.viewMode,
  });

  factory SlotGridData.fromJson(Map<String, dynamic> json) {
    // Parse viewMode - ensure it's always set to a valid value
    final viewModeStr = json['viewMode'];
    final viewMode = _parseViewMode(viewModeStr);

    return SlotGridData(
      year: json['year'] as int,
      month: json['month'] as int,
      selectedDate: json['selectedDate'] != null
          ? DateTime.parse(json['selectedDate'] as String)
          : null,
      today: json['today'] != null
          ? DateTime.parse(json['today'] as String)
          : null,
      weeklyOffWeekdays: json['weeklyOffWeekdays'] != null
          ? List<int>.from(json['weeklyOffWeekdays'] as List)
          : [6, 7],
      dates: json['dates'] != null
          ? (json['dates'] as List)
                .map((e) => SlotDateEntry.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
      allowTapOnPublicHoliday:
          json['allowTapOnPublicHoliday'] as bool? ?? false,
      allowTapOnWeeklyOff: json['allowTapOnWeeklyOff'] as bool? ?? false,
      viewMode: viewMode,
    );
  }

  static SlotPickerViewMode _parseViewMode(dynamic viewModeValue) {
    if (viewModeValue == null) {
      return SlotPickerViewMode.expanded;
    }

    final viewModeStr = viewModeValue.toString().toLowerCase().trim();
    if (viewModeStr == 'compact') {
      return SlotPickerViewMode.compact;
    }

    return SlotPickerViewMode.expanded;
  }
}

// ---------------------------------------------------------------------------
// Time slot models
// ---------------------------------------------------------------------------

enum SlotTimeStatus {
  /// Slot is open for booking.
  available,

  /// Slot has limited capacity (few slots remaining).
  limited,

  /// No slots available for this time.
  noSlots,
}

/// A single bookable time entry shown inside [SlotTimePickerSheet].
class SlotTimeEntry {
  final String time;
  final int slotCount;
  final SlotTimeStatus status;

  const SlotTimeEntry({
    required this.time,
    required this.slotCount,
    this.status = SlotTimeStatus.available,
  });

  factory SlotTimeEntry.fromJson(Map<String, dynamic> json) {
    final raw = json['status'] as String? ?? 'available';
    SlotTimeStatus status;
    switch (raw) {
      case 'limited':
        status = SlotTimeStatus.limited;
        break;
      case 'noSlots':
        status = SlotTimeStatus.noSlots;
        break;
      default:
        status = SlotTimeStatus.available;
    }
    return SlotTimeEntry(
      time: json['time'] as String,
      slotCount: (json['slotCount'] as num?)?.toInt() ?? 0,
      status: status,
    );
  }
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// A calendar-style slot grid component.
///
/// Pass [data] as a [SlotGridData] (built directly or via [SlotGridData.fromJson]).
/// Provide [timeSlotProvider] to supply time slots when a date is tapped —
/// the component will automatically open [SlotTimePickerSheet].
class SlotGrid extends StatefulWidget {
  final SlotGridData data;
  final ValueChanged<DateTime>? onDateSelected;

  /// Called when the user taps the previous (−1) or next (+1) month arrow.
  final void Function(int year, int month)? onMonthChanged;

  /// Supply time slots for a tapped date. When provided, tapping an available
  /// date opens [SlotTimePickerSheet] instead of calling [onDateSelected] directly.
  /// Return an empty list to show the sheet with no slots.
  final List<SlotTimeEntry> Function(DateTime date)? timeSlotProvider;

  /// Called when the user confirms a time slot booking.
  /// Receives the tapped [date] and the confirmed [SlotTimeEntry].
  final void Function(DateTime date, SlotTimeEntry slot)? onSlotConfirmed;

  const SlotGrid({
    super.key,
    required this.data,
    this.onDateSelected,
    this.onMonthChanged,
    this.timeSlotProvider,
    this.onSlotConfirmed,
  });

  @override
  State<SlotGrid> createState() => _SlotGridState();
}

class _SlotGridState extends State<SlotGrid> {
  late int _year;
  late int _month;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _year = widget.data.year;
    _month = widget.data.month;
    _selectedDate = widget.data.selectedDate;
  }

  @override
  void didUpdateWidget(SlotGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _year = widget.data.year;
      _month = widget.data.month;
      _selectedDate = widget.data.selectedDate;
    }
  }

  /// Returns true if the currently displayed month is the same as today's month,
  /// preventing backwards navigation into the past.
  bool get _isCurrentMonth {
    final today = widget.data.today ?? DateTime.now();
    return _year == today.year && _month == today.month;
  }

  void _goToPreviousMonth() {
    if (_isCurrentMonth) return; // do not go before the current month
    setState(() {
      if (_month == 1) {
        _month = 12;
        _year -= 1;
      } else {
        _month -= 1;
      }
    });
    widget.onMonthChanged?.call(_year, _month);
  }

  void _goToNextMonth() {
    setState(() {
      if (_month == 12) {
        _month = 1;
        _year += 1;
      } else {
        _month += 1;
      }
    });
    widget.onMonthChanged?.call(_year, _month);
  }

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

  /// Returns the [SlotDateStatus] for [date], taking explicit overrides and
  /// weekly-off weekdays into account.
  SlotDateStatus _statusFor(DateTime date) {
    // Explicit per-date entry wins.
    for (final entry in widget.data.dates) {
      if (_sameDay(entry.date, date)) return entry.status;
    }
    // Fall back to weekly-off weekday rule.
    if (widget.data.weeklyOffWeekdays.contains(date.weekday)) {
      return SlotDateStatus.weeklyOff;
    }
    return SlotDateStatus.available;
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isToday(DateTime date) {
    final today = widget.data.today ?? DateTime.now();
    return _sameDay(date, today);
  }

  bool _isSelected(DateTime date) =>
      _selectedDate != null && _sameDay(_selectedDate!, date);

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: onSurface.withValues(alpha: 0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(ux4gColors, ux4gTypography, materialTheme),
          const SizedBox(height: 12),
          _buildWeekdayRow(ux4gColors, ux4gTypography, materialTheme),
          const SizedBox(height: 4),
          _buildDatesGrid(ux4gColors, ux4gTypography, materialTheme),
          const SizedBox(height: 12),
          _buildLegend(ux4gColors, ux4gTypography, materialTheme),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Header  "← April 2026 →"
  // ------------------------------------------------------------------

  Widget _buildHeader(
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    final monthName = _monthName(_month);
    final isPrevDisabled = _isCurrentMonth;
    final primary = colors?.primary ?? materialTheme.colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NavArrow(
          icon: Icons.chevron_left_rounded,
          onTap: _goToPreviousMonth,
          disabled: isPrevDisabled,
        ),
        Text(
          '$monthName $_year',
          style:
              (typography?.tM_strong ??
                      materialTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ) ??
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ))
                  .copyWith(color: primary),
        ),
        _NavArrow(icon: Icons.chevron_right_rounded, onTap: _goToNextMonth),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Weekday row  Mo Tu We Th Fr Sa Su
  // ------------------------------------------------------------------

  Widget _buildWeekdayRow(
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    const labels = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;
    // ISO weekday: Mo=1 … Su=7
    final baseStyle =
        typography?.lM_strong ??
        materialTheme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    return Row(
      children: List.generate(7, (index) {
        final weekday = index + 1; // 1-based ISO
        final isWeeklyOff = widget.data.weeklyOffWeekdays.contains(weekday);
        return Expanded(
          child: Center(
            child: Text(
              labels[index],
              style: baseStyle.copyWith(
                color: isWeeklyOff
                    ? onSurface.withValues(alpha: 0.38)
                    : onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ------------------------------------------------------------------
  // Dates grid
  // ------------------------------------------------------------------

  Widget _buildDatesGrid(
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    // First day of current month (ISO weekday 1=Mon … 7=Sun).
    final firstDay = DateTime(_year, _month, 1);
    // Offset so the grid starts on Monday.
    final startOffset = firstDay.weekday - 1; // 0 for Mon, 6 for Sun
    final daysInMonth = DateTime(_year, _month + 1, 0).day;

    // Total cells = leading blanks + days in month, rounded up to full weeks.
    final totalCells = startOffset + daysInMonth;
    final rowCount = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rowCount, (row) {
        return Row(
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final dayOffset = cellIndex - startOffset + 1;

            // Determine if this is in the current month.
            if (dayOffset < 1 || dayOffset > daysInMonth) {
              return Expanded(
                child: _buildOutOfMonthCell(
                  dayOffset,
                  daysInMonth,
                  colors,
                  typography,
                  materialTheme,
                ),
              );
            }

            final date = DateTime(_year, _month, dayOffset);
            return Expanded(
              child: _buildDateCell(date, colors, typography, materialTheme),
            );
          }),
        );
      }),
    );
  }

  Widget _buildOutOfMonthCell(
    int dayOffset,
    int daysInMonth,
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    final int day;
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;
    if (dayOffset < 1) {
      // Days from previous month
      final prevMonth = _month == 1 ? 12 : _month - 1;
      final prevYear = _month == 1 ? _year - 1 : _year;
      final daysInPrev = DateTime(prevYear, prevMonth + 1, 0).day;
      day = daysInPrev + dayOffset;
    } else {
      // Days from next month
      day = dayOffset - daysInMonth;
    }
    return SizedBox(
      height: 40,
      child: Center(
        child: Text(
          '$day',
          style:
              (typography?.bS_default ??
                      materialTheme.textTheme.bodySmall ??
                      const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ))
                  .copyWith(color: onSurface.withValues(alpha: 0.38)),
        ),
      ),
    );
  }

  Widget _buildDateCell(
    DateTime date,
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    final status = _statusFor(date);
    final isSelected = _isSelected(date);
    final isToday = _isToday(date);

    // Dates strictly before today are not selectable.
    final today = widget.data.today ?? DateTime.now();
    final isPast = date.isBefore(DateTime(today.year, today.month, today.day));

    // Determine tappability based on status and data flags.
    final canTap =
        !isPast &&
        (status == SlotDateStatus.available ||
            (status == SlotDateStatus.publicHoliday &&
                widget.data.allowTapOnPublicHoliday) ||
            (status == SlotDateStatus.weeklyOff &&
                widget.data.allowTapOnWeeklyOff));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: canTap
          ? () {
              if (widget.timeSlotProvider != null) {
                final slots = widget.timeSlotProvider!(date);
                final today = widget.data.today ?? DateTime.now();
                final currentViewMode = widget.data.viewMode;
                SlotTimePickerSheet.show(
                  context,
                  date: date,
                  slots: slots,
                  today: today,
                  viewMode: currentViewMode,
                  onConfirm: (slotTime) {
                    setState(() => _selectedDate = date);
                    widget.onDateSelected?.call(date);
                    widget.onSlotConfirmed?.call(date, slotTime);
                  },
                  onPreviousDay: (newDate) async {
                    return widget.timeSlotProvider!(newDate);
                  },
                  onNextDay: (newDate) async {
                    return widget.timeSlotProvider!(newDate);
                  },
                );
              } else {
                setState(() => _selectedDate = date);
                widget.onDateSelected?.call(date);
              }
            }
          : null,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDateLabel(
                date,
                status,
                isSelected,
                isPast,
                colors,
                typography,
                materialTheme,
              ),
              if (isToday && !isSelected) _buildTodayDot(colors, materialTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateLabel(
    DateTime date,
    SlotDateStatus status,
    bool isSelected,
    bool isPast,
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = colors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary = colors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    final warning = colors?.warning ?? Colors.orange;

    // ------ Past date – always muted, never selected ------
    if (isPast) {
      return SizedBox(
        width: 32,
        height: 32,
        child: Center(
          child: Text(
            '${date.day}',
            style:
                (typography?.bS_default ??
                        materialTheme.textTheme.bodySmall ??
                        const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ))
                    .copyWith(color: onSurface.withValues(alpha: 0.38)),
          ),
        ),
      );
    }
    // ------ Selected state ------
    if (isSelected) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style:
                (typography?.bS_strong ??
                        materialTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ))
                    .copyWith(color: onPrimary),
          ),
        ),
      );
    }

    // ------ Status-based styling ------
    switch (status) {
      case SlotDateStatus.publicHoliday:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style:
                  (typography?.bS_strong ??
                          materialTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ) ??
                          const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ))
                      .copyWith(color: warning),
            ),
          ),
        );

      case SlotDateStatus.noSlots:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style:
                  (typography?.bS_strong ??
                          materialTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ) ??
                          const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ))
                      .copyWith(color: onSurface.withValues(alpha: 0.38)),
            ),
          ),
        );

      case SlotDateStatus.weeklyOff:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style:
                  (typography?.bS_default ??
                          materialTheme.textTheme.bodySmall ??
                          const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ))
                      .copyWith(color: onSurface.withValues(alpha: 0.38)),
            ),
          ),
        );

      case SlotDateStatus.available:
        return SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              '${date.day}',
              style:
                  (typography?.bS_default ??
                          materialTheme.textTheme.bodySmall ??
                          const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ))
                      .copyWith(color: onSurface),
            ),
          ),
        );
    }
  }

  Widget _buildTodayDot(Ux4gColors? colors, ThemeData materialTheme) {
    final primary = colors?.primary ?? materialTheme.colorScheme.primary;
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
    );
  }

  // ------------------------------------------------------------------
  // Legend
  // ------------------------------------------------------------------

  Widget _buildLegend(
    Ux4gColors? colors,
    Ux4gTypography? typography,
    ThemeData materialTheme,
  ) {
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final warning = colors?.warning ?? Colors.orange;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(
          color: onSurface.withValues(alpha: 0.05),
          label: 'No slots',
          typography: typography,
          materialTheme: materialTheme,
          ux4gColors: colors,
        ),
        const SizedBox(width: 16),
        _LegendItem(
          color: warning.withValues(alpha: 0.1),
          borderColor: warning,
          label: 'Public holiday',
          typography: typography,
          materialTheme: materialTheme,
          ux4gColors: colors,
        ),
        const SizedBox(width: 16),
        _LegendItem(
          color: onSurface.withValues(alpha: 0.05),
          label: 'Weekly off',
          typography: typography,
          materialTheme: materialTheme,
          ux4gColors: colors,
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Utilities
  // ------------------------------------------------------------------

  static String _monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }
}

// ---------------------------------------------------------------------------
// Private helper widgets
// ---------------------------------------------------------------------------

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool disabled;

  const _NavArrow({
    required this.icon,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: disabled ? onSurface.withValues(alpha: 0.05) : surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: onSurface.withValues(alpha: 0.12)),
        ),
        child: Icon(
          icon,
          size: 18,
          color: disabled
              ? onSurface.withValues(alpha: 0.12)
              : onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final String label;
  final Ux4gTypography? typography;
  final Ux4gColors? ux4gColors;
  final ThemeData materialTheme;

  const _LegendItem({
    required this.color,
    this.borderColor,
    required this.label,
    this.typography,
    required this.ux4gColors,
    required this.materialTheme,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: borderColor ?? onSurface.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style:
              (typography?.lS_default ??
                      materialTheme.textTheme.labelSmall ??
                      const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ))
                  .copyWith(color: onSurface.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SlotTimePickerSheet
// ---------------------------------------------------------------------------

/// A modal bottom sheet that displays bookable time slots for a selected date.
///
/// Open via [SlotTimePickerSheet.show]. Supports date navigation via back/next arrows.
class SlotTimePickerSheet extends StatefulWidget {
  final DateTime date;
  final List<SlotTimeEntry> slots;
  final DateTime today;
  final SlotPickerViewMode viewMode;
  final void Function(SlotTimeEntry selected)? onConfirm;

  /// Called when user taps the back arrow. Should update the date and return new slots.
  final Future<List<SlotTimeEntry>> Function(DateTime newDate)? onPreviousDay;

  /// Called when user taps the next arrow. Should update the date and return new slots.
  final Future<List<SlotTimeEntry>> Function(DateTime newDate)? onNextDay;

  const SlotTimePickerSheet({
    super.key,
    required this.date,
    required this.slots,
    required this.today,
    required this.viewMode,
    this.onConfirm,
    this.onPreviousDay,
    this.onNextDay,
  });

  static Future<SlotTimeEntry?> show(
    BuildContext context, {
    required DateTime date,
    required List<SlotTimeEntry> slots,
    required DateTime today,
    required SlotPickerViewMode viewMode,
    void Function(SlotTimeEntry selected)? onConfirm,
    Future<List<SlotTimeEntry>> Function(DateTime newDate)? onPreviousDay,
    Future<List<SlotTimeEntry>> Function(DateTime newDate)? onNextDay,
  }) {
    return showModalBottomSheet<SlotTimeEntry>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SlotTimePickerSheet(
        date: date,
        slots: slots,
        today: today,
        viewMode: viewMode,
        onConfirm: onConfirm,
        onPreviousDay: onPreviousDay,
        onNextDay: onNextDay,
      ),
    );
  }

  @override
  State<SlotTimePickerSheet> createState() => _SlotTimePickerSheetState();
}

class _SlotTimePickerSheetState extends State<SlotTimePickerSheet> {
  late DateTime _currentDate;
  late List<SlotTimeEntry> _slots;
  int? _selectedIndex;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.date;
    _slots = widget.slots;
  }

  static const _weekDayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const _monthNames = [
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

  String get _dateLabel {
    final wd = _weekDayNames[_currentDate.weekday - 1];
    final mo = _monthNames[_currentDate.month - 1];
    return '$wd ${_currentDate.day} $mo';
  }

  bool get _isToday {
    return _currentDate.year == widget.today.year &&
        _currentDate.month == widget.today.month &&
        _currentDate.day == widget.today.day;
  }

  bool get _canGoPrevious {
    // Allow going back until we reach today
    return _currentDate.isAfter(
      DateTime(widget.today.year, widget.today.month, widget.today.day),
    );
  }

  Future<void> _goToPreviousDay() async {
    if (!_canGoPrevious || widget.onPreviousDay == null) return;

    final newDate = _currentDate.subtract(const Duration(days: 1));
    setState(() => _isLoading = true);
    try {
      final newSlots = await widget.onPreviousDay!(newDate);
      setState(() {
        _currentDate = newDate;
        _slots = newSlots;
        _selectedIndex = null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _goToNextDay() async {
    if (widget.onNextDay == null) return;

    final newDate = _currentDate.add(const Duration(days: 1));
    setState(() => _isLoading = true);
    try {
      final newSlots = await widget.onNextDay!(newDate);
      setState(() {
        _currentDate = newDate;
        _slots = newSlots;
        _selectedIndex = null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    final mq = MediaQuery.of(context);

    return Container(
      height: mq.size.height,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: widget.viewMode == SlotPickerViewMode.compact
          ? _buildCompactView(
              context,
              ux4gColors,
              ux4gTypography,
              mq,
              materialTheme,
            )
          : _buildExpandedView(
              context,
              ux4gColors,
              ux4gTypography,
              mq,
              materialTheme,
            ),
    );
  }

  // ------------------------------------------------------------------
  // Expanded View (Vertical List)
  // ------------------------------------------------------------------

  Widget _buildExpandedView(
    BuildContext context,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    MediaQueryData mq,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Column(
      children: [
        // Drag handle
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),

        // Header
        _buildSheetHeader(ux4gColors, ux4gTypography, materialTheme),

        Divider(
          height: 1,
          thickness: 1,
          color: onSurface.withValues(alpha: 0.08),
        ),

        // Time slot list (fills remaining space)
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _slots.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              thickness: 1,
              color: onSurface.withValues(alpha: 0.08),
            ),
            itemBuilder: (_, i) =>
                _buildSlotTile(i, ux4gColors, ux4gTypography, materialTheme),
          ),
        ),

        Divider(
          height: 1,
          thickness: 1,
          color: onSurface.withValues(alpha: 0.08),
        ),

        // Legend
        _buildLegend(ux4gColors, ux4gTypography, materialTheme),

        Divider(
          height: 1,
          thickness: 1,
          color: onSurface.withValues(alpha: 0.08),
        ),

        // Buttons
        _buildFooter(ux4gColors, ux4gTypography, materialTheme),

        SizedBox(height: mq.padding.bottom + 8),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Compact View (Grid Layout)
  // ------------------------------------------------------------------

  Widget _buildCompactView(
    BuildContext context,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    MediaQueryData mq,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;

    // Pair slots into rows of 2
    final rows = <List<(int, SlotTimeEntry)>>[];
    for (int i = 0; i < _slots.length; i += 2) {
      final row = [(i, _slots[i])];
      if (i + 1 < _slots.length) row.add((i + 1, _slots[i + 1]));
      rows.add(row);
    }

    return Column(
      children: [
        // Drag handle
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),

        // Header
        _buildSheetHeader(ux4gColors, ux4gTypography, materialTheme),

        Divider(
          height: 1,
          thickness: 1,
          color: onSurface.withValues(alpha: 0.08),
        ),

        // Time slot 2-column grid
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: rows.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              thickness: 1,
              color: onSurface.withValues(alpha: 0.08),
            ),
            itemBuilder: (_, rowIndex) {
              final row = rows[rowIndex];
              return IntrinsicHeight(
                child: Row(
                  children: () {
                    final cells = <Widget>[];
                    for (int i = 0; i < row.length; i++) {
                      final (index, slot) = row[i];
                      final isSelected = _selectedIndex == index;
                      if (i > 0) {
                        cells.add(
                          VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: onSurface.withValues(alpha: 0.08),
                          ),
                        );
                      }
                      cells.add(
                        Expanded(
                          child: GestureDetector(
                            onTap: slot.status == SlotTimeStatus.noSlots
                                ? null
                                : () => setState(() => _selectedIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              color: isSelected
                                  ? primary.withValues(alpha: 0.08)
                                  : Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    slot.time,
                                    style:
                                        (ux4gTypography?.bS_default ??
                                                materialTheme
                                                    .textTheme
                                                    .bodySmall)
                                            ?.copyWith(
                                              color:
                                                  slot.status ==
                                                      SlotTimeStatus.noSlots
                                                  ? onSurface.withValues(
                                                      alpha: 0.38,
                                                    )
                                                  : isSelected
                                                  ? primary
                                                  : onSurface,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                  ),
                                  const SizedBox(width: 6),
                                  _buildCompactSlotBadge(
                                    slot,
                                    isSelected,
                                    ux4gColors,
                                    ux4gTypography,
                                    materialTheme,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // If only one item in row, add empty column
                    if (row.length == 1) {
                      cells.add(
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: onSurface.withValues(alpha: 0.08),
                        ),
                      );
                      cells.add(Expanded(child: Container()));
                    }

                    return cells;
                  }(),
                ),
              );
            },
          ),
        ),

        Divider(
          height: 1,
          thickness: 1,
          color: onSurface.withValues(alpha: 0.08),
        ),

        // Buttons
        _buildFooter(ux4gColors, ux4gTypography, materialTheme),

        SizedBox(height: mq.padding.bottom + 8),
      ],
    );
  }

  Widget _buildCompactSlotBadge(
    SlotTimeEntry slot,
    bool isSelected,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary =
        ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final success = ux4gColors?.success ?? Colors.green;

    if (slot.status == SlotTimeStatus.noSlots) {
      return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: onSurface.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '0',
          style:
              (ux4gTypography?.lS_strong ??
                      materialTheme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ))
                  ?.copyWith(color: onSurface.withValues(alpha: 0.38)),
        ),
      );
    }

    final Color badgeColor;
    if (isSelected) {
      badgeColor = primary;
    } else if (slot.status == SlotTimeStatus.limited) {
      badgeColor = warning;
    } else {
      badgeColor = success;
    }

    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: isSelected
          ? Icon(Icons.check_rounded, size: 13, color: onPrimary)
          : Text(
              '${slot.slotCount}',
              style:
                  (ux4gTypography?.lS_strong ??
                          materialTheme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ))
                      ?.copyWith(color: isSelected ? onPrimary : Colors.white),
            ),
    );
  }

  // ------------------------------------------------------------------
  // Header  "← Mon 14 Apr →"
  // ------------------------------------------------------------------

  Widget _buildSheetHeader(
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderArrow(
                ux4gColors: ux4gColors,
                icon: Icons.chevron_left_rounded,
                onTap: _goToPreviousDay,
                disabled: !_canGoPrevious || _isLoading,
                materialTheme: materialTheme,
              ),
              Text(
                _dateLabel,
                style:
                    (ux4gTypography?.tM_strong ??
                            materialTheme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(color: onSurface),
              ),
              _buildHeaderArrow(
                ux4gColors: ux4gColors,
                icon: Icons.chevron_right_rounded,
                onTap: _goToNextDay,
                disabled: _isLoading,
                materialTheme: materialTheme,
              ),
            ],
          ),
          if (_isToday) ...[
            const SizedBox(height: 2),
            Text(
              'Today',
              style:
                  (ux4gTypography?.lS_strong ??
                          materialTheme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ))
                      ?.copyWith(color: primary),
            ),
          ],
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Slot tile
  // ------------------------------------------------------------------

  Widget _buildSlotTile(
    int index,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    ThemeData materialTheme,
  ) {
    final slot = _slots[index];
    final isSelected = _selectedIndex == index;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final warning = ux4gColors?.warning ?? Colors.orange;

    if (slot.status == SlotTimeStatus.noSlots) {
      return Container(
        height: 56,
        color: onSurface.withValues(alpha: 0.04),
        alignment: Alignment.center,
        child: Text(
          'No slots available',
          style:
              (ux4gTypography?.bS_default ?? materialTheme.textTheme.bodySmall)
                  ?.copyWith(color: onSurface.withValues(alpha: 0.38)),
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? primary.withValues(alpha: 0.08) : surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? primary : onSurface.withValues(alpha: 0.12),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: isSelected
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_rounded, size: 18, color: primary),
                  const SizedBox(width: 6),
                  Text(
                    'Selected',
                    style:
                        (ux4gTypography?.bS_strong ??
                                materialTheme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ))
                            ?.copyWith(color: primary),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot.time,
                    style:
                        (ux4gTypography?.bS_strong ??
                                materialTheme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ))
                            ?.copyWith(color: onSurface),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${slot.slotCount} slots',
                    style:
                        (ux4gTypography?.lS_default ??
                                materialTheme.textTheme.labelSmall)
                            ?.copyWith(
                              color: slot.status == SlotTimeStatus.limited
                                  ? warning
                                  : onSurface.withValues(alpha: 0.38),
                            ),
                  ),
                ],
              ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Legend
  // ------------------------------------------------------------------

  Widget _buildLegend(
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final warning = ux4gColors?.warning ?? Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sheetLegendItem(
                icon: null,
                boxColor: surface,
                borderColor: onSurface.withValues(alpha: 0.38),
                label: 'Available',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
              _sheetLegendItem(
                icon: Icons.check_circle_rounded,
                iconColor: primary,
                boxColor: primary.withValues(alpha: 0.08),
                borderColor: primary,
                label: 'Selected',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
              _sheetLegendItem(
                icon: null,
                boxColor: onSurface.withValues(alpha: 0.04),
                borderColor: onSurface.withValues(alpha: 0.12),
                label: 'No slots',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sheetLegendItem(
                icon: null,
                boxColor: warning.withValues(alpha: 0.08),
                borderColor: warning,
                label: 'Limited slots',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
              _sheetLegendItem(
                icon: null,
                boxColor: warning.withValues(alpha: 0.08),
                borderColor: warning,
                label: 'Public holiday',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
              _sheetLegendItem(
                icon: null,
                boxColor: onSurface.withValues(alpha: 0.08),
                borderColor: onSurface.withValues(alpha: 0.12),
                label: 'Weekly off',
                ux4gColors: ux4gColors,
                ux4gTypography: ux4gTypography,
                materialTheme: materialTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sheetLegendItem({
    required Color boxColor,
    required Color borderColor,
    required String label,
    required Ux4gColors? ux4gColors,
    required Ux4gTypography? ux4gTypography,
    required ThemeData materialTheme,
    IconData? icon,
    Color? iconColor,
  }) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: icon != null ? Icon(icon, size: 10, color: iconColor) : null,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style:
              (ux4gTypography?.lS_default ?? materialTheme.textTheme.labelSmall)
                  ?.copyWith(color: onSurface.withValues(alpha: 0.6)),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Header arrow helper
  // ------------------------------------------------------------------

  Widget _buildHeaderArrow({
    required Ux4gColors? ux4gColors,
    required IconData icon,
    required VoidCallback onTap,
    required bool disabled,
    required ThemeData materialTheme,
  }) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: disabled ? onSurface.withValues(alpha: 0.04) : surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: disabled
                ? onSurface.withValues(alpha: 0.08)
                : onSurface.withValues(alpha: 0.12),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: disabled
              ? onSurface.withValues(alpha: 0.12)
              : onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Footer  Cancel | Confirm
  // ------------------------------------------------------------------

  Widget _buildFooter(
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
    ThemeData materialTheme,
  ) {
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary =
        ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;

    final hasSelection = _selectedIndex != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: onSurface.withValues(alpha: 0.12)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Cancel',
                style:
                    (ux4gTypography?.bS_strong ??
                            materialTheme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(
                          color: _isLoading
                              ? onSurface.withValues(alpha: 0.38)
                              : onSurface,
                        ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: (hasSelection && !_isLoading)
                  ? () {
                      final selected = _slots[_selectedIndex!];
                      widget.onConfirm?.call(selected);
                      Navigator.of(context).pop(selected);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                disabledBackgroundColor: onSurface.withValues(alpha: 0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: Text(
                'Confirm',
                style:
                    (ux4gTypography?.bS_strong ??
                            materialTheme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))
                        ?.copyWith(
                          color: hasSelection
                              ? onPrimary
                              : onSurface.withValues(alpha: 0.38),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
