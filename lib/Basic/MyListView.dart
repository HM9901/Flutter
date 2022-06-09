// ignore_for_file: file_names

import 'package:flutter/material.dart';

List<String> list = [
  "Mận","Mơ","Dưa Hấu","Xoài","Cam","Quýt","Ổi","Mít","Thơm"
];

class MyListView extends StatefulWidget {
  const MyListView({ Key? key }) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My ListView Page")
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index]),
            leading: const Icon(Icons.forum),
            subtitle: const Text("Cửa hàng trái cây 61CNTT-1"),
          );
        }, 
        separatorBuilder: (context, index) => const Divider(
          thickness: 2,
        ), 
        itemCount: list.length)
      );
  }
}