import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/Forecasts_cards.dart';
import 'package:weatherapp/body_page.dart';
import 'package:weatherapp/top_page.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  String key = 'e8ae3996e6d088af9b609e6c7057dcc0';
  late WeatherFactory wf;
  late List<dynamic> fiveDayForecast;
  Weather? currentWeather;
  String cityName = 'London';
  @override
  void initState() {
    super.initState();
    wf = WeatherFactory(key);
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      Weather weather = await wf.currentWeatherByCityName(cityName);
      List<dynamic> forecast = await wf.fiveDayForecastByCityName(cityName);
      setState(() {
        currentWeather = weather;
        fiveDayForecast = forecast;
        print(fiveDayForecast);
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
          child: FutureBuilder(
            future: wf.currentWeatherByCityName(cityName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView(
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
                            TopPage(location: snapshot.data?.areaName),
                            BodyPage(
                              wt: snapshot.data!,
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
                              child: fiveDayForecast.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final day = fiveDayForecast[index];
                                        return ForecastsCards(
                                          minTemp:
                                              day.tempMin?.celsius?.toInt() ??
                                                  0,
                                          maxTemp:
                                              day.tempMax?.celsius?.toInt() ??
                                                  0,
                                          iconID: 'http://openweathermap.org/img/wn/${day.weatherIcon}@4x.png',
                                        );
                                      },
                                    ))
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text('No Data available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
