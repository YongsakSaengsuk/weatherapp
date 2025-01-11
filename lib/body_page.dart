import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({super.key, required this.wt});
  final Weather wt;
  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  late final Weather wt;
  @override
  void initState() {
    super.initState();
    wt = widget.wt;
  }

  String? formatWeatherDate(DateTime? date) {
    if (date == null) {
      return null; // Handle null case
    }
    // Format the date
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(formatWeatherDate(wt.date) ?? "null"),
        Stack(
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
              child: Text("${wt.temperature?.celsius?.toStringAsFixed(0)}º",
                  style: TextStyle(fontSize: 100)),
            ),
            Positioned(
              right: 0,
              bottom: 50,
              child: Image.network(
                  width: 150,
                  'http://openweathermap.org/img/wn/${wt.weatherIcon}@4x.png'),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: Text(
                wt.weatherDescription ?? "null",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "wind",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text("Humidity", textAlign: TextAlign.center),
            )
          ],
        ),
        Container(
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
                children: [
                  Icon(Icons.sunny),
                  Text(
                    "SunRise",
                  )
                ],
              ),
              Text("06:00"),
              Column(
                children: [
                  Icon(Icons.wb_sunny_outlined),
                  Text(
                    "SunSet",
                  )
                ],
              ),
              Text("18:00")
            ],
          ),
        ),
        Container(
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
              Text('Feel like : '),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temp Min",
                  ),
                  Text("Temp Max"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
