import 'package:sqflite/sqflite.dart';



class User {
  int? id;
  String? name, phone, email;

  User({this.id, required this.name, this.phone, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"]
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'phone' : phone,
    'email' : email
  };
}

const String tableName = "Users";
class DatabaseHelper {
  Database? database;
  // ignore: unused_field
  String? _path;
  // phương thức để lấy đc đường dẫn của 
  Future<String?> _getDatabasePath(String databaseName) async {
    String p = await getDatabasesPath();
    String _path = "$p/$databaseName";
    this._path = _path;
    return _path;
  }

  Future <Database?> open() async {
    String? _path = await _getDatabasePath('demo1.db');
    database = await openDatabase(
      _path!,
      version: 2,
      onCreate: (db, version) async {
        db.execute(
          "CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT)"
        );
      },
      
    );
    return database;
  }

  Future<int> insert(User user) async {
    int id = await database!.transaction(
      (Transaction txn) async {
        int id = await txn.rawInsert(
          'INSERT INTO $tableName (name, phone, email) VALUES( ?, ?, ?)',
          [user.name, user.phone, user.email],
        );
        return id;
      }
    
    );
    return id;
  } 

  Future<int> update(User newUser, int id) async {
    int count = await database!.transaction(
      (Transaction txn) async {
        int count = await txn.rawUpdate(
          'UPDATE $tableName SET NAME = ?, PHONE = ?, EMAIL = ? WHERE ID = ?',
          [newUser.name, newUser.phone, newUser, id]
        );
        return count;
      }
    );
    return count;
  } 

  Future<int> delete(int id) async {
     int count = await database!.rawDelete(
       "Delete FROM $tableName WHERE ID = ?",
       [id],
     );
     return count;
  }

  Future<List<User>> getUsers() async {
    List<Map> list = await database!.rawQuery("SELECT * FROM $tableName");
    return list.map((userJson) => User.fromJson(userJson as Map<String, dynamic>)).toList();
  }

  void closeDatabase() async {
    await database!.close();
  }

  void deleteDatabase() async {
    await database!.delete(_path!);
  }

}
