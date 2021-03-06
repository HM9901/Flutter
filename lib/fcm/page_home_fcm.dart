
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/fcm/message_helper.dart';
import 'package:flutter_app/fcm/page_fcm_message.dart';
import 'package:flutter_app/fcm/page_list_message.dart';


String authorization_key = "AAAA01I1LFs:APA91bEzidpR3SR6DC-uaV4lRvQRnWLQ2WQECY-XvQp640yRhTwCKvjYfelgUmL0jZgr-7_pZeVci-lpwSriRwVg94_zK3ijXxhSAm5b7R_k5QIoUFztibPa7B1MGPmcHgHKrvB0x1qs";
String topic = "my_fcm_test";
class PageHomeFCM extends StatefulWidget {
  const PageHomeFCM({Key? key}) : super(key: key);

  @override
  State<PageHomeFCM> createState() => _PageHomeFCMState();
}

class _PageHomeFCMState extends State<PageHomeFCM> {
  int count=10;
  int index=0;
  String?token;
  String?topicStatus='fcm_test';
  String incoming_message="No message";
  TextEditingController textContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar:AppBar(
        title:const Text("FCM Demo"),
      ),// AppBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:index,
        onTap:(value){
          if(value ==1&& count>0){
            setState((){
              count=0;
            });
            Navigator.push(context,
              MaterialPageRoute(builder:(context)=> PageListMessage(),)
            );
          }
        },
        items:[
      BottomNavigationBarItem(
        icon:Icon(Icons.home,color:Colors.blue[800],),
        label:'Home'
      ),// BottomNavigation BarItem
      BottomNavigationBarItem(
        label:"Message",
        icon: Badge(
        badgeColor:Colors.red,
        showBadge:count>0,
        position:BadgePosition.topEnd(top:-12,end:-18),
        badgeContent:Text("$count",style:TextStyle(color:Colors.white),),
        child:Icon(Icons.message,color:Colors.green,),
      )),// Badge,BottomNavigation BarItem
    ],
    ),
      body:SingleChildScrollView(
      child:Padding(
      padding:const EdgeInsets.all(8.0),
      child:Column(
      mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Text("FCM Token:$token"),
          const SizedBox(height:10,),
          Text("Topic:$topicStatus"),
          const SizedBox(height:10,),
          Text("Message:$incoming_message"),// BottomNavigationBar
          Center(
          child:ElevatedButton(
            child:const Text("Subscribe to topic"),
            onPressed:(){
              FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(
                (){
                    setState((){
                      topicStatus=topic;
                  });
                });
              },
            ),
          ),// Center
          Center(
          child:ElevatedButton(
            child:const Text("Unsubscribe from topic"),
            onPressed:(){
              FirebaseMessaging.instance.unsubscribeFromTopic(topic).whenComplete(
                (){
                  setState((){
                    topicStatus="None";
                  });
                });
              },
            ),
          ),// Center
          const SizedBox(height:10,),
          TextField(
            controller:textContent,
          decoration:const InputDecoration(
              labelText:"N???i dung tin nh???n",
            ),// Input Decoration
          ),// TextField
          SizedBox(height:10,),
          Center(
            child:ElevatedButton(
              child:const Text("Send message to topic"),// Th???c hi???n g???i tin nh???n cho Topic
              onPressed:(){
                // String messageToSend MessageHelper.construct Topic FCMPay Load(topic,++ messa
                String messageTosend=MessageHelper.constructFCMPayload(
                  content:textContent.text,
                  topic:true,
                  to:topic,// topic of taget devices
                );
                MessageHelper.sendPushMessageByHTTP_Post(
                  authorization_key:authorization_key,
                  token:token,// token on this device
                  message:messageTosend
                );
              },
            ),
          ),// Center
          const SizedBox(height:10,),
          Center(
            child:ElevatedButton(
              child:const Text("Send message to myself"),
              onPressed:(){
                String message=MessageHelper.constructFCMPayload(
                  content:textContent.text,
                  to:token !, // token on target Device
                  topic:false,
                );
                MessageHelper.sendPushMessageByHTTP_Post(message:message,token:token, authorization_key: authorization_key);
              },
            ),
          ),
          ],
          ),
          ),
          ),
        );
}

  @override
void initState(){
 // TODO:implement initState
  super.initState();
  // L???y Token ???? ????ng k?? khi ???ng d???ng ch???y l???n ?????u
  // Th??ng th?????ng,token n??y s??? ???????c l??u tr??n server ????? c?? th??? ???????c d??ng ????? g???i tin nh???ns
  // L???y m?? th??ng b??o FCM m???c ?????nh cho thi???t b??? n??y.
  FirebaseMessaging.instance.getToken().then(
    (value){
      print("Token message:$value");
      setState((){
        token=value;
      });
   });
  // ????ng k?? v???i topic
  FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(
          (){
        setState((){
          topicStatus=topic;
        });
      });

  
      // L???y s??? l?????ng tin nh???n v?? c???p nh???t l??n bagde widget
  MessageHelper.getCountMessage().then(
    (value){
      setState((){
        count=value;
      });
      }
    );

    //S??? ki???n x??? l?? khi ng?????i d??ng b???m v??o tin nh???n tr??n thanh tr???ng th??i
    //Khi ???ng d???ng ??ang ch???y d?????i background
  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage){
     MessageHelper.fcmOpenMessageHandler(
         context:context,
        message:remoteMessage,
        messageHandler:(context,message){
          
           // ??i???u h?????ng t???i trang hi???n th??? tin nh??n
           Navigator.push(
              context,
              MaterialPageRoute(builder:(context)=>PageFCM_Message(message:message,),)
           );
        },
     );
  });
  
//S??? ki???n x??? l?? khi ng?????i d??ng b???m v??o tin nh???n tr??n thanh tr???ng th??i
// Khi ???ng d???ng ??ang???trang th??i terminate
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage){
        if(remoteMessage!=null){
            MessageHelper.fcmOpenMessageHandler(
              context:context,
              message:remoteMessage,
              messageHandler:(context,message){
                  // ??i???u h?????ng t???i trang hi???n th??? tin nh???n
                Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=>PageFCM_Message(message:message,),)
                );
              }
            );
          }
        },
       );

       //S??? ki???n x??? l?? nh???n tin nh???n???ch??? ????? Foreground
      FirebaseMessaging.onMessage.listen((remoteMessage){
        MessageHelper.fcm_ForegroundHandler(
          message:remoteMessage,
          context:context,
          messageHandler:(context,message){
            setState((){
            incoming_message = message.notification?.body??   "Kh??ng c?? n???i dung";
          });
              // X??? L?? th??m vi???c nh???n tin nh???n ??? ????y
              // C???p nh???t hi???n th?? cho s??? l?????ng tin nh???n cho badge
              MessageHelper.getCountMessage().then(
                (value){
                  setState((){
                      count = value;
                  });
                });
              },
            ); 
          });
                    
        
        } 

  
}