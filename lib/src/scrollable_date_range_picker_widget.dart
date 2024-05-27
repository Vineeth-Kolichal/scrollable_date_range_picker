import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScrollableDateRangePicker extends StatefulWidget {
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
  final Function(DateTime? startDate, DateTime? endDate) onDateRangeSelect;
  final Color? backgroundColor;
  final Color? dividerColor;
  final TextStyle? weekDayHeadingStyle;
  final TextStyle? dateTexStyle;
  final TextStyle? monthHeadingStyle;
  final TextStyle? currentDayTextStyle;
  final TextStyle? disabledDaysTextStyle;
  final BoxDecoration? currentDayDecoration;
  final BoxDecoration? startDateDecoration;
  final BoxDecoration? endDateDecoration;
  final BoxDecoration? rangeDatesDecoration;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final DateTime? calendarStartDate;
  final DateTime? calendarEndDate;
  final bool isFixedTopWeekDayHeader;

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
                                firstDate = day;
                                lastDate = null;
                              } else if (firstDate != null &&
                                  firstDate!.isBefore(day)) {
                                lastDate = day;
                                widget.onDateRangeSelect(firstDate, lastDate);
                              } else {
                                firstDate = day;
                                lastDate = null;
                              }
                            });
                          },
                    child: Container(
                      margin: EdgeInsets.zero,
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

  int calculateMonthsDifference(DateTime startDate, DateTime endDate) {
    int yearDiff = endDate.year - startDate.year;
    int monthDiff = endDate.month - startDate.month;
    int toalMonths = yearDiff * 12 + monthDiff;
    return toalMonths + 1;
  }

  @override
  Widget build(BuildContext context) {
    DateTime startingMonth =
        widget.calendarStartDate ?? DateTime(today.year, today.month, 1);
    DateTime endDate = widget.calendarEndDate ??
        DateTime(
            startingMonth.year + 1, startingMonth.month, startingMonth.day);
    int numOfMonths = calculateMonthsDifference(startingMonth, endDate);
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Container(
        color: widget.backgroundColor,
        child: Column(
          children: [
            if (widget.isFixedTopWeekDayHeader) _buildDaysOfWeek(),
            SizedBox(
              height: widget.height ?? MediaQuery.sizeOf(context).height * 0.8,
              width: widget.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _buildDaysGrid(DateTime(
                          startingMonth.year, startingMonth.month + index, 1)),
                    ],
                  );
                },
                itemCount: numOfMonths,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
