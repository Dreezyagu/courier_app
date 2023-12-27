import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/preliminary/screens/splash_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
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
