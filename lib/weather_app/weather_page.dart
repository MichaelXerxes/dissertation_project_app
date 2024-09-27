import 'package:dissertation_project_app/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/weather_screen.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                print("refresh");
              },
              child: const Icon(Icons.refresh)),
          InkWell(
              onTap: () {
                print("refresh");
              },
              child: const Icon(Icons.refresh)),
        ],
      ),
      body: const WeatherScreen(),
      bottomNavigationBar: const BottomBar(
        title: "Second Page",
        indexValue: 4,
      ),
    );
  }
}
