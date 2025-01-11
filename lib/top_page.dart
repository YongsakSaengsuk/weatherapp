import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key,required this.location});
  final String? location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.add),
          Row(
            children: [
              Icon(Icons.location_on),
              Text(location!),
            ],
          ),
          Icon(Icons.menu)
        ],
      ),
    );
  }
}
