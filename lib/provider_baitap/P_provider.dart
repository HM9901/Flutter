// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:provider/provider.dart';

// TextEditingController txtTen = TextEditingController();
// TextEditingController txtMoTa = TextEditingController();
// TextEditingController txtGia = TextEditingController();
// late BuildContext listViewContext;

// class SanPhamPage extends StatelessWidget {
//   const SanPhamPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Danh sách sản phẩm"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //       builder: (context) => ChiTietPage(),
//                 //     ));
//                 _showDialog(context, type: "them");
//               },
//               icon: const Icon(
//                 Icons.add_circle_rounded,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: Consumer<QLSanPham>(
//         builder: (context, qlspham, child) {
//           listViewContext = context;
//           return ListView.separated(
//               itemBuilder: (context, index) {
//                 return Slidable(
//                     endActionPane: ActionPane(
//                       motion: const DrawerMotion(),
//                       children: [
//                         SlidableAction(
//                           onPressed: (context) async {
//                             String? confirm = await showConfirmDialog(
//                                 listViewContext,
//                                 "Bạn có muốn xóa sp ${qlspham.list[index].ten} ?");
//                             if (confirm == "ok") {
//                               qlspham.delete(index);
//                             }
//                           },
//                           backgroundColor: const Color.fromARGB(255, 243, 5, 5),
//                           foregroundColor: Colors.white,
//                           icon: Icons.delete_forever,
//                           label: 'Xóa',
//                         ),
//                         SlidableAction(
//                           onPressed: (context) {
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //       builder: (context) =>
//                             //           ChiTietPage(sp: qlspham.list[index]),
//                             //     ));
//                             _showDialog(listViewContext,
//                                 type: "sua", index: index);
//                           },
//                           backgroundColor: const Color(0xFF0392CF),
//                           foregroundColor: Colors.white,
//                           icon: Icons.edit,
//                           label: 'Sửa',
//                         ),
//                         SlidableAction(
//                           onPressed: (context) => _showDialog(listViewContext,
//                               type: "xem", index: index),
//                           backgroundColor:
//                               const Color.fromARGB(255, 6, 233, 40),
//                           foregroundColor: Colors.white,
//                           icon: Icons.visibility,
//                           label: 'Xem',
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       title: Text(qlspham.list[index].ten),
//                       leading: const Icon(
//                         Icons.shopping_cart,
//                         color: Colors.blue,
//                       ),
//                       subtitle: Text(qlspham.list[index].moTa),
//                       trailing: Text("${qlspham.list[index].gia}"),
//                     ));
//               },
//               separatorBuilder: (context, index) => const Divider(
//                     thickness: 2,
//                   ),
//               itemCount: qlspham.list.length);
//         },
//       ),
//     );
//   }

// //------------------------------------------------------------------------------
//   void _showDialog(BuildContext context, {int? index, required String type}) {
//     AlertDialog dialog;
//     var provider = context.read<QLSanPham>();

//     switch (type) {
//       case "them":
//         dialog = AlertDialog(
//           title: const Text("Thêm mới"),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: txtTen,
//                 decoration: const InputDecoration(
//                   labelText: "Tên sản phẩm:",
//                 ),
//               ),
//               TextFormField(
//                 controller: txtMoTa,
//                 decoration: const InputDecoration(
//                   labelText: "Mô tả:",
//                 ),
//               ),
//               TextFormField(
//                 controller: txtGia,
//                 decoration: const InputDecoration(
//                   labelText: "Giá bán:",
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   var provider = context.read<QLSanPham>();
//                   provider.add(SanPham(
//                       ten: txtTen.text,
//                       moTa: txtMoTa.text,
//                       gia: int.parse(txtGia.text)));

//                   txtTen.clear();
//                   txtMoTa.clear();
//                   txtGia.clear();

//                   Navigator.of(context, rootNavigator: true).pop(true);
//                 },
//                 child: const Text("Thêm"))
//           ],
//         );
//         break;
//       case "sua":
//         txtTen.text = provider.list[index!].ten;
//         txtMoTa.text = provider.list[index].moTa;
//         txtGia.text = provider.list[index].gia.toString();

//         dialog = AlertDialog(
//           title: const Text("Sửa"),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: txtTen,
//                 decoration: const InputDecoration(
//                   labelText: "Tên sản phẩm:",
//                 ),
//               ),
//               TextFormField(
//                 controller: txtMoTa,
//                 decoration: const InputDecoration(
//                   labelText: "Mô tả:",
//                 ),
//               ),
//               TextFormField(
//                 controller: txtGia,
//                 decoration: const InputDecoration(
//                   labelText: "Giá bán:",
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   provider.update(
//                       index,
//                       SanPham(
//                           ten: txtTen.text,
//                           moTa: txtMoTa.text,
//                           gia: int.parse(txtGia.text)));

//                   txtTen.clear();
//                   txtMoTa.clear();
//                   txtGia.clear();

//                   Navigator.of(context, rootNavigator: true).pop(true);
//                 },
//                 child: const Text("Sửa"))
//           ],
//         );
//         break;
//       case "xem":
//         dialog = AlertDialog(
//           title: const Text("Chi tiết sản phẩm:"),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Tên SP: ${provider.list[index!].ten}"),
//               Text("Mô tả: ${provider.list[index].moTa}"),
//               Text("Giá: ${provider.list[index].gia}"),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//                 onPressed: () =>
//                     Navigator.of(context, rootNavigator: true).pop(true),
//                 child: const Text("OK"))
//           ],
//         );
//         break;
//       default:
//         return;
//     }

//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) => dialog);
//   }

//   Future<String?> showConfirmDialog(
//       BuildContext context, String dispMessage) async {
//     AlertDialog dialog = AlertDialog(
//       title: const Text("Xác nhận"),
//       content: Text(dispMessage),
//       actions: [
//         ElevatedButton(
//             onPressed: () =>
//                 Navigator.of(context, rootNavigator: true).pop("cancel"),
//             child: Text("Huỷ")),
//         ElevatedButton(
//             onPressed: () =>
//                 Navigator.of(context, rootNavigator: true).pop("ok"),
//             child: Text("Ok")),
//       ],
//     );

//     String? res = await showDialog<String?>(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) => dialog);
//     return res;
//   }
// }