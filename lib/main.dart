import 'dart:io';

import 'package:flutter/material.dart';
import 'package:theunion/pages/Home/splash_page.dart';
import 'package:theunion/resources/colors.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Union',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: BACKGROUND_COLOR,
          colorScheme: ColorScheme.fromSeed(seedColor: BACKGROUND_COLOR),
          appBarTheme: const AppBarTheme(backgroundColor: PRIMARY_COLOR),
          primaryColor: INPUT_COLOR,
          useMaterial3: true),
      home: SplashPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
