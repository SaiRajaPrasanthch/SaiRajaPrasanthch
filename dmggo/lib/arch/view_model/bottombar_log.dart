import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  int _unReadCount = 0;

  get unReadCount => _unReadCount;
  get currentBar => _currentIndex;

  set current(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set setUnReadCount(int value) {
    _unReadCount = value;
    notifyListeners();
  }

  update(int va) {
    setUnReadCount = va;
  }
}
