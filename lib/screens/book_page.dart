import 'package:flutter/material.dart';

import '../models/models_book.dart';
import '../models/models_genre.dart';
import '../data/books_data.dart';
import '../widgets/book_tile.dart';
import '../widgets/genre_filter.dart';
import 'book_details_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final TextEditingController searchController = TextEditingController();

  String search = '';
  Genre? selectedGenre;

  List<Book> books = BooksData.getBooks();

  int get readCount {
    return books.where((book) => book.isRead).length;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void deleteBook(Book book) {
    final index = books.indexOf(book);

    setState(() {
      books.remove(book);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${book.title} ջնջվեց'),
        action: SnackBarAction(
          label: 'Վերականգնել',
          onPressed: () {
            setState(() {
              final safeIndex = index > books.length ? books.length : index;

              books.insert(safeIndex, book);
            });
          },
        ),
      ),
    );
  }

  Future<void> openDetails(Book book) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (context) => BookDetailsPage(book: book)),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        book.rating = result;

        if (result > 0) {
          book.isRead = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books.where((book) {
      final query = search.toLowerCase().trim();

      final matchesSearch =
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      final matchesGenre = selectedGenre == null || book.genre == selectedGenre;

      return matchesSearch && matchesGenre;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Իմ գրքերը ($readCount / ${books.length})'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },

              decoration: InputDecoration(
                hintText: 'Որոնել գիրք կամ հեղինակ',

                prefixIcon: const Icon(Icons.search),

                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),

                  onPressed: () {
                    searchController.clear();

                    setState(() {
                      search = '';
                    });
                  },
                ),

                border: const OutlineInputBorder(),
              ),
            ),
          ),

          // Ժանրերի ֆիլտր
          GenreFilter(
            selectedGenre: selectedGenre,
            onSelected: (genre) {
              setState(() {
                selectedGenre = genre;
              });
            },
          ),

          const SizedBox(height: 10),

          // Գրքերի ցանկ
          Expanded(
            child: filteredBooks.isEmpty
                ? const Center(
                    child: Text(
                      'Գիրք չի գտնվել',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.separated(
                    itemCount: filteredBooks.length,

                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },

                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];

                      return Dismissible(
                        key: ValueKey(book.id),

                        direction: DismissDirection.horizontal,

                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),

                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),

                        onDismissed: (direction) {
                          deleteBook(book);
                        },

                        child: BookTile(
                          book: book,

                          onChanged: (value) {
                            setState(() {
                              book.isRead = value;
                            });
                          },

                          onTap: () {
                            openDetails(book);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
