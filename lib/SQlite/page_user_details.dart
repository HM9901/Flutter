// ignore_for_file: must_be_immutable, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_app/SQlite/provider_data.dart';
import 'package:flutter_app/SQlite/sqlite_data.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:provider/src/provider.dart';

class PageListUserSQLiteDetails extends StatefulWidget {
  bool? xem;
  User? user;
  PageListUserSQLiteDetails({ Key? key, this.xem, this.user}) : super(key: key);

  @override
  State<PageListUserSQLiteDetails> createState() => _PageListUserSQLiteDetailsState();
}

class _PageListUserSQLiteDetailsState extends State<PageListUserSQLiteDetails> {
  bool? xem;
  User? user;
  String title = "thong tin User";
  String buttonTitle = "Dong'";
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(label:Text("Ten")),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: txtPhone,
                decoration: const InputDecoration(label:Text("Phone")),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: txtEmail,
                decoration: const InputDecoration(label:Text("Email")),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () => _capNhat(context)
                  , child: Text(buttonTitle),
                  ),
                  const SizedBox(height: 10),
                  xem == true ? const SizedBox(width:  1,): 
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Dong"),
                  )
                ],
              )
            ]  
          ),
        )
      ),
    );
  }
  @override
  void initState() {
    super.initState(); 
    xem = widget.xem;
    user = widget.user;

    if(user != null) {
      if(xem != null) {
        buttonTitle = " Cap Nhat";
        title = "Chinh Sua Thong TIn";
      }
      txtTen = user!.name! as TextEditingController;
      txtPhone = user!.phone! as TextEditingController;
      txtEmail = user!.email! as TextEditingController;
    }
    else {
      buttonTitle = "Them";
      title = "Them User";
    }
  }

  @override
  void dispose() {
    super.dispose();
    txtTen.dispose();
    txtPhone.dispose();
    txtEmail.dispose();
  }

  _capNhat(BuildContext context) async {
    if(xem == true) {
      Navigator.of(context).pop();
    }
    else {
      DatabaseProvider provider = context.read<DatabaseProvider>();
      User nUser = User(
        name: txtTen.text,
        phone: txtPhone.text,
        email: txtEmail.text
      );
      if(user == null) {
        int id = -1;
        id = await provider.insertUser(nUser);
        if(id>0){
          showSnackBar(context, "Da them ${nUser.name}", 3);
        }
        else {
          showSnackBar(context, "Them ${nUser.name} khong thanh cong", 3);
        }
      }
      else {
        int count = 1;
        count = await provider.updateUser(nUser, user!.id!);
        if(count>0){
          showSnackBar(context, "Da Cap Nhat ${nUser.name}", 3);
        } 
        else {
          showSnackBar(context, "Cap Nhat ${nUser.name} khong thanh cong", 3);
         }

      }
    }
  }
}