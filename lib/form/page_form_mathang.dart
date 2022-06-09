import 'package:flutter/material.dart';
import 'package:flutter_app/form/form_model.dart';

MatHang m = MatHang();
GlobalKey<FormState> formState = GlobalKey<FormState>();
// ignore: must_be_immutable
class PageFormMH extends StatelessWidget {
  PageFormMH({ Key? key }) : super(key: key);

  TextEditingController txtName =  TextEditingController();
  TextEditingController txtSl =  TextEditingController();
  String? dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Demo")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                controller:  txtName,
                onSaved: (newValue) => m.name = newValue,
                validator: (value) => validateString(value),
                decoration: const InputDecoration(
                  labelText: "Tên mặt hàng"
                ),
              ),
              DropdownButtonFormField<String>(
                onChanged: (value) => m.loaiMh = value,
                onSaved: (newValue) => m.loaiMh = newValue,
                value: dropdownvalue,
                validator:  (value) => validateString(value),
                items: loaiMhs.map((loaimh) => DropdownMenuItem<String>(
                  // ignore: unnecessary_string_interpolations
                  child: Text("$loaimh"),
                  value: loaimh
                )).toList(),
                decoration: const InputDecoration(
                  labelText: "Loại mặt hàng"
                )),
              TextFormField(
                controller: txtSl,
                keyboardType: TextInputType.number,
                onSaved: (newValue) => m.soluong = int.parse(newValue!),
                validator: (value) => validateSL(value),
                decoration: const InputDecoration(
                  labelText: "Số lượng"
                )
              ),
              Row(
                mainAxisAlignment:  MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () => _save(context) , child: const Text("Save"))
                ],
              )
            ],
          )
        ),
      ),
    );
  }

validateString(String? value) {

  return value == null || value.isEmpty ? "bạn chưa nhập dữ liệu" : null;
}

validateSL(String? value) {
  if(value == null || value.isEmpty) {
    return "bạn chưa nhập số lượng";
  }
  else {
    return int.parse(value) < 0 ? "Số lượng không được nhỏ hơn 0" : null;
  }
  
}
_save(BuildContext context) {
    if(formState.currentState!.validate()) {
      formState.currentState!.save();
      hienthiDialog(context);
    }
}
}



void hienthiDialog(BuildContext context) {
  var dialog = AlertDialog(
    title:  const Text("Thông báo"),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Tên MH: ${m.name}"),
        Text("Loại MH: ${m.loaiMh}"),
        Text("Số lượng: ${m.soluong}"),
      ],
    ),
    actions: [
      ElevatedButton(onPressed: () {
        Navigator.pop(context);
      }, child: const Text("OK"))
    ],
  );
  showDialog(context: context, builder: (context)=>dialog);
}