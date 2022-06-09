// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_app/SQlite/page_user_details.dart';
import 'package:flutter_app/SQlite/provider_data.dart';
import 'package:flutter_app/SQlite/sqlite_data.dart';
import 'package:flutter_app/dialogs.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({ Key? key }) : super(key: key);

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  // ignore: unused_field
  BuildContext? _dialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Demo"),
        actions: [
          IconButton(icon: const Icon(Icons.add_circle_outline),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                PageListUserSQLiteDetails(xem: false,)
            )),
          )
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, child) {
          if(databaseProvider.users == null) {
            return const Center(child: Text("Chua co du lieu"));
          }
          else {
            return ListView.separated(
              itemBuilder: (context, index) {
                _dialogContext = context;
                User user = databaseProvider.users![index];
                return Slidable(
                  child: ListTile(
                    leading: Text("${user.id}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    title: Text("${user.name}", style: const TextStyle(fontSize:18, color: Colors.indigo)),
                    subtitle:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Phone: ${user.phone}"),
                        Text("Email: ${user.email}")
                      ],
                    )
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(onPressed: 
                          (context) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PageListUserSQLiteDetails(xem: true, user: user),)
                          ),
                          icon:  Icons.details,
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue[50]!,
                        ),
                        SlidableAction(onPressed: 
                          (context) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PageListUserSQLiteDetails(xem: false, user: user),)
                          ),
                          icon:  Icons.edit,
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue[50]!,
                        ),
                        SlidableAction(onPressed: 
                          (context) => _xoa(_dialogContext!, user),
                          icon:  Icons.delete,
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue[50]!,
                        )
                      ]
                    ),
                  );
              } ,
             separatorBuilder: (context, index) => const Divider(thickness: 1,),
              itemCount: databaseProvider.users!.length);
          }
        },),
    );
  }

  @override
  void dispose() {
    DatabaseProvider provider = context.read<DatabaseProvider>();
    provider.closeDatabase();
  }

  _xoa (BuildContext context, User user) async {
    String? confirm = await showConfirmDialog(context, "ban co mun xoa ${user.name}");
    if(confirm == 'ok'){
      DatabaseProvider provider = context.read<DatabaseProvider>();
      provider.deleteUser(user.id!);
    }
  }
}