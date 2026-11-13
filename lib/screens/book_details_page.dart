import 'package:flutter/material.dart';
import '../models/models_book.dart';

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

            const SizedBox(height: 10),

            Text('Հեղինակ՝ ${widget.book.author}'),

            Text('Ժանր՝ ${widget.book.genre.name}'),

            const SizedBox(height: 30),

            const Text('Գնահատիր գիրքը', style: TextStyle(fontSize: 20)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 35,
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
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
