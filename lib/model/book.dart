import 'author.dart';

class Book {
  const Book({this.review, this.rating, this.id, this.author, this.title, this.cover});

  final int id;
  final Author author;
  final String title;
  final String cover;

  final String review;
  final int rating;
}
