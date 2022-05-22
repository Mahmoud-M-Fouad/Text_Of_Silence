
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProvider with ChangeNotifier {
  int _count = 0;

    int get count => _count;
  setindex(int i)
  {
    _count=i;
    notifyListeners();
  }
  void increment() {
    _count++;
    notifyListeners();
  }
}