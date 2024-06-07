import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_date_range_picker/scrollable_date_range_picker.dart';

void main() {
  runApp(const CalendarApp());
}

ValueNotifier<bool> darkThemeNotifier = ValueNotifier(false);

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: darkThemeNotifier,
        builder: (context, value, _) {
          return MaterialApp(
            themeMode: value ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: const HomeScreen(),
          );
        });
  }
}

// Home screen UI
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scrollable Date Range Picker"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Default(),
                ));
              },
              child: const Text("Default"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Customized(),
                ));
              },
              child: const Text("Customized"),
            ),
          ],
        ),
      ),
    );
  }
}

class Default extends StatelessWidget {
  const Default({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: darkThemeNotifier,
            builder: (context, value, _) {
              return Text("Default- ${value ? "Dark mode" : "Light mode"}");
            }),
        actions: [
          ValueListenableBuilder(
              valueListenable: darkThemeNotifier,
              builder: (context, value, _) {
                return IconButton(
                  onPressed: () {
                    darkThemeNotifier.value = !darkThemeNotifier.value;
                  },
                  icon: Icon(
                    value ? Icons.dark_mode : Icons.light_mode,
                  ),
                );
              })
        ],
      ),
      body: ScrollableDateRangePicker(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onDateRangeSelect: (startDate, endDate) {},
      ),
    );
  }
}

class Customized extends StatelessWidget {
  const Customized({super.key});

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => const DateRangePickerBottmSheet(),
              );
            },
            child: const Text("Show Date Range Picker"),
          ),
        ));
  }
}

class DateRangePickerBottmSheet extends StatefulWidget {
  const DateRangePickerBottmSheet({
    super.key,
  });

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              color: Color.fromARGB(155, 1, 14, 194),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            dateTexStyle: const TextStyle(color: Colors.white),
            endDateDecoration: const BoxDecoration(
              color: Color.fromARGB(155, 1, 14, 194),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
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
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              color: Color(0x84344054),
            ),
          ),
          Expanded(
              child: Center(
            child: Visibility(
              visible: dateRange != null,
              child: Text(
                "$dateRange",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
