import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForecastsCards extends StatefulWidget {
  const ForecastsCards({super.key, required this.minTemp, required this.maxTemp});
  final double? minTemp;
  final double? maxTemp;
  @override
  State<ForecastsCards> createState() => _FivedayforecastState();
}

class _FivedayforecastState extends State<ForecastsCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, blurRadius: 7, offset: Offset(0, 4))
        ],
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      width: 75,
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/images/cloudy_sunny.svg",
            height: 30,
          ),
          Text(widget.minTemp.toString()),
          Text(widget.maxTemp.toString())
        ],
      ),
    );
  }
}
