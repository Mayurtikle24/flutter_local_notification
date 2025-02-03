import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //Initialize Plugin
  static Future init() async {
    //Request Permission
    requestNotificationPermission();
  }

  static requestNotificationPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  }

  static const _androidNotificationChannal = AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      enableLights: true,
      enableVibration: true,
      playSound: true,
      showBadge: true,
      // sound: UriAndroidNotificationSound("assets/tones/notification.mp3"),
      audioAttributesUsage: AudioAttributesUsage.notification,
      importance: Importance.max);

  Future initializeNotification() async {
    //Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Ios
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      print(payload.payload);
    });

    // Android Platform
    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidNotificationChannal);
  }

  //Simple Notification
  static Future showSimpleNotification(
      {required String title,
      required String subtitle,
      required String payload}) async {
    NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            _androidNotificationChannal.id, _androidNotificationChannal.name,
            importance: Importance.high,
            icon: "mipmap/ic_launcher",
            priority: Priority.high,
            playSound: true,
            // sound: const UriAndroidNotificationSound(
            //     "assets/tones/notification.mp3"),
            enableLights: true,
            enableVibration: true,
            audioAttributesUsage: AudioAttributesUsage.notification,
            colorized: true,
            channelDescription: _androidNotificationChannal.description),
        iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active));
    await _flutterLocalNotificationsPlugin
        .show(0, title, subtitle, notificationDetails, payload: payload);
  }

  static Future periodicNotificatio(
      {required String title,
      required String subtitle,
      required String payload}) async {
    NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            _androidNotificationChannal.id, _androidNotificationChannal.name,
            importance: Importance.high,
            icon: "mipmap/ic_launcher",
            priority: Priority.high,
            playSound: true,
            // sound: const UriAndroidNotificationSound(
            //     "assets/tones/notification.mp3"),
            enableLights: true,
            enableVibration: true,
            audioAttributesUsage: AudioAttributesUsage.notification,
            colorized: true,
            channelDescription: _androidNotificationChannal.description),
        iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active));

    await _flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
        1, title, subtitle, Duration(minutes: 1), notificationDetails);
  }

  static Future cancleNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future cancleAllNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
