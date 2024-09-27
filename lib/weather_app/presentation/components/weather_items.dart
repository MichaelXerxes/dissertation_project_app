import 'package:flutter/material.dart';

import 'weather_forecast_item.dart';

class WeatherItems extends StatefulWidget {
  const WeatherItems({super.key});

  @override
  State<WeatherItems> createState() => _WeatherItems();
}

class _WeatherItems extends State<WeatherItems> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WeatherForecastItem(
            textInfo: "94", icon: Icons.water_drop, textValue: "Huminidty"),
        WeatherForecastItem(
            textInfo: "7.67",
            icon: Icons.storm_rounded,
            textValue: "Wind Spreed"),
        WeatherForecastItem(
            textInfo: "1006", icon: Icons.umbrella, textValue: "Pressure")
      ],
    );
  }
}
