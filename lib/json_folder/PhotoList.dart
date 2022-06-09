// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/json_folder/Photo.dart';

// ignore: must_be_immutable
class PhotoList extends StatelessWidget {
  late List<Photo> photos;
  PhotoList({Key? key, required this.photos}):super(key:key);
  @override
  Widget build(BuildContext context) {
  return GridView.extent(
      maxCrossAxisExtent: 200, 
      padding: const EdgeInsets.all((5)),
      mainAxisSpacing: 5, crossAxisSpacing: 5,
      children: List.generate(photos.length, (index) => 
      Container(
        decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Image.network(photos[index].thumbnailUrl),)),
      );
  }
}