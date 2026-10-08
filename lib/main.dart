import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/extra/pageView.dart';
import 'package:owais_project/extra/tab_bar.dart';
import 'package:owais_project/screens/auth_screen/login.dart';
import 'package:owais_project/screens/home/beverages.dart';
import 'package:owais_project/screens/home/bottom_bar.dart';
import 'package:owais_project/screens/home/explore.dart';
import 'package:owais_project/screens/home/favorite.dart';
import 'package:owais_project/screens/home/filter.dart';
import 'package:owais_project/screens/home/home.dart';
import 'package:owais_project/screens/home/my_cart.dart';
import 'package:owais_project/screens/profile/profile.dart';
import 'package:owais_project/screens/start_screen/onBoarding_screen.dart';
import 'package:owais_project/screens/start_screen/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // Device Preview settings
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: PageViewScreen(),
    );
  }
}