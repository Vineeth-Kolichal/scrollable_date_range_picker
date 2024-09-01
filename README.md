# Scrollable Date Range Picker

A Flutter package that provides a customizable scrollable date range picker. This widget allows users to select a range of dates, and it can be easily integrated into any Flutter application.

## Features

- Scrollable date range picker.
- Customizable styles for dates, month headings, weekdays, and decorations.
- Supports disabling dates outside a specific range.
- Option to fix the weekday header at the top or scroll with the dates.

## Installation

Add the following line to your `pubspec.yaml` under dependencies:

```yaml
dependencies:
  scrollable_date_range_picker: ^0.0.1 
```

Then run `flutter pub get` to install the package.

Usage
-----

Import the package in your Dart file:

dart

Copy code

`import 'package:scrollable_date_range_picker/scrollable_date_range_picker.dart';`

### Example

Here's a basic example of how to use the `ScrollableDateRangePicker`:

```dart
import 'package:flutter/material.dart';
import 'package:scrollable_date_range_picker/scrollable_date_range_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   
 MaterialApp(
      home: Scaffold(
        appBar: AppBar(   

          title: Text('Date Range Picker'),
        ),
        body: Center(
          child: ScrollableDateRangePicker(
            onDateRangeSelect: (startDate, endDate) => print('Selected range: $startDate - $endDate'),
          ),
        ),
      ),
    );
  }
}
```
### Customization

The `ScrollableDateRangePicker` offers several properties for customization:

-   `onDateRangeSelect`: Callback when a date range is selected.
-   `backgroundColor`: Background color of the picker.
-   `dividerColor`: Color of the dividers between weeks and months.
-   `weekDayHeadingStyle`: Style for the weekday headings.
-   `dateTexStyle`: Style for the dates.
-   `monthHeadingStyle`: Style for the month headings.
-   `currentDayTextStyle`: Style for the current day.
-   `disabledDaysTextStyle`: Style for disabled dates.
-   `currentDayDecoration`: Decoration for the current day.
-   `startDateDecoration`: Decoration for the start date.
-   `endDateDecoration`: Decoration for the end date.
-   `rangeDatesDecoration`: Decoration for the dates in the selected range.
-   `height`: Height of the picker.
-   `width`: Width of the picker.
-   `padding`: Padding around the picker.
-   `calendarStartDate`: Earliest selectable date.
-   `calendarEndDate`: Latest selectable date.
-   `isFixedTopWeekDayHeader`: Whether to fix the weekday header at the top.

Contributing
------------

Contributions are welcome! Please submit a pull request or open an issue on GitHub if you have any improvements or suggestions.

License
-------

This project is licensed under the BSD 3-Clause License- see the LICENSE file for details.