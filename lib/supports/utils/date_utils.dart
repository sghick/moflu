import 'package:moflu/supports/utils/common_utils.dart';

String formatDetailDay(String pattern, int dateInSeconds) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInSeconds * 1000);
  DateTime todayDate = DateTime.now();
  String detailDay = '';
  if (date.year == todayDate.year && date.month == todayDate.month) {
    if (date.day == todayDate.day - 2) {
      detailDay = "前天";
    }
    if (date.day == todayDate.day - 1) {
      detailDay = "昨天";
    }
    if (date.day == todayDate.day) {
      detailDay = "今天";
    }
    if (date.day == todayDate.day + 1) {
      detailDay = "明天";
    }
    if (date.day == todayDate.day + 2) {
      detailDay = "后天";
    }
  }
  return dateInSeconds.formatDateString(pattern) +
      (detailDay.isNotEmpty ? '($detailDay)' : '');
}

DateTime resetTime(
  DateTime time, {
  int? year,
  int? month,
  int? day,
  int? hour,
  int? minute,
  int? second,
  int? millisecond,
  int? microsecond,
}) {
  return DateTime(
    year ?? time.year,
    month ?? time.month,
    day ?? time.day,
    hour ?? time.hour,
    minute ?? time.minute,
    second ?? time.second,
    millisecond ?? time.millisecond,
    microsecond ?? time.microsecond,
  );
}

DateTime trimDay(DateTime time) {
  return DateTime(time.year, time.month, time.day);
}
