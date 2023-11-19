class Book {
  String? author;
  String? id;
  String? imageUrl;
  String? pdfUrl;
  String? review;
  String? subTitle;
  String? title;

  Book(
      {this.author,
      this.id,
      this.imageUrl,
      this.pdfUrl,
      this.review,
      this.subTitle,
      this.title});

  Book.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    pdfUrl = json['pdfUrl'];
    review = json['review'];
    subTitle = json['subTitle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['pdfUrl'] = this.pdfUrl;
    data['review'] = this.review;
    data['subTitle'] = this.subTitle;
    data['title'] = this.title;
    return data;
  }
}
