import 'package:intl/intl.dart';

extension PostStringFormat on String {
  //이메일 포맷 검증
  String toSimpleTime() {
    DateTime now = DateTime.now().toLocal();
    DateTime beforeHour = DateTime.now().toLocal().subtract(const Duration(hours: 1));
    DateTime todayStart = DateTime(now.year, now.month, now.day);

    DateTime dateTime = DateTime.parse(this).toLocal();

    if (dateTime.isAfter(beforeHour)) {
      // 1시간 이내
      var gapMinute = (now.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch) / 60000;
      if (gapMinute < 2) return "방금전";
      return "${gapMinute.toInt()}분 전";
    } else if (dateTime.isAfter(todayStart)) {
      // 오늘
      return DateFormat.Hm().format(dateTime);
    } else {
      // 그 이전
      return DateFormat.Md().format(dateTime);
    }
  }

  String toSimpleContent(int maxLines) {
    if (split('\n').length > maxLines) {
      var newContent = split('\n').sublist(0, maxLines).join('\n');
      return "$newContent…";
    } else {
      return this;
    }
  }
}
