import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  String key = dotenv.env['API_KEY'] ?? '';
  late WeatherFactory wf;

  List<dynamic> fiveDayForecast = [];
  Weather? currentWeather;

  String cityName = 'London';
  double latitude = 51.509865;
  double longitude = -0.118092;

  @override
  void initState() {
    super.initState();
    wf = WeatherFactory(key);
    fetchWeather(cityName);
  }

  Future<void> fetchWeather(String input) async {
    try {
      Weather weather;
      List<dynamic> forecast;

      final latLonRegex = RegExp(r'^-?\d+(\.\d+)?,-?\d+(\.\d+)?$');
      if (latLonRegex.hasMatch(input)) {
        final parts = input.split(',');
        double latitude = double.parse(parts[0].trim());
        double longitude = double.parse(parts[1].trim());
        weather = await wf.currentWeatherByLocation(latitude, longitude);
        forecast = await wf.fiveDayForecastByLocation(latitude, longitude);
        print("Fetching weather for lat: $latitude, lon: $longitude");
      } else {
        weather = await wf.currentWeatherByCityName(input);
        forecast = await wf.fiveDayForecastByCityName(input);
        print("Fetching weather for city: $input");
      }
      setState(() {
        currentWeather = weather;
        fiveDayForecast = forecast;
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  void handleLocationChange(String newLocation) {
    setState(() {
      cityName = newLocation;
    });
    fetchWeather(newLocation);
  }

  Widget _mainForecasts() {
    return Container(
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
          TopPage(
              location: currentWeather?.areaName,
              onLocationChange: handleLocationChange),
          BodyPage(
            wt: currentWeather,
          ),
        ],
      ),
    );
  }

  Widget _dayForecasts() {
    return Container(
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
                        minTemp: day.tempMin?.celsius?.toInt() ?? 0,
                        maxTemp: day.tempMax?.celsius?.toInt() ?? 0,
                        iconID:
                            'http://openweathermap.org/img/wn/${day.weatherIcon}@4x.png',
                      );
                    },
                  ),
          )
        ],
      ),
    );
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
            future: Future.wait([
              wf.currentWeatherByCityName(cityName),
              wf.fiveDayForecastByCityName(cityName),
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView(
                  children: [
                    SingleChildScrollView(child: _mainForecasts()),
                    _dayForecasts(),
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
