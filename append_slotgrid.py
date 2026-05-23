import os

path = r"C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories\data_stories.dart"

addition = r"""

// ── SlotGrid ──────────────────────────────────────────────────────────────────

final slotGridComponent = WidgetbookComponent(
  name: 'SlotGrid',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(builder: (ctx, setState) {
          final data = SlotGridData(
            year: 2026,
            month: 5,
            today: DateTime(2026, 5, 21),
            selectedDate: selected,
            weeklyOffWeekdays: const [6, 7],
            viewMode: SlotPickerViewMode.expanded,
          );
          return ComponentDocs(
            name: 'SlotGrid',
            description:
                'A calendar-style date picker that marks dates as available, '
                'no-slots, public holiday, or weekly-off. '
                'Optionally opens a time-slot bottom sheet when a date is tapped.',
            code: '''// Build the data model
final data = SlotGridData(
  year: 2026,
  month: 5,
  today: DateTime(2026, 5, 21),
  selectedDate: _selected,
  weeklyOffWeekdays: const [6, 7],
  dates: [
    SlotDateEntry(date: DateTime(2026, 5, 1),  status: SlotDateStatus.publicHoliday),
    SlotDateEntry(date: DateTime(2026, 5, 14), status: SlotDateStatus.noSlots),
  ],
  allowTapOnPublicHoliday: false,
  allowTapOnWeeklyOff: false,
  viewMode: SlotPickerViewMode.expanded,
);

SlotGrid(
  data: data,
  onDateSelected: (date) => setState(() => _selected = date),
  onMonthChanged: (year, month) { /* fetch data for new month */ },
  timeSlotProvider: (date) => [
    SlotTimeEntry(time: '09:00 AM', slotCount: 3),
    SlotTimeEntry(time: '11:00 AM', slotCount: 1, status: SlotTimeStatus.limited),
    SlotTimeEntry(time: '02:00 PM', slotCount: 0, status: SlotTimeStatus.noSlots),
  ],
  onSlotConfirmed: (date, slot) { /* booking confirmed */ },
);''',
            props: const [
              PropRow(name: 'data', type: 'SlotGridData', description: 'Calendar data model (year, month, dates, view mode).', required: true),
              PropRow(name: 'onDateSelected', type: 'ValueChanged<DateTime>?', description: 'Called when user taps an available date (no timeSlotProvider).'),
              PropRow(name: 'onMonthChanged', type: 'void Function(int year, int month)?', description: 'Called when the prev/next month arrow is tapped.'),
              PropRow(name: 'timeSlotProvider', type: 'List<SlotTimeEntry> Function(DateTime)?', description: 'Supply time slots — auto-opens SlotTimePickerSheet on date tap.'),
              PropRow(name: 'onSlotConfirmed', type: 'void Function(DateTime, SlotTimeEntry)?', description: 'Called when the user confirms a time slot.'),
            ],
            child: SingleChildScrollView(
              child: SlotGrid(
                data: data,
                onDateSelected: (date) => setState(() => selected = date),
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'With holidays & no-slots',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(builder: (ctx, setState) {
          final data = SlotGridData(
            year: 2026,
            month: 5,
            today: DateTime(2026, 5, 21),
            selectedDate: selected,
            weeklyOffWeekdays: const [6, 7],
            dates: const [
              SlotDateEntry(date: DateTime(2026, 5, 1),  status: SlotDateStatus.publicHoliday),
              SlotDateEntry(date: DateTime(2026, 5, 9),  status: SlotDateStatus.publicHoliday),
              SlotDateEntry(date: DateTime(2026, 5, 14), status: SlotDateStatus.noSlots),
              SlotDateEntry(date: DateTime(2026, 5, 19), status: SlotDateStatus.noSlots),
            ],
            viewMode: SlotPickerViewMode.expanded,
          );
          return ComponentDocs(
            name: 'SlotGrid - Holidays and No-Slots',
            description:
                'publicHoliday and noSlots dates are styled differently and '
                'are non-interactive by default.',
            code: '''SlotGridData(
  year: 2026, month: 5,
  weeklyOffWeekdays: [6, 7],
  dates: [
    SlotDateEntry(date: DateTime(2026, 5, 1),  status: SlotDateStatus.publicHoliday),
    SlotDateEntry(date: DateTime(2026, 5, 14), status: SlotDateStatus.noSlots),
  ],
  viewMode: SlotPickerViewMode.expanded,
);''',
            child: SingleChildScrollView(
              child: SlotGrid(
                data: data,
                onDateSelected: (date) => setState(() => selected = date),
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'With time slots',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(builder: (ctx, setState) {
          final data = SlotGridData(
            year: 2026,
            month: 5,
            today: DateTime(2026, 5, 21),
            selectedDate: selected,
            weeklyOffWeekdays: const [6, 7],
            viewMode: SlotPickerViewMode.expanded,
          );
          return ComponentDocs(
            name: 'SlotGrid - Time Slots',
            description:
                'When timeSlotProvider is set, tapping an available date '
                'automatically opens the SlotTimePickerSheet bottom sheet.',
            code: '''SlotGrid(
  data: data,
  timeSlotProvider: (date) => [
    SlotTimeEntry(time: '09:00 AM', slotCount: 3),
    SlotTimeEntry(time: '11:00 AM', slotCount: 1, status: SlotTimeStatus.limited),
    SlotTimeEntry(time: '02:00 PM', slotCount: 0, status: SlotTimeStatus.noSlots),
  ],
  onSlotConfirmed: (date, slot) { /* booking confirmed */ },
);''',
            child: SingleChildScrollView(
              child: SlotGrid(
                data: data,
                onDateSelected: (date) => setState(() => selected = date),
                timeSlotProvider: (date) => const [
                  SlotTimeEntry(time: '09:00 AM', slotCount: 3),
                  SlotTimeEntry(time: '11:00 AM', slotCount: 1, status: SlotTimeStatus.limited),
                  SlotTimeEntry(time: '02:00 PM', slotCount: 0, status: SlotTimeStatus.noSlots),
                ],
                onSlotConfirmed: (date, slot) {},
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'JSON data source',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(builder: (ctx, setState) {
          final data = SlotGridData.fromJson({
            'year': 2026,
            'month': 6,
            'today': '2026-06-01',
            'weeklyOffWeekdays': [6, 7],
            'viewMode': 'compact',
            'dates': [
              {'date': '2026-06-05', 'status': 'publicHoliday'},
              {'date': '2026-06-12', 'status': 'noSlots'},
            ],
          });
          return ComponentDocs(
            name: 'SlotGrid - JSON',
            description:
                'SlotGridData.fromJson() deserialises a server response directly. '
                'viewMode can be "expanded" or "compact".',
            code: '''final data = SlotGridData.fromJson({
  "year": 2026,
  "month": 6,
  "today": "2026-06-01",
  "weeklyOffWeekdays": [6, 7],
  "viewMode": "compact",
  "dates": [
    { "date": "2026-06-05", "status": "publicHoliday" },
    { "date": "2026-06-12", "status": "noSlots" },
  ],
});

SlotGrid(data: data, onDateSelected: (d) {});''',
            child: SingleChildScrollView(
              child: SlotGrid(
                data: data,
                onDateSelected: (date) => setState(() => selected = date),
              ),
            ),
          );
        });
      },
    ),
  ],
);
"""

with open(path, 'a', encoding='utf-8') as f:
    f.write(addition)

print("Done")
