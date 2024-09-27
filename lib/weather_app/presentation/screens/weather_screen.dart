import 'package:dissertation_project_app/weather_app/bloc/weather_bloc.dart';
import 'package:dissertation_project_app/weather_app/presentation/components/weather_card.dart';
import 'package:dissertation_project_app/weather_app/presentation/components/weather_forecast_item.dart';
import 'package:dissertation_project_app/weather_app/presentation/components/weather_temp_top_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    const double maxColumnWidth = 500.0;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: maxColumnWidth,
        ),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherFailure) {
            print(state.error);
            return Center(child: Text(state.error));
          }
          if (state is! WeatherSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = state.weatherModel;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeaherTempTopView(
                  currentTemp: data.currentTemp,
                  tempMin: data.tempMin,
                  tempMax: data.tempMax,
                  statusWeather: "${data.statusWeather} - ${data.description}",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        // ...List.generate(
                        //   30,
                        //   (index) => Padding(
                        //     padding: const EdgeInsets.only(right: 16.0),
                        //     child: WeatherCard(),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 120,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 10,
                        //       itemBuilder: (context, index) {
                        //         return WeatherCard();
                        //       }),
                        // ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const WeatherCard();
                      }),
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherForecastItem(
                        textInfo: "${data.currentHumidity}",
                        icon: Icons.water_drop,
                        textValue: "Huminidty"),
                    WeatherForecastItem(
                        textInfo: "${data.windSpeed}",
                        icon: Icons.storm_rounded,
                        textValue: "Wind Speed"),
                    WeatherForecastItem(
                        textInfo: "${data.currentPressure}",
                        icon: Icons.umbrella,
                        textValue: "Pressure")
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Placeholder(
                  fallbackHeight: 150,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
