import 'package:flutter/material.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/responsive_layout.dart';
import 'package:whatsapp/screens/mobile_screen_layout.dart';
import 'package:whatsapp/screens/web_screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: "Whatsapp",
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: const ResponsiveLayout(
          mobilescreenlayout: MobileScreenLayout(),
          webscreenlayout: WebScreenLayout()),
    );
  }
}
