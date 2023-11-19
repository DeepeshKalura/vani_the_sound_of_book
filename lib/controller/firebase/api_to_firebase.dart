import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:uuid/uuid.dart';

import '../../model/books.dart';
import '../../model/firebase_books.dart';
import '../api/open_book.dart';

// ! #4 Make a bot which will fetch the data from the different website and save it to the firebase database.

class ApiToFirebase {
  OpenBookkApi openBookApi = OpenBookkApi();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<void> discoverBooks() async {
    await openBookApi.fetchBooks();
  }

  Future<void> addBookToFirebase() async {
    if (openBookApi.error == "") {
      for (var books in openBookApi.books) {
        var imageUrl = await downloadData(books);
        var pdfUrl = await loadingPdf(books);

        developer.log("Book added to Firebase: ${books.title}");

        // Firebase Mey firestore data save kerna hai

        final id = Uuid().v4();
        var ref = _firebaseDatabase.ref("books/$id");

        final book = FirebaseBook(
          id: id,
          title: books.title ?? "No title Found",
          subTitle: books.subtitle ?? "No subtitle Found",
          imageUrl: imageUrl,
          pdfUrl: pdfUrl,
          review: "0",
          author: books.authors ?? "No authors Found",
        );

        await ref.set(
          book.toMap(),
        );
      }
    } else {
      developer.log("Error: ${openBookApi.error}");
    }
  }

  String _convertToCamelCase(String input) {
    List<String> words = input.split(RegExp(r'\s+|\.+|-+'));

    if (words.isEmpty) {
      return '';
    }

    String camelCase = words[0].toLowerCase();

    for (int i = 1; i < words.length; i++) {
      camelCase +=
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    return camelCase;
  }

  Future<String> downloadData(Books books) async {
    if (openBookApi.error == "") {
      if (books.image != null) {
        try {
          var response = await http.get(Uri.parse(books.image!));
          if (response.statusCode == 200) {
            var bytes = response.bodyBytes;

            var fileExtension = books.image?.split('.').last ?? 'jpg';

            var title = _convertToCamelCase(books.title ?? "No title Found");

            var downloadUrl = await _uploadImage(bytes, title, fileExtension);

            developer.log(
                "Image uploaded to Firebase Storage for book: ${books.title}");

            if (downloadUrl != "error") {
              developer.log("Sucess get the download url of upload the image");
              return downloadUrl;
            } else {
              developer
                  .log("Failed to get the download url of upload the image");
              return "error";
            }
          } else {
            developer.log(
                "Failed to download image. Status code: ${response.statusCode}");
            return "error";
          }
        } catch (error) {
          developer.log("Error downloading and uploading image: $error");
          return "error";
        }
      } else {
        developer.log("No image");
        return "error";
      }
    } else {
      developer.log("Error: ${openBookApi.error}");
      return "error";
    }
  }

  Future<String> _uploadImage(
      Uint8List image, String title, String imageExtension) async {
    try {
      final storageRef = _firebaseStorage.ref();
      final imageRef = storageRef.child("images/$title.$imageExtension");
      await imageRef.putData(
          image, SettableMetadata(contentType: 'image/$imageExtension'));
      developer.log("Image uploaded to Firebase Storage for book: $title");
      var downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      developer.log(e.toString());
      return "error";
    } catch (e) {
      developer.log(e.toString());
      return "error";
    }
  }

  Future<String> loadingPdf(Books books) async {
    final String baseUrl = 'https://www.dbooks.org';
    if (openBookApi.error == "") {
      if (books.url != null) {
        try {
          var response = await http.get(Uri.parse(books.url!));
          if (response.statusCode == 200) {
            // print(response.body.toString());
            var htmlContent = response.body.toString();

            var document = parse(htmlContent);
            var pdfLinkElement = document.querySelector('a.btn-down');
            if (pdfLinkElement != null) {
              var pdfLink = pdfLinkElement.attributes['href'];
              developer.log("Pdf: $baseUrl$pdfLink");
              final downloadedPdfLink = "$baseUrl$pdfLink";
              developer.log("Sucess to get the pdf from the link ");
              var downloadUrl = await downloadPdf(downloadedPdfLink, books);
              if (downloadUrl != "error") {
                developer.log("Sucess get the download url of upload the pdf");
                return downloadUrl;
              } else {
                developer
                    .log("Failed to get the download url of upload the pdf");
                return "error";
              }
            } else {
              developer.log("No pdf link found");
              return "error";
            }
          } else {
            developer.log(
                "Failed to download pdf. Status code: ${response.statusCode}");
            return "error";
          }
        } catch (error) {
          developer.log("Error downloading and uploading pdf: $error");
          return "error";
        }
      } else {
        developer.log("No pdf");
        return "error";
      }
    } else {
      developer.log("Error: ${openBookApi.error}");
      return "error";
    }
  }

  Future<String> downloadPdf(String pdfLink, Books books) async {
    try {
      var response = await http.get(Uri.parse(pdfLink));
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        var fileExtension = 'pdf';

        var title = _convertToCamelCase(books.title ?? "No title Found");

        developer.log("Complete to upload the PDF.");
        var downloadUrl = await _uploadPdf(bytes, title, fileExtension);
        if (downloadUrl != "error") {
          return downloadUrl;
        } else {
          return "error";
        }
      } else {
        developer.log("Failed to download PDF ${response.statusCode}");
        return "error";
      }
    } catch (error) {
      developer.log("Error downloading PDF: $error");
      return "error";
    }
  }

  Future<String> _uploadPdf(
      Uint8List pdf, String title, String pdfExtension) async {
    try {
      final storageRef = _firebaseStorage.ref();
      final pdfRef = storageRef.child("pdf/$title.$pdfExtension");
      await pdfRef.putData(
          pdf, SettableMetadata(contentType: 'pdf/$pdfExtension'));
      developer.log("Pdf uploaded to Firebase Storage for book: $title");
      var downloadUrl = await pdfRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      developer.log(e.toString());
      return "error";
    } catch (e) {
      developer.log(e.toString());
      return "error";
    }
  }
}
