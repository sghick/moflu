import 'package:flutter/material.dart';

Duration oneYearDuration = const Duration(days: 366);
Duration tenYearDuration = const Duration(days: 36600);

DateTime timeSince1970 = DateTime.fromMillisecondsSinceEpoch(0);
DateTime oneYearTimeBefore = DateTime.now().subtract(oneYearDuration);
DateTime tenYearTimeAfter = DateTime.now().add(tenYearDuration);

Future<DateTime?> showDateTimePicker(BuildContext context) async {
  DateTime now = DateTime.now();
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: timeSince1970,
    lastDate: now,
  );
  TimeOfDay? timeOfDay;
  if (date != null) {
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      return date.add(Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      ));
    }
  }
  return Future.value();
}
