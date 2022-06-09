import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

Future<String?> showConfirmDialog(BuildContext context, String disMessage) async {
  AlertDialog dialog = AlertDialog(
    title : const Text("Xac nhan"),
    content: Text(disMessage),
    actions: [
      ElevatedButton(onPressed: () => Navigator.of(context, rootNavigator: true).pop("cancel"),
       child: const Text("hủy"),),
      ElevatedButton(onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
      child: const Text("OK"))
    ]
  );
  String? res = await showDialog<String?>(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );
  return res;
}

void showSnackBar(BuildContext context, String message, int seconds) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: seconds)),
  );
}