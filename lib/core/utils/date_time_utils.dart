class DateTimeUtils {
  static String formatTimeToDurationString(DateTime dateTime) {
    DateTime now = DateTime.now();
    bool isDateEquals = now.day == dateTime.day;
    bool isHourEqual = now.hour == dateTime.hour;
    bool isMinuteEquals = now.minute == dateTime.minute;
    bool isMonthEqual = now.month == dateTime.month;
    bool isYearEquals = now.year == dateTime.year;

    if (isDateEquals && isHourEqual && isMinuteEquals && isYearEquals && isMonthEqual) {
      return "just now";
    }
    if (isYearEquals && isMonthEqual && isDateEquals && isHourEqual) {
      int minute = now.minute - dateTime.minute;
      return '$minute min ago';
    }

    if (isYearEquals && isMonthEqual && isDateEquals) {
      int hour = now.hour - dateTime.hour;
      return '$hour hr ago';
    }

    if (isYearEquals && isMonthEqual) {
      int day = now.day - dateTime.day;
      return "$day day ago";
    }

    if (isYearEquals) {
      int month = now.month - dateTime.month;
      return "$month mon ago";
    }

    int diffYear = now.year - dateTime.year;
    int diffMonth = now.month - dateTime.month;
    return '$diffYear year and $diffMonth mon ago';
  }
}
