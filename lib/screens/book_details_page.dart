import 'package:flutter/material.dart';
import '../models/models_book.dart';
import '../widgets/ star_rating.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;
  const BookDetailsPage({super.key, required this.book});
  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  int rating = 0;

  @override
  void initState() {
    super.initState();
    rating = widget.book.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Գրքի մանրամասներ'), centerTitle: true),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 100, color: Colors.brown),

            const SizedBox(height: 20),

            Text(
              widget.book.title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            Text('Հեղինակ՝ ${widget.book.author}'),
            Text('Ժանր՝ ${widget.book.genre}'),
            const SizedBox(height: 30),
            const Text('Գնահատիր գիրքը', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            StarRating(
              rating: rating,
              size: 35,
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: rating == 0
                  ? null
                  : () {
                      Navigator.pop(context, rating);
                    },
              child: const Text('Պահպանել'),
            ),
          ],
        ),
      ),
    );
  }
}
