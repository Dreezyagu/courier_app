import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';

class NotificationsUtil {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void setUpFirebaseMessaging() async {
    WidgetsFlutterBinding.ensureInitialized();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: true);

    _firebaseMessaging.getToken().then((token) {
      StorageHelper.setString(StorageKeys.fcmToken, token);
      // tokenRepository.persistFCMToken(token!);
    });

    await _firebaseMessaging.subscribeToTopic('all');

    // handle foreground notification.  
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // CustomerIO.messagingPush()
      //     .onMessageReceived(event.toMap())
      //     .then((handled) {
      //   return handled;
      // });

      // return;
    });

    _firebaseMessaging.getInitialMessage().then((value) {
      if (value != null) {
        // DeepLinkUtils.updateApp(value.data);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // DeepLinkUtils.updateApp(message.data);
    });

//handle background notification
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  void setUpFlutterLocalNotificationPlugin() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/notification_icon');

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // showCupertinoDialog(
    //     context: context,
    //     builder: (_) {
    //       return CupertinoAlertDialog(
    //         title: Text(
    //           title!,
    //           textAlign: TextAlign.center,
    //         ),
    //         content: Text(
    //           body!,
    //           textAlign: TextAlign.center,
    //         ),
    //         actions: <Widget>[
    //           CupertinoButton.filled(
    //               child: const Text('CLOSE'),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               }),
    //         ],
    //       );
    //     });
  }

  Future onSelectNotification(String? payload) async {}

  Future<void> myBackgroundMessageHandler(RemoteMessage remoteMessage) async {
    await Firebase.initializeApp();
    if (remoteMessage.notification != null) {
      displayLocalNotification(remoteMessage.notification!);
    }
  }

  void displayLocalNotification(RemoteNotification message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'Important', 'Earnipay Notification',
        channelDescription: 'Receive important push notification from Earnipay',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(presentAlert: true, presentBadge: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, message.body, message.title, platformChannelSpecifics,
        payload: 'payload');
  }
}
