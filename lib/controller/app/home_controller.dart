import 'package:flutter/material.dart';

import '../../model/books.dart';
import '../api/open_book.dart';

class HomeController extends ChangeNotifier {
  final discoverSection = 'Discover More';
  // TODO: Functionality I wanted to implemented #1
  final aboveSection = 'Continue Reading';

  var isLoading = true;

  final OpenBookkApi _openBookkApi = OpenBookkApi();

  List<Books>? discoverbooks;

  Future<void> discoverBooks() async {
    isLoading = true;
    notifyListeners();
    discoverbooks = await _openBookkApi.fetchBooks();
    isLoading = false;
    notifyListeners();
  }
}
