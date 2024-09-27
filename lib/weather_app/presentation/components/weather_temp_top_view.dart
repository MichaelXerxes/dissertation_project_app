import 'dart:ui';

import 'package:flutter/material.dart';

class WeaherTempTopView extends StatefulWidget {
  const WeaherTempTopView(
      {super.key,
      required this.currentTemp,
      required this.tempMin,
      required this.tempMax,
      required this.statusWeather});

  final double currentTemp;
  final double tempMin;
  final double tempMax;
  final String statusWeather;

  @override
  State<WeaherTempTopView> createState() => _WeaherTempTopViewState();
}

class _WeaherTempTopViewState extends State<WeaherTempTopView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "${widget.currentTemp} ° F",
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Icon(
                    Icons.cloud,
                    size: 64,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.statusWeather,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.ten_mp_sharp),
                          Text("Temp min ${widget.tempMin}")
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.snowboarding_outlined),
                          Text("Temp max ${widget.tempMax}")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
