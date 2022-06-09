import 'package:flutter/material.dart';
import 'package:flutter_app/Prvovider_vd/Counter.dart';
import 'package:flutter_app/Prvovider_vd/Counter_page.dart';
import 'package:provider/provider.dart';

class MyProviderApp extends StatelessWidget {
  const MyProviderApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MaterialApp(
        title: "Provider App Demo",
        home: CounterPage(),
      ),
    );
  }
}