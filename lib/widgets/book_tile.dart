import 'package:flutter/material.dart';
import '../models/models_book.dart';
import '../widgets/ star_rating.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final ValueChanged<bool> onChanged;
  final VoidCallback onTap;

  const BookTile({
    super.key,
    required this.book,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      leading: Checkbox(
        value: book.isRead,
        onChanged: (value) {
          onChanged(value ?? false);
        },
      ),

      title: Text(
        book.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: book.isRead
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.author),
          Text(book.genre.name),

          if (book.rating > 0) StarRating(rating: book.rating, size: 17),
        ],
      ),
    );
  }
}
