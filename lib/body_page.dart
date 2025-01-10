import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({super.key});

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Date & Time"),
        Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: 250,
                height: 250,
              ),
            ),
            Positioned(
              top: 20,
              child: Text(
                "20°",
                style: TextStyle(fontSize: 100),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 20,
              child: SvgPicture.asset(
                color: Colors.grey,
                "assets/images/cloudy_sunny.svg",
                height: 150,
              ),
            ),
            Positioned(
              left: 5,
              bottom: 60,
              child: Text(
                "Cloudy",
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
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
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
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
          ),
          child: Column(
            children: [
              Text('Feel like'),
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
