import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class ReadPdfController extends ChangeNotifier {
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  int? bookMarkNumber;

  int currentPageNumber = 0;
  int totalPageNumber = 0;

  void changeFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void fetchBookMarkNumber(int? number) {
    bookMarkNumber = number;
    notifyListeners();
  }

  void fetchPageNumber(int current, int total) {
    developer.log("current: $current, total: $total");
    currentPageNumber = current;
    totalPageNumber = total;
    notifyListeners();
  }
}
