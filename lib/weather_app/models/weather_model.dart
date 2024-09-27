// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentHumidity;
  final double windSpeed;
  final double tempMin;
  final double tempMax;
  final String statusWeather;
  final String description;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentHumidity,
    required this.windSpeed,
    required this.tempMin,
    required this.tempMax,
    required this.statusWeather,
    required this.description,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentHumidity,
    double? windSpeed,
    double? tempMin,
    double? tempMax,
    String? statusWeather,
    String? description,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      windSpeed: windSpeed ?? this.windSpeed,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      statusWeather: statusWeather ?? this.statusWeather,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentHumidity': currentHumidity,
      'windSpeed': windSpeed,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'statusWeather': statusWeather,
      'description': description,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> currentData) {
    return WeatherModel(
      currentTemp: currentData['main']['temp'],
      currentSky: currentData['weather'][0]['main'],
      currentPressure: currentData['main']['pressure'],
      currentHumidity: currentData['main']['humidity'],
      windSpeed: currentData['wind']['speed'],
      tempMin: currentData['main']['temp_min'],
      tempMax: currentData['main']['temp_max'],
      statusWeather: currentData['weather'][0]['main'],
      description: currentData['weather'][0]['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentHumidity: $currentHumidity, windSpeed: $windSpeed, tempMin: $tempMin, tempMax: $tempMax, statusWeather: $statusWeather, description: $description)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentHumidity == currentHumidity &&
        other.windSpeed == windSpeed &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.statusWeather == statusWeather &&
        other.description == description;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentHumidity.hashCode ^
        windSpeed.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        statusWeather.hashCode ^
        description.hashCode;
  }
}
