import 'package:flutter/material.dart';

class MyStatefullWidget extends StatefulWidget {
  const MyStatefullWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefullWidget> createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {
  String st = 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My StatefulWidget"),
      ),
      body: Column(children: [
        Text("My Text: $st"),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if (st == 'Yes') {
                  st = 'No';
                } else {
                  st = 'Yes';
                }
              });
            },
            child: const Text("Click me!"))
      ]),
    );
  }
}
