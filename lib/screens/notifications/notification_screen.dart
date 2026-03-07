import 'package:flutter/material.dart';
import '../../models/notifications_model.dart';
import '../../data/notification_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.green,
      ),

      body: appNotifications.isEmpty
          ? const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(fontSize: 18),
              ),
            )

          : ListView.builder(
              itemCount: appNotifications.length,

              itemBuilder: (context, index) {

                NotificationModel notification = appNotifications[index];

                return ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.green,
                  ),

                  title: Text(notification.title),
                  subtitle: Text(notification.message),

                  trailing: Text(
                    notification.time,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}