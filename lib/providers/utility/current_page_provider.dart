import 'package:flutter/material.dart';

class CurrentPageProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get selectedIndex => _currentPage;

  void changeCurrentPage(int pageNumber) {
    _currentPage = pageNumber;
    notifyListeners();
  }
}
