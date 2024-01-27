import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/preliminary/screens/splash_page.dart';
import 'package:ojembaa_courier/firebase_options.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const ProviderScope(child: MyApp()));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ojembaa Courier',
      theme: ThemeData(
          fontFamily: "QanelasSoft",
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.white_background,
            centerTitle: true,
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
              .copyWith(background: AppColors.primary_light)),
      home: const SplashPage(),
    );
  }
}
