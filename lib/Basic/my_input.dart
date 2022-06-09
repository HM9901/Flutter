// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyInputPage extends StatefulWidget {
  const MyInputPage({ Key? key }) : super(key: key);

  @override
  State<MyInputPage> createState() => _MyInputPageState();
}

class _MyInputPageState extends State<MyInputPage> {
  TextEditingController txtnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("My Input Page"),
      ),
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton(onPressed: () => {}, child: const Icon(Icons.access_alarm, color: Colors.black,)),
          TextButton(onPressed: () => {}, child: const Icon(Icons.access_alarm,  color: Colors.black,)),
          TextButton(onPressed: () => {}, child: const Icon(Icons.access_alarm,  color: Colors.black,)),
          TextButton(onPressed: () => {}, child: const Icon(Icons.access_alarm,  color: Colors.black,)),
        ],)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: txtnameController,
              decoration: const InputDecoration(
                hintText: "Nhập tên vào đây ",
                labelText: "Tên: "
              ),
              keyboardType: TextInputType.phone,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed:() => Navigator.pop(context),
                child: const Text("Go Back!!!"),),
                const SizedBox(width: 15),
                ElevatedButton(onPressed: () =>
                // {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Chào bạn: ${txtnameController.text}"),
                //     duration: Duration(seconds: 10)
                //     ),
                //   );
                // },
                _Showalert(context),
                child: const Text("Click me!!!")),
              ]
            )
          ],
        ),
      ),
    );
  }
    // ignore: non_constant_identifier_names
    void _Showalert(BuildContext context) {
      AlertDialog dialog = AlertDialog(
        title: const Text("xác nhận"),
        content: Text(txtnameController.text),
        actions: [
          FlatButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      );
      showDialog(context: context, builder: (context)=>dialog,);
    }
}