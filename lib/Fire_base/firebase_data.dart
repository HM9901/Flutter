// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';

class SinhVien {
  // ignore: non_constant_identifier_names
  String? id, ten, lop, nam_sinh, que_quan, anh;

  // ignore: non_constant_identifier_names
  SinhVien({required this.id, required this.ten, this.lop, this.nam_sinh, this.que_quan, this.anh});

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json["id"] as String,
      ten: json["ten"] as String,
      lop: json["lop"] as String,
      nam_sinh: json["nam_sinh"] as String,
      que_quan: json["que_quan"] as String,
      anh: json["anh"] as String?
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "ten":ten,
      "lop":lop,
      "nam_sinh":nam_sinh,
      "que_quan":que_quan,
      "anh" : anh, 
    };
  }
}

class SinhVienSnapshot {
  SinhVien? sinhvien;
  DocumentReference? docref;

  SinhVienSnapshot({required this.sinhvien, required this.docref});

  factory SinhVienSnapshot.fromSnapshot(DocumentSnapshot docSnap){
    return SinhVienSnapshot(
      sinhvien: SinhVien.fromJson(docSnap.data() as Map<String, dynamic>), 
      docref: docSnap.reference);
  }

  Future<void> capNhat(SinhVien sv) async{
    await docref!.update(sv.toJson());
  }

  Future<void> delete() async{
    await docref!.delete();
  }
  
  static Future<DocumentReference> addNew(SinhVien sv) async {
    return  FirebaseFirestore.instance.collection("SinhVien").add(sv.toJson());
  }

  static Stream<List<SinhVienSnapshot>> getAllSinhVien() {
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("SinhVien").snapshots();
    Stream<List<DocumentSnapshot>> listDocsnap = qs.map((qsnap) => qsnap.docs);

    return listDocsnap.map((lds) =>
       lds.map((Docsnap) => SinhVienSnapshot.fromSnapshot(Docsnap)).toList());
  }
}