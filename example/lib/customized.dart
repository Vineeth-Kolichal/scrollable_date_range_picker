import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_date_range_picker/scrollable_date_range_picker.dart';

class Customized extends StatelessWidget {
  const Customized({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customized"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: const Color(0xFF182230),
                showDragHandle: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => DateRangePickerBottmSheet(size: size),
              );
            },
            child: const Text("Customized "),
          ),
        ));
  }
}

class DateRangePickerBottmSheet extends StatefulWidget {
  const DateRangePickerBottmSheet({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<DateRangePickerBottmSheet> createState() =>
      _DateRangePickerBottmSheetState();
}

class _DateRangePickerBottmSheetState extends State<DateRangePickerBottmSheet> {
  DateTime? start;
  DateTime? end;
  String? dateRange;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      height: size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Date",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ScrollableDateRangePicker(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: size.height * 0.6,
            onDateRangeSelect: (startDate, endDate) {
              setState(() {
                final format = DateFormat('d MMM yyyy');
                dateRange =
                    "Selected range : ${format.format(startDate!)} - ${format.format(endDate!)}";
              });
            },
            calendarStartDate: DateTime.now(),
            currentDayTextStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
            backgroundColor: const Color(0xFF182230),
            weekDayHeadingStyle:
                TextStyle(color: Colors.white.withOpacity(0.5)),
            startDateDecoration: const BoxDecoration(
              color: Color.fromARGB(155, 0, 150, 62),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            dateTexStyle: const TextStyle(color: Colors.white),
            endDateDecoration: const BoxDecoration(
              color: Color.fromARGB(155, 0, 150, 62),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            dividerColor: const Color(0x84344054),
            monthHeadingStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            rangeDatesDecoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.123),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              color: const Color(0x84344054),
            ),
          ),
          Expanded(
              child: Center(
            child: Visibility(
              visible: dateRange != null,
              child: Text(
                "$dateRange",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
