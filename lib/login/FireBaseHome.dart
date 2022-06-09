import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Fire_base/firebase_data.dart';
import 'package:flutter_app/Fire_base/page_firebase_detail_sv.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:flutter_app/login/page_login.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeFireBase extends StatefulWidget {
  const HomeFireBase({Key? key}) : super(key: key);

  @override
  State<HomeFireBase> createState() => _HomeFireBaseState();
}

class _HomeFireBaseState extends State<HomeFireBase> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fire Base Home"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageSVDetails(xem: false, sinhVienSnapshot: null,),));
          }, icon:Icon(Icons.add_circle_outline))
        ],
      ),
      drawer: Container(
        width: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Firebase App"),
            SizedBox(
              height: 50,
            ),
            TextButton(onPressed: () {
                showSnackBar(context, "Signing out....", 300);
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyLoginPage(),), (route) => false);
                  showSnackBar(context, "Please sign in!", 5);
                }).catchError((error) {
                  showSnackBar(context, "Sign out not successfully", 3);
                });
            }, child: Row(
              children: [
                Icon(Icons.assignment_return_outlined),
                SizedBox(width: 5,),
                Text("Sign out")
              ],
            ))
          ],
        ),
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          else
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            else {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 2,),
                  itemBuilder: (context, index) {
                    dialogContext=context;
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            icon: Icons.details,
                              foregroundColor: Colors.green,
                              onPressed: (context) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      PageSVDetails(
                                        xem: true,
                                        sinhVienSnapshot: snapshot.data![index],),));
                              },),
                          SlidableAction(
                            icon: Icons.edit,
                            foregroundColor: Colors.blue,
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PageSVDetails(xem: false, sinhVienSnapshot: snapshot.data![index],),));
                            },),
                          SlidableAction(
                            icon: Icons.delete,
                            foregroundColor: Colors.red,
                            onPressed: (context) {
                                _xoa(dialogContext!,snapshot.data![index]);
                            },),
                        ],
                      ),
                        child:
                    ListTile(
                      leading: Text("${snapshot.data![index].sinhvien!.id}",
                      style: TextStyle(
                          fontSize: 20,
                         fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text("${snapshot.data![index].sinhvien!.lop}"),
                      title: Text("${snapshot.data![index].sinhvien!.ten}"),
                    ));
                  },
                  itemCount: snapshot.data!.length);
            }
        },
        stream: SinhVienSnapshot.getAllSinhVien(),
      ),
    );

  }
  void _xoa(BuildContext context,SinhVienSnapshot svs) async{
    String? confirm;
    confirm = await showConfirmDialog(context, "Bạn có muốn xóa sv: ${svs.sinhvien!.ten} ?");
    if(confirm == "ok"){
      FirebaseStorage _storeage = FirebaseStorage.instance;
      Reference reference = _storeage.ref().child("images").child("anh_${svs.sinhvien!.id}.jpg");
      reference.delete().whenComplete(() => showSnackBar(context,"Xóa ảnh không thành công",3)
      ).onError((error, stackTrace) {
        showSnackBar(context, "Xoá ảnh không thành công", 3);
        return Future.error(error.toString());
      }
      );
      svs.delete().whenComplete(() => showSnackBar(context, "Xóa dữ liệu thành công", 3))
      .onError((error, stackTrace) {
        showSnackBar(context, "Xóa dữ liệu không thành công", 3);
        return Future.error("Xóa dữ liệu không thành công");
      });
    }
  }
  }
