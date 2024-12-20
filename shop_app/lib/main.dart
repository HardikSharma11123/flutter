import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';
import 'package:shop_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
          title: "Shopping App",
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(255, 205, 46, 46),
              primary: const Color.fromARGB(255, 249, 95, 6),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            textTheme: const TextTheme(
                titleLarge:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                titleMedium:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                bodySmall:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            useMaterial3: true,
          ),
          home: const HomePage()),
    );
  }
}
