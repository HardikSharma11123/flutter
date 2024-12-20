import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final mobilescreenlayout;
  final webscreenlayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobilescreenlayout,
      required this.webscreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return webscreenlayout;
        }
        return mobilescreenlayout;
      },
    );
  }
}
