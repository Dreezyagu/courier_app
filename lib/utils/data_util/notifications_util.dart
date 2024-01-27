import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class NotificationsUtil {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setUpFirebaseMessaging(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    await _firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: true);

    _firebaseMessaging.getToken().then((token) {
      StorageHelper.setString(StorageKeys.fcmToken, token);
    });

    await _firebaseMessaging.subscribeToTopic('all');

    // handle foreground notification.
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      CustomSnackbar.showInfoSnackBar(context,
          message: event.notification!.body!,
          title: event.notification!.title!);
    });

    // _firebaseMessaging.getInitialMessage().then((value) {
    //   if (value != null) {
    //     // DeepLinkUtils.updateApp(value.data);
    //   }
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   // DeepLinkUtils.updateApp(message.data);
    // });
  }
}
