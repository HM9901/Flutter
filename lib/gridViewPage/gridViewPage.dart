// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'fruit.dart';

// ignore: camel_case_types
class gridViewPage extends StatelessWidget {
  const gridViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giải Cứu Nông Sản")),
      body: GridView.extent(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
          children: listSP
              .map((sp) => Card(
                    elevation: 1,
                    shadowColor: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(sp.url,width: 250, height:190), 
                        // ignore: unnecessary_string_interpolations
                        Text("${sp.ten}"),
                        Text(
                          "Giá: ${sp.gia}/kg",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
