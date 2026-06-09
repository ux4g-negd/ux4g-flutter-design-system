import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'buttons.dart';

/// A custom Time Picker component supporting AM/PM 12-hour format.
class Ux4gTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final String placeholder;
  final bool enabled;
  final int minuteInterval;

  const Ux4gTimePicker({
    super.key,
    this.initialTime,
    this.onTimeSelected,
    this.placeholder = 'Select time',
    this.enabled = true,
    this.minuteInterval = 1,
  });

  @override
  State<Ux4gTimePicker> createState() => _Ux4gTimePickerState();
}

class _Ux4gTimePickerState extends State<Ux4gTimePicker> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  String _getFormattedValue() {
    if (_selectedTime == null) return widget.placeholder;
    final hour = _selectedTime!.hourOfPeriod == 0
        ? 12
        : _selectedTime!.hourOfPeriod;
    final hStr = hour.toString().padLeft(2, '0');
    final mStr = _selectedTime!.minute.toString().padLeft(2, '0');
    final period = _selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hStr:$mStr $period';
  }

  void _openPicker() async {
    if (!widget.enabled) return;

    final result = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: _Ux4gTimePickerDialog(
            initialTime: _selectedTime ?? TimeOfDay.now(),
            hasInitialTime: _selectedTime != null,
            minuteInterval: widget.minuteInterval,
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedTime = result;
      });
      widget.onTimeSelected?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    final isSelected = _selectedTime != null;

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: _openPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? primary : onSurface.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getFormattedValue(),
                style:
                    (ux4gTypography?.bM_default ??
                            materialTheme.textTheme.bodyMedium)
                        ?.copyWith(
                          color: isSelected
                              ? onSurface
                              : onSurface.withValues(alpha: 0.38),
                        ),
              ),
              Icon(
                Icons.access_time,
                size: 20,
                color: isSelected ? primary : onSurface.withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Ux4gTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final bool hasInitialTime;
  final int minuteInterval;

  const _Ux4gTimePickerDialog({
    required this.initialTime,
    required this.hasInitialTime,
    required this.minuteInterval,
  });

  @override
  State<_Ux4gTimePickerDialog> createState() => _Ux4gTimePickerDialogState();
}

class _Ux4gTimePickerDialogState extends State<_Ux4gTimePickerDialog> {
  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAm;
  late bool _hasInteracted;

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late List<int> _minutesList;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hourOfPeriod == 0
        ? 12
        : widget.initialTime.hourOfPeriod;
    _isAm = widget.initialTime.period == DayPeriod.am;
    _hasInteracted = widget.hasInitialTime;

    // Build minutes list based on interval
    _minutesList = [];
    for (int i = 0; i < 60; i += widget.minuteInterval) {
      _minutesList.add(i);
    }

