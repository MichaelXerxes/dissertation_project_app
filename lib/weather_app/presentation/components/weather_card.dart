import 'package:flutter/material.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCard();
}

class _WeatherCard extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: const Column(
            children: [
              Text(
                "12:00",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Icon(
                Icons.cloud,
                size: 32,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "320.12",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
