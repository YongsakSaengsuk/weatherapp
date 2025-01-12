import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/forecast_page.dart';

void main() async {
  await dotenv.load(fileName: ".env";)
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/Forecastpage': (context) => const ForecastPage(),
    }, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/cloudy_sunny.svg",
                height: 200,
              ),
              Text(
                "Weather Forecasts",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF08A0FF)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Forecastpage');
                  },
                  child: const Text("Get Start")),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: home(),
      ),
    );
  }
}
