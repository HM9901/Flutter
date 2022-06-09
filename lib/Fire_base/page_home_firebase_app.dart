

// ignore_for_file: sort_child_properties_last

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Fire_base/firebase_data.dart';
import 'package:flutter_app/Fire_base/page_firebase_detail_sv.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PageSinhVien extends StatefulWidget {
  const PageSinhVien({Key? key}) : super(key: key);

  @override
  State<PageSinhVien> createState() => _PageSinhVienState();
}

class _PageSinhVienState extends State<PageSinhVien> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My FireBase App"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageSVDetails(xem: false,),),
                      ),
            icon: const Icon(Icons.add_circle_outline, color: Colors.white)
          )
        ],
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream:  SinhVienSnapshot.getAllSinhVien(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error.toString()} ")
            );
          }
          else if(!snapshot.hasData){
            return const Center(
              child: Text("Đang tải dữ liệu...")
            );
          }
          else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(thickness: 1,), 
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                dialogContext = context;

                return Slidable(
                child: ListTile(
                  leading: Text("${snapshot.data![index].sinhvien!.id}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                  title: Text("${snapshot.data![index].sinhvien!.ten}"),
                  subtitle: Text("${snapshot.data![index].sinhvien!.lop}")
                ),
                endActionPane:  ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PageSVDetails(xem: true, sinhVienSnapshot: snapshot.data![index]),)
                      ),
                      icon: Icons.details,
                      foregroundColor: Colors.green,
                    ),
                    SlidableAction(onPressed: (context) => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PageSVDetails(xem: false, sinhVienSnapshot: snapshot.data![index]),)
                      ),
                      icon: Icons.edit,
                      foregroundColor: Colors.blue,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _xoa(dialogContext!, snapshot.data![index]);
                      },
                      icon: Icons.delete_forever,
                      foregroundColor: Colors.red,
                    )
                  ],
                  
                ),
                ); 
              } 
              
              );
          }
        },
      ),
    );
  }

  void _xoa(BuildContext context, SinhVienSnapshot svs) async {
    String? confirm;
    confirm = await showConfirmDialog(context, "Bạn có muốn xóa sv: ${svs.sinhvien!.ten}?");
    if(confirm == "ok") {
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child("anh_${svs.sinhvien!.id}.jpg");
      reference.delete();
      svs.delete().whenComplete( ()=> showSnackBar(context,"Xóa dữ liệu thành công", 3))
      .onError((error, stackTrace) {
      showSnackBar(context,"Xóa dữ liệu không thành công", 3);
      return Future.error("Xóa dữ liệu không thành công");
      });
    }
  }
}