import 'package:flutter/material.dart';

class MyImagePagee extends StatelessWidget {
  const MyImagePagee({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter"),
        // leading: Icon(Icons.menu),
        actions:[
          IconButton(onPressed: ()=>{}, icon: const Icon(Icons.share)),
          IconButton(onPressed: ()=>{}, icon: const Icon(Icons.social_distance)),
        ]
      ),
      body: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: 250,
            height: 250,
            child: Image.asset("assets/images/floppy.jpg"),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: 250,
            height: 250,
            child: Image.network("https://startflutter.com/wp-content/uploads/2020/04/111-1.png"),
          ),
          const SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.star, color: Colors.red[500]),
              Icon(Icons.star, color: Colors.red[500]),
              Icon(Icons.star, color: Colors.red[500]),
              Icon(Icons.star_half, color: Colors.red[500]),
              const Icon(Icons.star, color: Colors.black),
              const Text("150 đánh giá")
            ]
          )
        ],
      )
    );
  }
}