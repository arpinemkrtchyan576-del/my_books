import 'models_genre.dart';

class Book {
  int id;
  String title;
  String author;
  Genre genre;
  bool isRead;
  int rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isRead = false,
    this.rating = 0,
  });
}
