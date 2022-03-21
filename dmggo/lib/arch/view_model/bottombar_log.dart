import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentBar => _currentIndex;


  set current(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}