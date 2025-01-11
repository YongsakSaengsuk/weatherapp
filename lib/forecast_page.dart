import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/Forecasts_cards.dart';
import 'package:weatherapp/body_page.dart';
import 'package:weatherapp/top_page.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  String key = 'e8ae3996e6d088af9b609e6c7057dcc0';
  late WeatherFactory wf;
  Weather? currentWeather;

  @override
  void initState() {
    super.initState();
    wf = WeatherFactory(key);
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      Weather weather = await wf.currentWeatherByCityName('Chumphon');
      setState(() {
        currentWeather = weather;
        print(currentWeather);
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ListView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(108, 188, 188, 188),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(2, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        TopPage(location: currentWeather?.areaName),
                        BodyPage(
                          wt: currentWeather!,
                        ),
                        
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 200,
                  child: Column(
                    children: [
                      Text("5-Days Forecasts"),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(2),
                          scrollDirection: Axis.horizontal,
                          children: [
                            ForecastsCards(minTemp: 12, maxTemp: 20),
                            ForecastsCards(minTemp: 12, maxTemp: 25),
                            ForecastsCards(minTemp: 12, maxTemp: 26),
                            ForecastsCards(minTemp: 12, maxTemp: 27),
                            ForecastsCards(minTemp: 12, maxTemp: 28),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
