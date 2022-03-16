// seconds
int daysFrom(int? fromTime, int? endTime) {
  int misOfADay = 24 * 60 * 60;
  int fromDays = (fromTime ?? 0) ~/ misOfADay;
  int endDays = (endTime ?? 0) ~/ misOfADay;
  return endDays - fromDays;
}

// seconds
int daysFromNow(int? fromTime) {
  return daysFrom(fromTime, DateTime.now().millisecondsSinceEpoch ~/ 1000);
}

extension DateTimeExt on DateTime {
  int get secondsSinceEpoch {
    return this.millisecondsSinceEpoch ~/ 1000;
  }
}
