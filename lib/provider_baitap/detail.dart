import 'package:flutter/material.dart';
import 'package:flutter_app/provider_baitap/sanpham_provider.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  SanPham? sp;
  

  Detail({ Key? key, this.sp }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String labelButton = "Thêm";
  bool them = true;
  // ignore: non_constant_identifier_names
  SanPham? spOld, SpNew;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescrip = TextEditingController();
  TextEditingController txtgia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("labelButton"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtName,
            decoration: const InputDecoration(labelText:"Tên sản phẩm"),
          ),
          TextField(
            controller: txtDescrip,
            // validator: (value) => validateString(value),
            decoration: const InputDecoration(labelText:"Mô Tả"),
          ),
          TextField(
            controller: txtgia,
            decoration: const InputDecoration(labelText:"Giá"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {
                if (them == true){
                  themMoi();
                }
                else { Capnhat();}
              }, child: Text("$labelButton sản phẩm"))
            ]
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    spOld = widget.sp;
    if(spOld != null){
      labelButton = "update"; 
      them = false;  
      txtName.text = spOld!.ten;
      txtDescrip.text = spOld!.descrip;
      txtgia.text = (spOld!.gia).toString();
    }
  }
  void themMoi() {
  SpNew = SanPham(ten: txtName.text, gia: double.parse(txtgia.text), descrip: txtDescrip.text);
  var provider = context.read<QLSanPham>();
  provider.add(SpNew!);
  txtName.clear();
  txtDescrip.clear();
  txtgia.clear();

  Navigator.of(context).pop(true);
}

// ignore: non_constant_identifier_names
void Capnhat() {
    SpNew = SanPham(ten: txtName.text, gia: double.parse(txtgia.text), descrip: txtDescrip.text);
    var provider = context.read<QLSanPham>();
  provider.update(provider.list.indexOf(spOld!), SpNew!);
  txtName.clear();
  txtDescrip.clear();
  txtgia.clear();

  Navigator.of(context).pop(true);
  }

validateString(String? value) {

  return value == null || value.isEmpty ? "bạn chưa nhập dữ liệu" : null;
}

validateSL(String? value) {
  if(value == null || value.isEmpty) {
    return "bạn chưa nhập số lượng";
  }
  else {
    return double.parse(value) < 0 ? "Số lượng không được nhỏ hơn 0" : null;
  }
  
}
}
