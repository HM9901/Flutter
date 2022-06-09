

// ignore_for_file: curly_braces_in_flow_control_structures, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseConnect extends StatefulWidget {
  final Widget Function(BuildContext context)?builder;
  final String?errorMessage;
  final String?connectingMessage;
  const MyFirebaseConnect({Key?key,
  required this.errorMessage,
  required this.connectingMessage,
  required this.builder,}):super(key:key);

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi=false;
  bool loi=false;
  @override
  Widget build(BuildContext context){
    if(loi){
      return
        Container(
          color:Colors.white,
          child:Center(
            child:Text(widget.errorMessage !,
              style:const TextStyle(fontSize:18,),
              textDirection:TextDirection.ltr,
            ),// Text
          ),// Center
        );// Container
    }
    else
    if(!ketNoi){
      return
        Container(
        color:Colors.white,
          child:Center(
          child:Text(widget.connectingMessage !,
            style:const TextStyle(fontSize:18,),
            textDirection:TextDirection.ltr,
          ),// Text
        ),// Center
        );// Container
    }else{
      return
      widget.builder!(context);
    }
  }
    @override
  void initState(){
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase()async{
    try{
      await Firebase.initializeApp();
      setState((){
        ketNoi=true;
      });
    }catch(e){
      setState((){
        loi=true;
      });
    }
  }
}