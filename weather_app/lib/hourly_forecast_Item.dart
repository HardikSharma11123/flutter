import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String timee;
  final String temp;
  final IconData icon;
  const HourlyForecastItem(
      {super.key, required this.timee, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 6,
        child: Container(
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                timee,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                icon,
                size: 35,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "$temp °C",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
