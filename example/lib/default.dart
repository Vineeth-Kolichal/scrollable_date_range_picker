import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_date_range_picker/scrollable_date_range_picker.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onDateRangeSelect: (startDate, endDate) {},
      ),
    );
  }
}
