import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/books.dart';

class OpenBookkApi {
  final baseUrl = "https://www.dbooks.org/api/";
  List<Books> books = [];
  String error = "";
  Future<List<Books>?> fetchBooks() async {
    try {
      var response = await http.get(Uri.parse(baseUrl + "recent"));
      if (response.statusCode == 200) {
        // print("Response: ${response.body}");
        var jsonResponse = json.decode(response.body);
        var booksList = jsonResponse['books'];
        print(booksList);
        for (var item in booksList) {
          books.add(Books.fromJson(item));
        }
        return books;
      } else {
        error = "Request failed with status: ${response.statusCode}.";
        return null;
      }
    } catch (e) {
      error = e.toString();
      print(error);
      return null;
    }
  }
}
