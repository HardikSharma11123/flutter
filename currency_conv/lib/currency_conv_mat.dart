// ignore: unused_import
import 'dart:ffi' as ffi;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyConvMat1 extends StatefulWidget {
  const CurrencyConvMat1({super.key});
  @override
  State createState() => _CurrencyConvMatstate();
}

class _CurrencyConvMatstate extends State {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(60),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          title: const Text("Currency Convertor"),
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " ${result != 0 ? result.toStringAsFixed(3) : result.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextField(
                  controller: textEditingController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Please enter the amount in USD",
                    prefixIcon: const Icon(Icons.monetization_on),
                    hintStyle: const TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Colors.teal,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      setState(() {
                        result = double.parse(textEditingController.text) * 81;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 15,
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Convert"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
