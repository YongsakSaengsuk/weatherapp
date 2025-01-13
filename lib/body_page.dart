import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({super.key, required this.wt});
  final Weather? wt;
  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  late final Weather? wt;
  @override
  void initState() {
    super.initState();
    wt = widget.wt;
  }

  String? formatWeatherDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  String? formatSunTime(DateTime? sun) {
    if (sun == null) {
      return null;
    }
    return DateFormat("HH:mm").format(sun);
  }

  Widget _currentTemp() {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: 250,
            height: 250,
          ),
        ),
        Positioned(
          right: 50,
          top: 20,
          child: Text("${wt?.temperature?.celsius?.toStringAsFixed(0)}º",
              style: TextStyle(fontSize: 100)),
        ),
        Positioned(
          right: 0,
          bottom: 50,
          child: wt?.weatherIcon != null
              ? Image.network(
            'http://openweathermap.org/img/wn/${wt?.weatherIcon}@4x.png',
            width: 150)
              : Placeholder(fallbackHeight: 150, fallbackWidth: 150),
        ),
        Positioned(
          bottom: 50,
          left: 60,
          child: Text(
            wt?.weatherDescription ?? "null",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  Widget _extraTemp() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 9,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
              'Feel like : ${wt?.tempFeelsLike?.celsius?.toStringAsFixed(0)}ºC'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Temp Min : ${wt?.tempMin?.celsius?.toStringAsFixed(0)}ºC"),
              Text("Temp Max : ${wt?.tempMax?.celsius?.toStringAsFixed(0)}ºC"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cHumpWind() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.network(
                  "https://www.svgrepo.com/show/522344/wind.svg",
                  height: 40,
                ),
              ),
              Text(
                "${wt?.windSpeed} m/s",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.network(
                  "https://www.svgrepo.com/show/458235/humidity.svg",
                  height: 50,
                ),
              ),
              Text("${wt?.humidity?.toStringAsFixed(0)}%",
                  textAlign: TextAlign.center),
            ],
          ),
        )
      ],
    );
  }

  Widget _sunTime() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 9,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [Icon(Icons.sunny), Text("SunRise")],
          ),
          Text(formatSunTime(wt?.sunrise) ?? "null"),
          Column(
            children: [Icon(Icons.wb_sunny_outlined), Text("SunSet")],
          ),
          Text(formatSunTime(wt?.sunset) ?? "null")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(formatWeatherDate(wt?.date) ?? "null"),
        _currentTemp(),
        _cHumpWind(),
        _sunTime(),
        _extraTemp(),
      ],
    );
  }
}
