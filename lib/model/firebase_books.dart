class FirebaseBook {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String pdfUrl;
  final String review;
  final String author;

  FirebaseBook(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.imageUrl,
      required this.pdfUrl,
      required this.review,
      required this.author});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
      'review': review,
      'author': author,
    };
  }

  factory FirebaseBook.fromMap(Map<String, dynamic> map) {
    return FirebaseBook(
      id: map['id'],
      title: map['title'],
      subTitle: map['subTitle'],
      imageUrl: map['imageUrl'],
      pdfUrl: map['pdfUrl'],
      review: map['review'],
      author: map['author'],
    );
  }
}
