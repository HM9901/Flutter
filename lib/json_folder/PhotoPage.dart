// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/json_folder/Photo.dart';
import 'package:flutter_app/json_folder/PhotoList.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({ Key? key }) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late final Future<List<Photo>> photos;
  @override 
  void initState() {
    super.initState(); 
    photos = fetchPhotos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Photo Page"),
      ) ,
      body: FutureBuilder<List<Photo>>(
        future: photos,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            // ignore: avoid_print
            print("loi xay ra");
            return const Text("loi xay ra");
          }
          return snapshot.hasData ? PhotoList(photos: snapshot.data!,) 
            : const Center(child: CircularProgressIndicator(),);
        },
        
      ),
    );
  }
}