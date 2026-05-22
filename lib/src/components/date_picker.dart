import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/src/foundation/colors.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';
import 'buttons.dart';

/// Defines the mode for the date picker.
enum Ux4gDatePickerMode { single, range }

/// A highly customizable Date Picker component supporting single and range modes.
class Ux4gDatePicker extends StatefulWidget {
  final Ux4gDatePickerMode mode;
  final DateTime? initialDate;
  final DateTimeRange? initialDateRange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTimeRange>? onDateRangeSelected;
  final String placeholder;
  final bool enabled;

  const Ux4gDatePicker({
    super.key,
    this.mode = Ux4gDatePickerMode.single,
    this.initialDate,
    this.initialDateRange,
    this.minDate,
    this.maxDate,
    this.onDateSelected,
    this.onDateRangeSelected,
    this.placeholder = 'Select date',
    this.enabled = true,
  });

  @override
  State<Ux4gDatePicker> createState() => _Ux4gDatePickerState();
}

class _Ux4gDatePickerState extends State<Ux4gDatePicker> {
  DateTime? _selectedDate;
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedRange = widget.initialDateRange;
  }

  String _getFormattedValue() {
    if (widget.mode == Ux4gDatePickerMode.single) {
      if (_selectedDate == null) return widget.placeholder;
      return _formatDate(_selectedDate!);
    } else {
      if (_selectedRange == null) return widget.placeholder;
      return '${_formatDate(_selectedRange!.start)}  –  ${_formatDate(_selectedRange!.end)}';
    }
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString().padLeft(4, '0');
    return '$d/$m/$y';
  }

  void _openPicker() async {
    if (!widget.enabled) return;

    final result = await showDialog<dynamic>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: _Ux4gDatePickerDialog(
            mode: widget.mode,
            initialDate: _selectedDate,
            initialDateRange: _selectedRange,
            minDate: widget.minDate,
            maxDate: widget.maxDate,
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        if (widget.mode == Ux4gDatePickerMode.single && result is DateTime) {
          _selectedDate = result;
          widget.onDateSelected?.call(result);
        } else if (widget.mode == Ux4gDatePickerMode.range &&
            result is DateTimeRange) {
          _selectedRange = result;
          widget.onDateRangeSelected?.call(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);
    final isSelected =
        (widget.mode == Ux4gDatePickerMode.single && _selectedDate != null) ||
        (widget.mode == Ux4gDatePickerMode.range && _selectedRange != null);

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: _openPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? colors.primary
                  : colors.onSurface.withValues(alpha: 0.38),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getFormattedValue(),
                style: typography.bM_default.copyWith(
                  color: isSelected
                      ? colors.onSurface
                      : colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.calendar_today_outlined,
                size: 20,
                color: isSelected
                    ? colors.primary
                    : colors.onSurface.withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Ux4gDatePickerDialog extends StatefulWidget {
  final Ux4gDatePickerMode mode;
  final DateTime? initialDate;
  final DateTimeRange? initialDateRange;
  final DateTime? minDate;
  final DateTime? maxDate;

  const _Ux4gDatePickerDialog({
    required this.mode,
    this.initialDate,
    this.initialDateRange,
    this.minDate,
    this.maxDate,
  });

  @override
  State<_Ux4gDatePickerDialog> createState() => _Ux4gDatePickerDialogState();
}

class _Ux4gDatePickerDialogState extends State<_Ux4gDatePickerDialog> {
  late DateTime _currentDisplayedMonth;
  DateTime? _tempSelectedDate;
  DateTime? _tempRangeStart;
  DateTime? _tempRangeEnd;

  bool _showMonthYearPicker = false;
  int _yearGridStart = 2020;

  final List<String> _weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  final List<String> _months = [
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

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    if (widget.mode == Ux4gDatePickerMode.single) {
      _tempSelectedDate = widget.initialDate;
      _currentDisplayedMonth = widget.initialDate ?? now;
    } else {
      _tempRangeStart = widget.initialDateRange?.start;
      _tempRangeEnd = widget.initialDateRange?.end;
      _currentDisplayedMonth = widget.initialDateRange?.start ?? now;
    }
    _currentDisplayedMonth = DateTime(
      _currentDisplayedMonth.year,
      _currentDisplayedMonth.month,
    );
    _yearGridStart =
        _currentDisplayedMonth.year - (_currentDisplayedMonth.year % 8);
  }

  bool _isSelectable(DateTime date) {
    if (widget.minDate != null &&
        date.isBefore(
          DateTime(
            widget.minDate!.year,
            widget.minDate!.month,
            widget.minDate!.day,
          ),
        )) {
      return false;
    }
    if (widget.maxDate != null &&
        date.isAfter(
          DateTime(
            widget.maxDate!.year,
            widget.maxDate!.month,
            widget.maxDate!.day,
          ),
        )) {
      return false;
    }
    return true;
  }

  void _onConfirm() {
    if (widget.mode == Ux4gDatePickerMode.single) {
      if (_tempSelectedDate != null) {
        Navigator.pop(context, _tempSelectedDate);
      }
    } else {
      if (_tempRangeStart != null && _tempRangeEnd != null) {
        Navigator.pop(
          context,
          DateTimeRange(start: _tempRangeStart!, end: _tempRangeEnd!),
        );
      }
    }
  }

  void _onCancel() {
    Navigator.pop(context, null);
  }

  void _handleDaySelect(DateTime date) {
    if (!_isSelectable(date)) return;
    setState(() {
      if (widget.mode == Ux4gDatePickerMode.single) {
        _tempSelectedDate = date;
      } else {
        if (_tempRangeStart == null ||
            (_tempRangeStart != null && _tempRangeEnd != null)) {
          _tempRangeStart = date;
          _tempRangeEnd = null;
        } else {
          if (date.isBefore(_tempRangeStart!)) {
            _tempRangeEnd = _tempRangeStart;
            _tempRangeStart = date;
          } else {
            _tempRangeEnd = date;
          }
        }
      }
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentDisplayedMonth = DateTime(
        _currentDisplayedMonth.year,
        _currentDisplayedMonth.month + offset,
      );
    });
  }

  void _changeYearGrid(int offset) {
    setState(() {
      _yearGridStart += (8 * offset);
    });
  }

  String _getMonthName(int month) {
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

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_showMonthYearPicker) {
                      _changeYearGrid(-1);
                    } else {
                      _changeMonth(-1);
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMonthYearPicker = !_showMonthYearPicker;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        _showMonthYearPicker
                            ? '$_yearGridStart-${_yearGridStart + 7}'
                            : '${_getMonthName(_currentDisplayedMonth.month)} ${_currentDisplayedMonth.year}',
                        style: typography.bM_strong.copyWith(
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _showMonthYearPicker
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: colors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_showMonthYearPicker) {
                      _changeYearGrid(1);
                    } else {
                      _changeMonth(1);
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.12)),

          // Body
          Container(
            padding: const EdgeInsets.all(16),
            height: 280, // Fixed height to prevent jumps
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _showMonthYearPicker
                  ? _buildMonthYearPicker(colors, typography)
                  : _buildCalendarView(colors, typography),
            ),
          ),

          Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.12)),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Ux4gButton(
                    text: 'Cancel',
                    variant: Ux4gButtonVariant.outline,
                    onPressed: _onCancel,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Ux4gButton(
                    text: _showMonthYearPicker ? 'Select date' : 'Confirm',
                    variant: Ux4gButtonVariant.primary,
                    onPressed: _showMonthYearPicker
                        ? () {
                            setState(() {
                              _showMonthYearPicker = false;
                            });
                          }
                        : _onConfirm,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthYearPicker(Ux4gColors colors, Ux4gTypography typography) {
    return Column(
      key: const ValueKey('MonthYearPicker'),
      children: [
        // Year Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            final year = _yearGridStart + index;
            final isSelected = year == _currentDisplayedMonth.year;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentDisplayedMonth = DateTime(
                    year,
                    _currentDisplayedMonth.month,
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  year.toString(),
                  style: typography.bM_default.copyWith(
                    color: isSelected ? colors.primary : colors.onSurface,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.12)),

        // Month Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            final isSelected = (index + 1) == _currentDisplayedMonth.month;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentDisplayedMonth = DateTime(
                    _currentDisplayedMonth.year,
                    index + 1,
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _months[index],
                  style: typography.bM_default.copyWith(
                    color: isSelected ? colors.primary : colors.onSurface,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarView(Ux4gColors colors, Ux4gTypography typography) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(
      _currentDisplayedMonth.year,
      _currentDisplayedMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentDisplayedMonth.year,
      _currentDisplayedMonth.month + 1,
      0,
    );

    // Calculate leading empty days (1 = Monday, 7 = Sunday)
    int leadingDays = firstDayOfMonth.weekday - 1;

    final daysInMonth = lastDayOfMonth.day;
    final totalCells = leadingDays + daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Column(
      key: const ValueKey('Calendar'),
      children: [
        // Weekdays Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekdays
              .map(
                (d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: typography.bS_strong.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        // Days Grid
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 4,
            ),
            itemCount: rows * 7,
            itemBuilder: (context, index) {
              if (index < leadingDays || index >= leadingDays + daysInMonth) {
                return const SizedBox.shrink();
              }
              final day = index - leadingDays + 1;
              final date = DateTime(
                _currentDisplayedMonth.year,
                _currentDisplayedMonth.month,
                day,
              );

              final isToday =
                  date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day;
              final isSelectable = _isSelectable(date);

              bool isSelectedSingle = false;
              bool isRangeStart = false;
              bool isRangeEnd = false;
              bool isInRange = false;

              if (widget.mode == Ux4gDatePickerMode.single) {
                isSelectedSingle =
                    _tempSelectedDate?.year == date.year &&
                    _tempSelectedDate?.month == date.month &&
                    _tempSelectedDate?.day == date.day;
              } else {
                if (_tempRangeStart != null &&
                    date.year == _tempRangeStart!.year &&
                    date.month == _tempRangeStart!.month &&
                    date.day == _tempRangeStart!.day) {
                  isRangeStart = true;
                }
                if (_tempRangeEnd != null &&
                    date.year == _tempRangeEnd!.year &&
                    date.month == _tempRangeEnd!.month &&
                    date.day == _tempRangeEnd!.day) {
                  isRangeEnd = true;
                }
                if (_tempRangeStart != null &&
                    _tempRangeEnd != null &&
                    date.isAfter(_tempRangeStart!) &&
                    date.isBefore(_tempRangeEnd!)) {
                  isInRange = true;
                }
              }

              final isSolidPurple =
                  isSelectedSingle || isRangeStart || isRangeEnd;
              final isLightPurple = isInRange;

              return GestureDetector(
                onTap: isSelectable ? () => _handleDaySelect(date) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: isSolidPurple
                        ? colors.primary
                        : (isLightPurple
                              ? colors.primary.withValues(alpha: 0.1)
                              : Colors.transparent),
                    borderRadius: isSolidPurple
                        ? BorderRadius.circular(4)
                        : (isRangeStart
                              ? const BorderRadius.horizontal(
                                  left: Radius.circular(4),
                                )
                              : (isRangeEnd
                                    ? const BorderRadius.horizontal(
                                        right: Radius.circular(4),
                                      )
                                    : BorderRadius.zero)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.toString(),
                          style: typography.bM_default.copyWith(
                            color: isSolidPurple
                                ? colors.onPrimary
                                : (isSelectable
                                      ? colors.onSurface
                                      : colors.onSurface.withValues(
                                          alpha: 0.38,
                                        )),
                          ),
                        ),
                        if (isToday && !isSolidPurple)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
