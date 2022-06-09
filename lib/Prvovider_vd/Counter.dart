// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends ChangeNotifier {
  //định nghĩa trạng thái
  int _value = 0;
  // int get value => _value; // trạng thái của ứng dụng
  Future<int> getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    _value = await preferences.getInt("counter",) ?? 0;
    return _value;
  }
  void increment() async {
    _value++;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("counter", ++_value).whenComplete(() => notifyListeners());
    // notifyListeners();
    //sau khi tăng goi phương thức notifiListener để cập nhật trạng thái cho ứng dụng
  }
}