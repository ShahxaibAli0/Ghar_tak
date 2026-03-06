class appNotification {

  final String title;
  final String message;
  final DateTime time;

  appNotification({
    required this.title,
    required this.message,
    required this.time,
  });
}

// Global list
List<appNotification> appNotifications = [];