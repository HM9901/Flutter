
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
              labelText:"Nội dung tin nhắn",
            ),// Input Decoration
          ),// TextField
          SizedBox(height:10,),
          Center(
            child:ElevatedButton(
              child:const Text("Send message to topic"),// Thực hiện gởi tin nhắn cho Topic
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
  // Lấy Token đã đăng ký khi ứng dụng chạy lần đầu
  // Thông thường,token này sẽ được lưu trên server để có thể được dùng để gởi tin nhắns
  // Lấy mã thông báo FCM mặc định cho thiết bị này.
  FirebaseMessaging.instance.getToken().then(
    (value){
      print("Token message:$value");
      setState((){
        token=value;
      });
   });
  // Đăng ký với topic
  FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(
          (){
        setState((){
          topicStatus=topic;
        });
      });

  
      // Lấy sở lượng tin nhắn và cập nhật lên bagde widget
  MessageHelper.getCountMessage().then(
    (value){
      setState((){
        count=value;
      });
      }
    );

    //Sự kiện xử lý khi người dùng bấm vào tin nhắn trên thanh trạng thái
    //Khi ứng dụng đang chạy dưới background
  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage){
     MessageHelper.fcmOpenMessageHandler(
         context:context,
        message:remoteMessage,
        messageHandler:(context,message){
          
           // Điều hưởng tới trang hiện thị tin nhãn
           Navigator.push(
              context,
              MaterialPageRoute(builder:(context)=>PageFCM_Message(message:message,),)
           );
        },
     );
  });
  
//Sự kiện xử lý khi người dùng bấm vào tin nhắn trên thanh trạng thái
// Khi ứng dụng đangởtrang thái terminate
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage){
        if(remoteMessage!=null){
            MessageHelper.fcmOpenMessageHandler(
              context:context,
              message:remoteMessage,
              messageHandler:(context,message){
                  // Điều hướng tới trang hiện thị tin nhắn
                Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=>PageFCM_Message(message:message,),)
                );
              }
            );
          }
        },
       );

       //Sự kiện xử lý nhận tin nhắnởchế độ Foreground
      FirebaseMessaging.onMessage.listen((remoteMessage){
        MessageHelper.fcm_ForegroundHandler(
          message:remoteMessage,
          context:context,
          messageHandler:(context,message){
            setState((){
            incoming_message = message.notification?.body??   "Không có nội dung";
          });
              // Xử Lý thêm việc nhận tin nhắn ở đây
              // Cập nhật hiển thì cho số lượng tin nhắn cho badge
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