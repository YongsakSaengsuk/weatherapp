import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage(
      {super.key, required this.location, required this.onLocationChange});
  final String? location;
  final void Function(String newLocation) onLocationChange;
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final TextEditingController textController = TextEditingController();

  Widget _addButton() {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                        IconButton(
                            onPressed: () {
                              if (textController.text.isNotEmpty) {
                                widget.onLocationChange(textController.text);
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('warning'),
                                      content: Text("Please Enter City"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('ok'))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            icon: Icon(Icons.done)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'Enter Location or Coordinates',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  )
                ],
              );
            },
          );
        },
        icon: Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _addButton(),
          Row(
            children: [
              Icon(Icons.location_on),
              Text(widget.location ?? 'Wating...'),
            ],
          ),
          Icon(Icons.menu)
        ],
      ),
    );
  }
}
