import 'package:flutter/material.dart';
import '../models/models_genre.dart';
import '../models/models_book.dart';

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
        children: [Text(book.author), Text(book.genre.name)],
      ),

      trailing: book.rating > 0
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                book.rating,
                (index) =>
                    const Icon(Icons.star, color: Colors.amber, size: 17),
              ),
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
