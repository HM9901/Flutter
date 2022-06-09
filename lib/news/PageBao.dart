// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


// ignore: must_be_immutable
class PageBao extends StatefulWidget {
  String? link;
  PageBao({ Key? key, required this.link }) : super(key: key);

  @override
  State<PageBao> createState() => _PageBaoState();
}

class _PageBaoState extends State<PageBao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VNExpress"),
      ),
      body: WebView(
        zoomEnabled: true,
        initialUrl: '${widget.link}',
      )
    );
  }
  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }
}