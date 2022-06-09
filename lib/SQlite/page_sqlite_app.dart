// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_app/SQlite/page_home_sqlite.dart';
import 'package:flutter_app/SQlite/provider_data.dart';
import 'package:provider/provider.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({ Key? key }) : super(key: key);

  @override
  State<SQLiteApp> createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUser();
        return databaseProvider;
        },
        // ignore: prefer_const_constructors
        child: MaterialApp(
          title: "SQLite Demo App",
          home: const PageListUserSQLite(),
        ),
    );
  }
}