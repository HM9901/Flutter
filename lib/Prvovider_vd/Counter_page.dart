// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/Prvovider_vd/Counter.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context, listen: true);
    // k duoc dung trong su kien onpress vi nhu the se rebuild lai 2 lan nen se xung dot
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo Home Page"),
      ),
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You have push the button this many time: "),
              // Consumer<Counter>(builder: (context, Counter, child) {
              //   return Text("${Counter.value}",style: const TextStyle(fontSize: 20),);
              // Text("${counter.value}"),
              FutureBuilder(
                future: counter.getValue(),
                builder: (context, snapshot) {
                  return Text("${snapshot.data}", style: const TextStyle(fontSize: 20),);
                }
              )
              // },)
            ],
          ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_circle, color: Colors.blue, size: 50),
        onPressed: () {
          var provider = context.read<Counter>();
          provider.increment();
        }
      ),
    );
  }
}