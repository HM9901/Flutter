import 'package:flutter/foundation.dart';
class SanPham {
  late String ten;
  late double gia;
  late String descrip;

  SanPham({required this.ten,required this.gia,required this.descrip});
}
class QLSanPham extends ChangeNotifier{
  late final List<SanPham> _listSp = [
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
  SanPham(ten: "Mít", gia: 20000, descrip: "Mít Thái loại 1"),
];
  List<SanPham> get list => _listSp ;
  void delete(int index) {
    // ignore: list_remove_unrelated_type
    _listSp.removeAt(index);
    notifyListeners();
  }

  void update (int index, SanPham moi) {
    _listSp[index]=moi;
    notifyListeners();
  }

  void add(SanPham index) {
    _listSp.add(index);
    notifyListeners();
  }
}

