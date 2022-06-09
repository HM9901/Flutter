import 'package:flutter/material.dart';
import 'package:flutter_app/provider_baitap/Provider_page.dart';
import 'package:flutter_app/provider_baitap/sanpham_provider.dart';
import 'package:provider/provider.dart';

class SanPhamApp extends StatelessWidget {
  const SanPhamApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QLSanPham(),
      child: const MaterialApp(home: MyProviderPage(),),

    );
  }
}