// ignore_for_file: unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Fire_base/page_home_firebase_app.dart';

class MyFireBaseApp extends StatefulWidget {
  const MyFireBaseApp({ Key? key }) : super(key: key);

  @override
  State<MyFireBaseApp> createState() => _MyFireBaseAppState();
}

class _MyFireBaseAppState extends State<MyFireBaseApp> {
  bool ketNoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if(loi) {
      return Container(
        color:  Colors.white,

        // ignore: prefer_const_constructors
        child: Center(
          child: const Text("Có lỗi xảy ra", style: TextStyle(fontSize: 18),
          textDirection: TextDirection.ltr),
        )
      );
    }
    else {
      if(!ketNoi) {
          return Container(
          color:  Colors.white,

          // ignore: prefer_const_constructors
          child: Center(
            child: const Text("Đang kết nối", style: TextStyle(fontSize: 18),
            textDirection: TextDirection.ltr),
          )
        );
      }
      else {
        return const MaterialApp(
          title: "kết nối My FireBase App",
          home: PageSinhVien()
        );
      }
    }
  }
  @override
  void initState() {
    super.initState(); //
    _khoitaoFireBase();
  }
  _khoitaoFireBase() async {
    try{
      await  Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } 
    catch(e) {
      print(e);
      setState(() {
        loi = true;
      });
    }
  }
}