    // Find closest minute index
    int closestMinute = _minutesList.first;
    int minDiff = 60;
    int minuteIndex = 0;
    for (int i = 0; i < _minutesList.length; i++) {
      int diff = (widget.initialTime.minute - _minutesList[i]).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestMinute = _minutesList[i];
        minuteIndex = i;
      }
    }
    _selectedMinute = closestMinute;

    _hourController = FixedExtentScrollController(
      initialItem: _selectedHour - 1,
    );
    _minuteController = FixedExtentScrollController(initialItem: minuteIndex);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    int finalHour = _selectedHour;
    if (_isAm && finalHour == 12) {
      finalHour = 0;
    } else if (!_isAm && finalHour != 12) {
      finalHour += 12;
    }
    Navigator.pop(context, TimeOfDay(hour: finalHour, minute: _selectedMinute));
  }

  void _onCancel() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: surface,
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
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'HH',
                      style:
                          (ux4gTypography?.bM_strong ??
                                  materialTheme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ))
                              ?.copyWith(
                                color: onSurface.withValues(alpha: 0.38),
                              ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'MM',
                      style:
                          (ux4gTypography?.bM_strong ??
                                  materialTheme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ))
                              ?.copyWith(
                                color: onSurface.withValues(alpha: 0.38),
                              ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(), // Empty header for AM/PM
                ),
              ],
            ),
          ),
          Divider(height: 1, color: onSurface.withValues(alpha: 0.12)),

          // Body
          SizedBox(
            height: 250,
            child: Row(
              children: [
                // Hours Column
                Expanded(
                  child: _buildScrollWheel(
                    controller: _hourController,
                    itemCount: 12,
                    itemBuilder: (index) {
                      final hour = index + 1;
                      return _buildWheelItem(
                        text: hour.toString().padLeft(2, '0'),
                        isSelected: hour == _selectedHour,
                        showHighlight: _hasInteracted,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _hasInteracted = true;
                          });
                          _hourController.animateToItem(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        colors: ux4gColors,
                        typography: ux4gTypography,
                        materialTheme: materialTheme,
                      );
                    },
                    onSelectedItemChanged: (index) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedHour = index + 1;
                      });
                    },
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: onSurface.withValues(alpha: 0.12),
                ),

                // Minutes Column
                Expanded(
                  child: _buildScrollWheel(
                    controller: _minuteController,
                    itemCount: _minutesList.length,
                    itemBuilder: (index) {
                      final minute = _minutesList[index];
                      return _buildWheelItem(
                        text: minute.toString().padLeft(2, '0'),
                        isSelected: minute == _selectedMinute,
                        showHighlight: _hasInteracted,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _hasInteracted = true;
                          });
                          _minuteController.animateToItem(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        colors: ux4gColors,
                        typography: ux4gTypography,
                        materialTheme: materialTheme,
                      );
                    },
                    onSelectedItemChanged: (index) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedMinute = _minutesList[index];
                      });
                    },
                  ),
                ),

                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: onSurface.withValues(alpha: 0.12),
                ),

                // AM/PM Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAmPmButton(
                        text: 'AM',
                        isSelected: _isAm,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _isAm = true;
                            _hasInteracted = true;
                          });
                        },
                        colors: ux4gColors,
                        typography: ux4gTypography,
                        materialTheme: materialTheme,
                      ),
                      const SizedBox(height: 16),
                      _buildAmPmButton(
                        text: 'PM',
                        isSelected: !_isAm,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _isAm = false;
                            _hasInteracted = true;
                          });
                        },
                        colors: ux4gColors,
                        typography: ux4gTypography,
                        materialTheme: materialTheme,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: onSurface.withValues(alpha: 0.12)),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Ux4gButton(
                    text: 'Done',
                    variant: Ux4gButtonVariant.primary,
                    onPressed: _hasInteracted ? _onConfirm : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Ux4gButton(
                    text: 'Cancel',
                    variant: Ux4gButtonVariant.outline,
                    onPressed: _onCancel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required Widget Function(int) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 50,
      physics: const FixedExtentScrollPhysics(),
      perspective: 0.00001,
      squeeze: 1.0,
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          if (index < 0 || index >= itemCount) return null;
          return itemBuilder(index);
        },
        childCount: itemCount,
      ),
    );
  }

  Widget _buildWheelItem({
    required String text,
    required bool isSelected,
    required bool showHighlight,
    required VoidCallback onTap,
    required Ux4gColors? colors,
    required Ux4gTypography? typography,
    required ThemeData materialTheme,
  }) {
    final primary = colors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        color: isSelected && showHighlight
            ? primary.withValues(alpha: 0.08)
            : Colors.transparent,
        child: Text(
          text,
          style: (typography?.bM_default ?? materialTheme.textTheme.bodyMedium)
              ?.copyWith(
                color: isSelected && showHighlight ? primary : onSurface,
              ),
        ),
      ),
    );
  }

  Widget _buildAmPmButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required Ux4gColors? colors,
    required Ux4gTypography? typography,
    required ThemeData materialTheme,
  }) {
    final primary = colors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface = colors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: (typography?.bM_default ?? materialTheme.textTheme.bodyMedium)
              ?.copyWith(color: isSelected ? primary : onSurface),
        ),
      ),
    );
  }
}
