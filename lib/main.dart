// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app/Fire_base/page_firebase_app.dart';
// import 'package:flutter_app/fcm/message_helper.dart';
// import 'package:flutter_app/fcm/page_fcm_app.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/login/page_login.dart';

void main() async {
  runApp(const MyApp());

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   FirebaseMessaging.onBackgroundMessage(MessageHelper.fcm_BackgroundHandler);


//   await FirebaseMessaging.instance.
//   setForegroundNotificationPresentationOptions(
//     alert:true,
//     badge:true,
//     sound:true,
//  ); 

//  NotificationSettings settings=await FirebaseMessaging.instance.requestPermission(
//     alert:true,
//     announcement:false,
//     badge:true,
//     carPlay:false,
//     criticalAlert:false,
//     provisional:false,
//     sound:true,
//   );
//   print('User granted permission:${settings.authorizationStatus}');
//   runApp(const PageAppFCM());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // cái đc trả về từ phương thức build sẽ đc hiển thị trên giao diện
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MyHomePage(),
    );
  }
}