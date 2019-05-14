import 'author.dart';

class Book {
  static final db_id = "id";
  static final db_author_name = "author_name";
  static final db_title = "title";
  static final db_description = "description";
  static final db_cover = "cover";
  static final db_rating = "rating";
  static final db_review = "review";

  Book({this.id, this.author, this.title, this.cover, this.description, this.rating, this.review});

  final String id;
  final Author author;
  final String title;
  final String cover;
  final String description;

  String review;
  int rating;

  factory Book.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['volumeInfo'];

    return Book(
      author: Author(name: data.containsKey('authors') ? data['authors'][0] : 'Inconnu'),
      id: json['id'],
      title: data['title'],
      description: data['description'],
      cover: data.containsKey('imageLinks') ? data['imageLinks']['smallThumbnail'] : null,
      rating: 0,
      review: ''
    );
  }

  factory Book.fromDb(Map<String, dynamic> data) {
    return Book(
        author: Author(name: data[db_author_name]),
        id: data[db_id],
        title: data[db_title],
        description: data[db_description],
        cover: data[db_cover],
        review: data[db_review],
        rating: data[db_rating]
    );
  }

}
