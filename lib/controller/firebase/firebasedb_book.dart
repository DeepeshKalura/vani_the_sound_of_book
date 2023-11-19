import 'dart:developer' as developer;

import 'package:firebase_database/firebase_database.dart';

import '../../model/response_book.dart';

class FirebaseDBBook {
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  // TODO: #5 Error handling
  String errorMessage = "";
  List<Book> books = [];
  Future<List<Book>> fetchBooks() async {
    var ref = _firebaseDatabase.ref().child("books");

    var data = await ref.once(DatabaseEventType.value);
    var snapShot = data.snapshot;

    if (snapShot.exists) {
      var value = snapShot.value as Map;
      for (var item in value.values) {
        developer.log("Book added to Firebase: ${item['title']}");
        books.add(Book.fromJson(Map<String, dynamic>.from(item)));
      }
    }

    return books;
  }
}
