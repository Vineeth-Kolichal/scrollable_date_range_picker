import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScrollableDateRangePicker extends StatefulWidget {
  /// A callback function that is triggered when a date range is selected.
  /// It receives the start date and end date as parameters.
  /// [onDateRangeSelect]
  final Function(DateTime? startDate, DateTime? endDate) onDateRangeSelect;

  /// Sets the background color of the widget container.
  /// [backgroundColor]
  final Color? backgroundColor;

  /// Specifies the color of the dividers that separate the weeks and months.
  /// [dividerColor]
  final Color? dividerColor;

  /// Defines the text style for the weekday headings (Su, Mo, Tu, etc.).
  /// [weekDayHeadingStyle]
  final TextStyle? weekDayHeadingStyle;

  /// Sets the text style for the dates displayed in the calendar grid.
  /// [dateTexStyle]
  final TextStyle? dateTexStyle;

  /// Specifies the text style for the month headings (e.g., Jan 2024).
  /// [monthHeadingStyle]
  final TextStyle? monthHeadingStyle;

  /// Defines the text style for the current day (today's date) in the calendar grid.
  /// [currentDayTextStyle]
  final TextStyle? currentDayTextStyle;

  /// Sets the text style for dates that are disabled (i.e., before the [calendarStartDate]
  /// or after the [calendarEndDate]).
  /// [disabledDaysTextStyle]
  final TextStyle? disabledDaysTextStyle;

  /// Provides a decoration (e.g., background color, border) for the current day
  /// (today's date) in the calendar grid.
  /// [currentDayDecoration]
  final BoxDecoration? currentDayDecoration;

  /// Specifies the decoration for the selected start date in the range.
  /// [startDateDecoration]
  final BoxDecoration? startDateDecoration;

  /// Defines the decoration for the selected end date in the range.
  /// [endDateDecoration]
  final BoxDecoration? endDateDecoration;

  /// Sets the decoration for the dates between the start and end dates (the selected range).
  /// [rangeDatesDecoration]
  final BoxDecoration? rangeDatesDecoration;

  /// Sets the height of the scrollable area containing the date range picker.
  /// [height]
  final double? height;

  /// Defines the width of the scrollable area containing the date range picker.
  /// [width]
  final double? width;

  /// Specifies the padding around the widget container.
  /// [padding]
  final EdgeInsetsGeometry? padding;

  /// Defines the earliest date selectable in the calendar. Dates before this
  /// will be disabled.
  /// [calendarStartDate]
  final DateTime? calendarStartDate;

  /// Defines the latest date selectable in the calendar. Dates after this
  /// will be disabled.
  /// [calendarEndDate]
  final DateTime? calendarEndDate;

  /// A boolean that determines whether the weekday header remains fixed at the
  /// top of the widget. If true, the weekday header will stay at the top, and only the dates will scroll.
  /// If false, the weekday header will scroll along with the dates.
  /// [isFixedTopWeekDayHeader]
  final bool isFixedTopWeekDayHeader;

  const ScrollableDateRangePicker({
    super.key,
    required this.onDateRangeSelect,
    this.backgroundColor,
    this.dividerColor,
    this.weekDayHeadingStyle,
    this.dateTexStyle,
    this.monthHeadingStyle,
    this.currentDayTextStyle,
    this.currentDayDecoration,
    this.startDateDecoration,
    this.endDateDecoration,
    this.rangeDatesDecoration,
    this.height,
    this.width,
    this.padding,
    this.calendarStartDate,
    this.calendarEndDate,
    this.isFixedTopWeekDayHeader = true,
    this.disabledDaysTextStyle,
  });

  @override
  State<ScrollableDateRangePicker> createState() =>
      _ScrollableDateRangePickerState();
}

class _ScrollableDateRangePickerState extends State<ScrollableDateRangePicker> {
  DateTime today = DateTime.now();
  DateTime? firstDate;
  DateTime? lastDate;

