class DateFormatter {
  static final Map<int, String> weekDayFull = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };

  static Map<int, String> months = {
    1: "يناير",
    2: "فبراير",
    3: "مارس",
    4: "أبريل",
    5: "مايو",
    6: "يونيو",
    7: "يوليو",
    8: "أغسطس",
    9: "سبتمبر",
    10: "أكتوبر",
    11: "نوفمبر",
    12: "ديسمبر",
  };

  static String formatDate(DateTime dateTime) {
    return '${dateTime.day} ${months[dateTime.month]}, ${dateTime.year}';
  }

  static DateTime get currantUTCDate {
    DateTime date = DateTime.now().toUtc();
    return date;
  }

  static String formatPublishTime(DateTime publishedTime) {
    // Convert both times to UTC for consistent comparison
    // DateTime now = DateTime.now().toUtc();
    // DateTime utcPublishTime = publishedTime.toUtc();
    // Duration duration = now.difference(utcPublishTime);
    // String formattedDuration = '';

    // if (duration.inDays > 2) {
    //   formattedDuration = 'البارحة';
    // } else if (duration.inHours >= 1) {
    //   formattedDuration = 'اليوم';
    // } else {
    // }

    // formattedDuration = formatDate(publishedTime);
    return formatDate(publishedTime);
  }

  static String formatNotificationTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
