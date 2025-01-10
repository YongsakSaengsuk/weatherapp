import 'package:flutter/material.dart';
import 'package:weatherapp/top_page.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              TopPage(),
              Text("Body"),
              Text("5 day"),
            ],
          ),
        ),
      ),
    );
  }
}
