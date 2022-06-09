// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:flutter_app/login/FireBaseHome.dart';
import 'package:flutter_app/login/page_register.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'Login.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}
GlobalKey<FormState> formState = GlobalKey<FormState>();
class _MyLoginPageState extends State<MyLoginPage> {
  String? thongBaoLoi="";
  @override
  Widget build(BuildContext context) {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login")
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(50) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: txtEmail,
                  decoration: const InputDecoration(
                    hintText: 'UserName'
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  controller: txtPass,
                  decoration: const InputDecoration(
                    hintText: 'Password'
                  ),
                  obscureText: true,
                ),
                const SizedBox(height:10),
                SignInButtonBuilder(
                  text: 'Sign in with email',
                  icon: Icons.email,
                  onPressed: () async{
                    showSnackBar(context, "Signing in ...", 300);
                    if(txtEmail.text!= "" && txtPass.text != ""){
                      thongBaoLoi = "";
                      showSnackBar(context, "Signing in ...", 300);
                      signWithEmailPassword(email: txtEmail.text, password: txtPass.text)
                      .then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeFireBase(),)
                            , (Route<dynamic> route) => false);
                        showSnackBar(context,
                            'Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}', 5);
                      }).catchError((error) {
                        setState(() {
                          thongBaoLoi = error.toString();
                        });
                        showSnackBar(context, "Sign in not successfully", 3);
                      })
                      ;

                    }

                  },
                  backgroundColor: Colors.blueGrey[700]!,
                  width: 220.0,
                ),
                SignInButton(
                  Buttons.Google, 
                  onPressed: () async {
                    showSnackBar(context, "Signing in ...", 300);
                    var user = await signWithGoogle();
                     if (user != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeFireBase(),)
                          , (Route<dynamic> route) => false);
                      showSnackBar(context,
                          'Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}', 5);
                    }
                    else {
                      setState(() {

                      });
                      showSnackBar(context, "Sign in not succesfully", 3);
                    }
                  }),
                  SizedBox(height: 20,),
                Row(
                  children: [
                      Text("Dont have an account? "),
                      const SizedBox(width: 3,),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyRegister(),));
                      }, child: Text("register"))
                    ],),
                    ElevatedButton(
                  onPressed: () async {
                    await signWithGoogle().whenComplete(() =>
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const HomeFireBase())))
                    ;

                    //page firebase
                  }, child: Text("Đăng Nhập")

                ),
                Text("${thongBaoLoi}")
              ],
            ) ,
          ),
        ),
      )
    );
  }
}

validateString(String? value) {

  return value == null || value.isEmpty ? "bạn chưa nhập dữ liệu" : null;
}