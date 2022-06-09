import 'package:flutter/material.dart';
import 'package:flutter_app/Basic/GridView.dart';
import 'package:flutter_app/Basic/MyListView.dart';
import 'package:flutter_app/Basic/my_image.dart';
import 'package:flutter_app/Basic/my_image_list_page.dart';
import 'package:flutter_app/Basic/my_input.dart';
import 'package:flutter_app/Fire_base/page_firebase_app.dart';
import 'package:flutter_app/Prvovider_vd/my_app.dart';
import 'package:flutter_app/SQlite/page_sqlite_app.dart';
import 'package:flutter_app/fcm/page_home_fcm.dart';
import 'package:flutter_app/form/page_form_mathang.dart';
import 'package:flutter_app/gridViewPage/gridViewPage.dart';
import 'package:flutter_app/json_folder/PhotoPage.dart';
import 'package:flutter_app/login/page_login.dart';
import 'package:flutter_app/news/MyVNExpressPage.dart';
import 'package:flutter_app/provider_baitap/sanpham_app.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body :  
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buttonBuilder(context,title: "My List View", destination: const MyListView()),
              buttonBuilder(context,title: "My Grid View", destination: const MyGridView()),
              buttonBuilder(context,title: "My Image List View", destination: const MyImageList()),
              buttonBuilder(context,title: "My Input View Page", destination: const MyInputPage()),
              buttonBuilder(context,title: "My Imageeee View Pageeee", destination: const MyImagePagee()),
              buttonBuilder(context,title: "My Form View Pageeee", destination: PageFormMH()),
              buttonBuilder(context,title: "My Grid View Pageeee", destination: const gridViewPage()),
              buttonBuilder(context,title: "Provider Demo", destination: const MyProviderApp()),
              buttonBuilder(context,title: "Provider Page", destination: const SanPhamApp()),
              buttonBuilder(context,title: "Json Page", destination: const PhotosPage()),
              buttonBuilder(context,title: "VNExPress", destination: const MyVNexpressPage()),
              buttonBuilder(context,title: "SQLite", destination: const SQLiteApp()),
              buttonBuilder(context,title: "My List View", destination: const MyLoginPage()),
              buttonBuilder(context,title: "My Fire Base View", destination: const MyFireBaseApp()),
              buttonBuilder(context,title: "My Home FCM", destination: const PageHomeFCM()),
            ],
          ),
        ),
      )
    );
  }
  Widget buttonBuilder(BuildContext context, {required String? title, required Widget destination}) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) =>destination,)
                );
              },
              child:  Text(title!)),
    );
          

  }
}