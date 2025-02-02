import 'package:flutter/material.dart';
import 'package:flutter_local_notification/Services/Notification/local_notifications.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  LocalNotificationServices.showSimpleNotification(
                      title: "Simple Notification",
                      subtitle: "This is Subtitle",
                      payload: "payload");
                },
                child: const Text("Simple Notification"))
          ],
        ),
      ),
    );
  }
}
