// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView Extend")
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(5),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: List.generate(100,
         (index) => Card(
          //  decoration: BoxDecoration(
          //    border: Border.all(color: Colors.blue)
          //  ),
           child: Center(
             child: Text("${index+1}",
             style:const TextStyle(fontSize: 20))
           ),
         )),
      )
    );
  }
}