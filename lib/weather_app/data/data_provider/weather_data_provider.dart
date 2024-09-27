import 'package:dissertation_project_app/weather_app/data/secrets/key.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final result = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&APPID=$OPEN_WEATHER_API_KEY",
        ),
      );
      print(result.body);
      return result.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
