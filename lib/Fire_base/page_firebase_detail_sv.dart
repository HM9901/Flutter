// ignore_for_file: await_only_futures, unused_element, must_be_immutable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Fire_base/firebase_data.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:image_picker/image_picker.dart';

class PageSVDetails extends StatefulWidget {
  SinhVienSnapshot? sinhVienSnapshot;
  bool? xem;
  PageSVDetails({ Key? key, this.sinhVienSnapshot, this.xem }) : super(key: key);

  @override
  State<PageSVDetails> createState() => _PageSVDetailsState();
}

class _PageSVDetailsState extends State<PageSVDetails> {
  SinhVienSnapshot? svs;

  bool _imageChange = false;
  XFile? _xImage;

  bool? xem;
  String? buttonLabel = "Thêm";
  String? title = "Thêm SV mới";
  TextEditingController txtID =  TextEditingController();
  TextEditingController txtten = TextEditingController();
  TextEditingController txtlop = TextEditingController();
  TextEditingController txtnamsinh  = TextEditingController();
  TextEditingController txtquequan = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
            children: [
              SizedBox(
                height: 200,
                child: _imageChange 
                ? Image.file(File(_xImage!.path)) 
                : svs?.sinhvien!.anh != null 
                  ? Image.network(svs!.sinhvien!.anh!) 
                  : null,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: xem!=true ? () => _chonAnh(context): null , 
                    child: const Icon(Icons.image))
                ],
              ),
              TextField(
                controller: txtID,
                decoration: const InputDecoration(
                  label: Text("ID: "),
                )
              ),
              TextField(
                controller: txtten,
                decoration: const InputDecoration(
                  label: Text("Tên: "),
                )
              ),
              TextField(
                controller: txtlop,
                decoration: const InputDecoration(
                  label: Text("Lớp: "),
                )
              ),
              TextField(
                controller: txtnamsinh,
                decoration: const InputDecoration(
                  label: Text("năm sinh: "),
                )
              ),
              TextField(
                controller: txtquequan,
                decoration: const InputDecoration(
                  label: Text("quê quán: "),
                )
              ),
              const SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () async{
                    if(xem == true){
                      Navigator.pop(context);
                    }
                    else {
                      _capNhat(context);
                    }
                  }, 
                  child: Text(buttonLabel!),),
                   const SizedBox(height: 10),
                   xem == true ? const SizedBox(width: 1) : ElevatedButton(
                     onPressed: () => Navigator.pop(context),
                     child: const Text("Dong'")),
                   const SizedBox(width: 10) 
                ],
              )
            ],
          ),  
        ),
      ) ,
    );
  }

  @override 
  void initState() {
    super.initState();
    svs = widget.sinhVienSnapshot;
    xem = widget.xem;
    if(svs != null) {
      txtID.text = svs!.sinhvien!.id?? " ";
      txtten.text = svs!.sinhvien!.ten??"";
      txtlop.text = svs!.sinhvien!.lop??"";
      txtnamsinh.text = svs!.sinhvien!.nam_sinh??"";
      txtquequan.text = svs!.sinhvien!.que_quan??"";

      if(xem == true) {
        title = "Thông Tin Sinh Viên";
        buttonLabel = " Đóng";
      }
      else {
        title = "Cập Nhật Thông Tin";
        buttonLabel = "Cập Nhật";
      }
    }
  }
  _chonAnh( BuildContext context) async {
    _xImage =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_xImage != null) {
      setState(() {
        _imageChange = true;
      });
    }
  }

  _capNhat( BuildContext context) async {
    showSnackBar(context, "Dang Cap Nhat du lieu", 3);
    SinhVien sv = SinhVien(
      id: txtID.text,
      ten: txtten.text,
      lop: txtlop.text,
      nam_sinh: txtnamsinh.text,
      que_quan: txtquequan.text,
      anh:  null
    );
    if(_imageChange){
      FirebaseStorage _storage =  FirebaseStorage.instance;
      Reference reference = 
        _storage.ref().child("images").child("anh_${sv.id}.jpg");

      UploadTask uploadTask = await _uploadTask(reference, _xImage);
      uploadTask.whenComplete(() async{
        sv.anh = await reference.getDownloadURL();
        if(svs != null){
          sv.anh = svs!.sinhvien!.anh;
          _capNhatSV(svs, sv);
        }
        else {
          _themSV(sv);

        }
      }).onError((error, stackTrace) {
        return Future.error("Loi xay ra");
      } );
    }
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile? xImage) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': xImage!.path});
    UploadTask uploadTask;
    if(kIsWeb){
      uploadTask = reference.putData(await xImage.readAsBytes(), metadata);
    }
    else {
      uploadTask = reference.putFile(File(xImage.path), metadata);
    }
      return Future.value(uploadTask);
  }

  _capNhatSV(SinhVienSnapshot? svs, SinhVien sv) {
    svs!.capNhat(sv).whenComplete(() => 
      showSnackBar(context, "Cap nhat du lieu thanh cong", 3))
      .onError((error, stackTrace)=>
      showSnackBar(context,"Cap Nhat du lieu khong thanh cong", 3)
      );
  }

  _themSV(SinhVien sv) {
    SinhVienSnapshot.addNew(sv).whenComplete(() => 
      showSnackBar(context, "them du lieu thanh cong", 3))
      .onError((error, stackTrace){
        showSnackBar(context,"them du lieu khong cong", 3);
        return Future.error("Loi khi them");
      });
  }
}

