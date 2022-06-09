import 'package:flutter/material.dart';

class MyImageList extends StatefulWidget {
  const MyImageList({ Key? key }) : super(key: key);

  @override
  State<MyImageList> createState() => _MyImageListState();
}

class _MyImageListState extends State<MyImageList> {
  List<String> list = [
    "https://play-lh.googleusercontent.com/85WnuKkqDY4gf6tndeL4_Ng5vgRk7PTfmpI4vHMIosyq6XQ7ZGDXNtYG2s0b09kJMw",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/CSS3_logo_and_wordmark.svg/1200px-CSS3_logo_and_wordmark.svg.png",
    "https://a.strephonsays.com/technology/Difference-Between-JavaScript-and-jQuery.webp",
    "https://codelearn.io/Upload/Blog/react-js-co-ban-phan-1-63738082145.3856.jpg",
    "https://a.strephonsays.com/technology/Difference-Between-JavaScript-and-jQuery.webp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuNAJbjGkLN7CYoQbetLygwTgS8zbDSbKe80Fhc9jOBADCggAHFHSZBEcvwygPnD9yE_I&usqp=CAU",
    "http://itplus-academy.edu.vn/upload/c47d9c29fc44c2b7996a2613aec3c1f9/files/writer1/jv.jpg",
    "https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI"
  ];
  int i = 0;
  TextEditingController txtnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Image List Page"),
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.g_mobiledata_rounded)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.cabin_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  height: 300,
                  child: Image.network(list[i]),
                ),
              ],
            ),
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: ()=> setState(() 
                {
                  i--;
                  if(i == -1) i = 7;
                }
                // {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Chào bạn: ${txtnameController.text}"),
                //     duration: Duration(seconds: 10)
                //     ),
                //   );
                // },
                ),
                child: const Icon(Icons.navigate_before_outlined)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: ()=> setState(() {
                  i++;
                  if(i == 8) i = 0;
                }), child: const Icon(Icons.navigate_next_outlined)),
              ),
            ]
          )
        ],
      ),
    );
  }
}