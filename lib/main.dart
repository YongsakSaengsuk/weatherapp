import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
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
                    onPressed: () {}, child: const Text("Get Start")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