  List<DateTime?> _generateDaysInMonth(DateTime currentMonth) {
    List<DateTime?> allDaysInMonth = [];
    DateTime firstDayOfMonth =
        DateTime(currentMonth.year, currentMonth.month, 1);
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    if (firstDayOfMonth.weekday != 7) {
      for (int i = 0; i < firstDayOfMonth.weekday; i++) {
        allDaysInMonth.add(null);
      }
    }

    for (int i = 0; i < daysInMonth; i++) {
      allDaysInMonth.add(firstDayOfMonth.add(Duration(days: i)));
    }

    return allDaysInMonth;
  }

  Widget _buildDaysOfWeek() {
    List<String> daysOfWeek = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return Column(
      children: [
        Divider(
          color: widget.dividerColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysOfWeek
              .map((day) => Text(
                    day,
                    style: widget.weekDayHeadingStyle,
                  ))
              .toList(),
        ),
        Divider(
          color: widget.dividerColor,
        ),
      ],
    );
  }

  BoxDecoration? _getDateDecoration(DateTime? day) {
    if (day == firstDate) {
      return widget.startDateDecoration ??
          const BoxDecoration(
              color: Color.fromARGB(155, 0, 150, 62),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ));
    } else if (day == lastDate) {
      return widget.endDateDecoration ??
          const BoxDecoration(
              color: Color.fromARGB(155, 0, 150, 62),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ));
    } else if (firstDate != null &&
        lastDate != null &&
        day!.isAfter(firstDate!) &&
        day.isBefore(lastDate!)) {
      return widget.rangeDatesDecoration ??
          const BoxDecoration(
            color: Color(0x6AAFAFAF),
          );
    }
    if (day == DateTime(today.year, today.month, today.day)) {
      return widget.currentDayDecoration ??
          const BoxDecoration(
            color: Color.fromARGB(28, 0, 150, 62),
            shape: BoxShape.circle,
          );
    } else {
      return null;
    }
  }

  TextStyle? _getDateTextStyle(DateTime? day) {
    if (day == DateTime(today.year, today.month, today.day)) {
      return widget.currentDayTextStyle ??
          const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w700,
          );
    } else if (day != null &&
        widget.calendarStartDate != null &&
        day.isBefore(widget.calendarStartDate!)) {
      return widget.disabledDaysTextStyle ??
          const TextStyle(color: Colors.grey);
    } else if (day != null &&
        widget.calendarEndDate != null &&
        day.isAfter(widget.calendarEndDate!)) {
      return widget.disabledDaysTextStyle ??
          const TextStyle(color: Colors.grey);
    } else {
      return widget.dateTexStyle;
    }
  }

  Widget _buildDaysGrid(DateTime currentMonth) {
    List<DateTime?> daysInMonth = _generateDaysInMonth(currentMonth);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isFixedTopWeekDayHeader)
            Divider(
              color: widget.dividerColor,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              DateFormat.yMMM().format(currentMonth),
              style: widget.monthHeadingStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          if (!widget.isFixedTopWeekDayHeader) _buildDaysOfWeek(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daysInMonth.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                DateTime? day = daysInMonth[index];
                if (day == null) {
                  return const SizedBox();
                } else {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (widget.calendarEndDate != null &&
                                day.isAfter(widget.calendarEndDate!)) ||
                            (widget.calendarStartDate != null &&
                                day.isBefore(widget.calendarStartDate!.copyWith(
                                    day: widget.calendarStartDate!.day - 1)))
                        ? null
                        : () {
                            setState(() {
                              if (firstDate != null && lastDate != null) {
                                firstDate = null;
                                lastDate = null;
                              }
                              if (firstDate == null) {
                                firstDate = day;
                              } else if (lastDate == null &&
                                  day.isAfter(firstDate!)) {
                                lastDate = day;
                                widget.onDateRangeSelect(firstDate, lastDate);
                              } else {
                                firstDate = day;
                              }
                            });
                          },
                    child: Container(
                      decoration: _getDateDecoration(day),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: _getDateTextStyle(day),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      color: widget.backgroundColor ?? Colors.white,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.5,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isFixedTopWeekDayHeader) _buildDaysOfWeek(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildDaysGrid(DateTime(today.year, today.month - index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
