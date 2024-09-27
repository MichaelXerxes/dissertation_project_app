import 'package:flutter/material.dart';

class WeatherForecastItem extends StatefulWidget {
  final String textInfo;
  final IconData icon;
  final String textValue;

  const WeatherForecastItem({
    Key? key,
    required this.textInfo,
    required this.icon,
    required this.textValue,
  }) : super(key: key);
  @override
  State<WeatherForecastItem> createState() => _WeatherForecastItem();
}

class _WeatherForecastItem extends State<WeatherForecastItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Icon(
          widget.icon,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.textValue,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.textInfo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
