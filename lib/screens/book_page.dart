import 'package:flutter/material.dart';

import '../models/models_book.dart';
import '../models/models_genre.dart';
import '../widgets/book_tile.dart';
import 'book_details_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String search = '';
  Genre? selectedGenre;

  List<Book> books = [
    Book(
      id: 1,
      title: 'Anush',
      author: 'Hovhannes Tumanyan',
      genre: Genre.poetry,
    ),
    Book(id: 2, title: 'Samvel', author: 'Raffi', genre: Genre.novel),
    Book(id: 3, title: 'Khenty', author: 'Raffi', genre: Genre.novel),
    Book(
      id: 4,
      title: 'Poqrik Ishkhany',
      author: 'Antuan de Sent-Ekzyuperi',
      genre: Genre.fantasy,
    ),
    Book(
      id: 5,
      title: 'Giqory',
      author: 'Hovhannes Tumanyan',
      genre: Genre.novel,
    ),
    Book(
      id: 6,
      title: 'Hayots Patmutyun',
      author: 'Agatangeghos',
      genre: Genre.history,
    ),
    Book(
      id: 7,
      title: 'Verq Hayastani',
      author: 'Khachatur Abovyan',
      genre: Genre.novel,
    ),
    Book(
      id: 8,
      title: 'Tmkaberdy Arumy',
      author: 'Hovhannes Tumanyan',
      genre: Genre.poetry,
    ),
    Book(
      id: 9,
      title: 'Spitak Zhanyqy',
      author: 'Jack London',
      genre: Genre.fantasy,
    ),
    Book(
      id: 10,
      title: 'Anahit',
      author: 'Ghazaros Aghayan',
      genre: Genre.fantasy,
    ),
  ];

  List<Book> get filteredBooks {
    return books.where((book) {
      final query = search.toLowerCase();

      final matchesSearch =
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      final matchesGenre = selectedGenre == null || book.genre == selectedGenre;

      return matchesSearch && matchesGenre;
    }).toList();
  }

  // Կարդացված գրքերի քանակ

  int get readCount {
    return books.where((book) => book.isRead).length;
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
              books.insert(index.clamp(0, books.length), book);
            });
          },
        ),
      ),
    );
  }

  // Բացել գրքի մանրամասները

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Իմ գրքերը ($readCount / ${books.length})'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Որոնման դաշտ
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
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
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                ChoiceChip(
                  label: const Text('Բոլորը'),
                  selected: selectedGenre == null,
                  onSelected: (value) {
                    setState(() {
                      selectedGenre = null;
                    });
                  },
                ),

                const SizedBox(width: 8),

                ...Genre.values.map((genre) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(genre.name),
                      selected: selectedGenre == genre,
                      onSelected: (value) {
                        setState(() {
                          selectedGenre = genre;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
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
