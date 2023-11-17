class Books {
  String? id;
  String? title;
  String? subtitle;
  String? authors;
  String? image;
  String? url;

  Books(
      {this.id, this.title, this.subtitle, this.authors, this.image, this.url});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['authors'] = this.authors;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
