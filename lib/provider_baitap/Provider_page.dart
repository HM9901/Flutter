// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/provider_baitap/sanpham_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../dialogs.dart';
import 'detail.dart';

class MyProviderPage extends StatefulWidget {
  const MyProviderPage({ Key? key }) : super(key: key);

  @override
  State<MyProviderPage> createState() => _MyProviderPageState();
}

class _MyProviderPageState extends State<MyProviderPage> {

  
  @override
  Widget build(BuildContext context) {
    BuildContext listViewContext;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh Sách Sản Phẩm"),
        actions: [
          IconButton(onPressed: () {
                      //context của this cũ
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => Detail(),)
                      );
                    }, icon: const Icon(Icons.add),)
        ],
      ),
      body:
      Consumer<QLSanPham> 
      // ignore: non_constant_identifier_names
      (builder: (context, QLSP, child)  {
        listViewContext = context;
        return ListView.builder(
          itemCount: QLSP.list.length,
          itemBuilder: (context, index)
          {
            //_buildRow(listSP[index], Icons.shopping_cart_sharp);
            return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),
              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      String? confirm = await showConfirmDialog(listViewContext,"Bạn có muốn xóa sản phẩm ${QLSP.list[index].ten}");
                      if(confirm == "ok"){
                        var provider = listViewContext.read<QLSanPham>();
                        provider.delete(index);
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      //context của this cũ
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => Detail(sp: QLSP.list[index]),)
                      );
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.addchart_outlined,
                    label: 'Update',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      //context của this cũ
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => Detail(sp: QLSP.list[index]),)
                      );
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.visibility,
                    label: 'Detail',
                  ),
                ],
              ),
              child: _buildRow(QLSP.list[index], Icons.shopping_cart_sharp),
              // The child of the Slidable is what the user sees when the
              // component is not dragged.

            );
          }
      );
      })
      
    );
    
  }
  Widget _buildRow(SanPham sp,IconData icon){
    return ListTile(
      title: Text(sp.ten,
        style:const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),),
      subtitle: Text(sp.descrip,style: const TextStyle(fontSize: 15,)),
      leading: Badge(
        badgeContent: const Text("1"),
        child: Icon(icon,
        color: Colors.blue[500],
        ),
      ),
      trailing: Text("Giá: ${sp.gia}/kg",
        style: const TextStyle(color: Colors.green),),
    );
  }
}

