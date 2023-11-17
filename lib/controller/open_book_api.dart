import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/books.dart';

class OpenBookkApi {
  final baseUrl = "https://www.dbooks.org/api/";
  List<Books> books = [];

  fetchBooks() async {
    var response = await http.get(Uri.parse(baseUrl + "books"));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      for (var item in jsonResponse) {
        books.add(Books.fromJson(item));
      }
      return books;
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }
}
