import 'package:flutter/material.dart';
import 'package:vani/model/response_book.dart';

import '../firebase/firebasedb_book.dart';

class HomeController extends ChangeNotifier {
  final discoverSection = 'Discover More';
  // TODO: Functionality I wanted to implemented #1
  final aboveSection = 'Continue Reading';

  var isLoading = true;

  final FirebaseDBBook _firebaseDBBook = FirebaseDBBook();

  List<Book> discoverBook = [];

  Future<void> discoverBooks() async {
    isLoading = true;
    notifyListeners();
    discoverBook = await _firebaseDBBook.fetchBooks();
    isLoading = false;
    notifyListeners();
  }
}
