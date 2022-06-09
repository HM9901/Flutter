
import 'package:flutter/material.dart';
import 'package:flutter_app/fcm/message.dart';
import 'package:flutter_app/fcm/message_helper.dart';

class PageListMessage extends StatefulWidget {
  const PageListMessage({Key? key}) : super(key: key);

  @override
  State<PageListMessage> createState() => _PageListMessageState();
}

class _PageListMessageState extends State<PageListMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:AppBar(
    title:const Text("List of messages"),
  ),// AppBar
  body:Padding(
    padding:const EdgeInsets.all(8.0),
    child:FutureBuilder<List<MyNotificationMessage>?>(
      future:MessageHelper.readMessage(),
      builder:(context,snapshot){
        if(snapshot.hasError){
          return const Text("Có lỗi xảy ra");
        }else
          if(!snapshot.hasData){
            return const Text("Không có dữ liệu");
          }
          else{
              List<MyNotificationMessage>?listMessage =snapshot.data;
          
            return ListView.separated(
                itemBuilder:(context,index)=>ListTile(
                  leading:Text(listMessage?[index].from ??"Unknown"),
                  title:Text(listMessage?[index].title ??"No Title"),
                  subtitle:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                  Text(listMessage?[index].body ??"No body"),
                  Text(listMessage?[index].time ??"Unknown"),
                    ],
                  ),
                ),
                  separatorBuilder:(context,index)=>Divider(thickness:1,),
                  itemCount:listMessage?.length ??0);// ListView.separated
                }
              },
            ),
          ),
        );
  }
}