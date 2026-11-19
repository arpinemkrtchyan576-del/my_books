import '../models/models_book.dart';
import '../models/models_genre.dart';

class BooksData {
  static List<Book> getBooks() {
    return [
      Book(
        id: 1,
        title: 'Անուշ',
        author: 'Հովհաննես Թումանյան',
        genre: Genre.poetry,
      ),
      Book(id: 2, title: 'Սամվել', author: 'Րաֆֆի', genre: Genre.novel),
      Book(id: 3, title: 'Խենթը', author: 'Րաֆֆի', genre: Genre.novel),
      Book(
        id: 4,
        title: 'Փոքրիկ իշխանը',
        author: 'Անտուան դը Սենտ-Էքզյուպերի',
        genre: Genre.fantasy,
      ),
      Book(
        id: 5,
        title: 'Գիքորը',
        author: 'Հովհաննես Թումանյան',
        genre: Genre.novel,
      ),
      Book(
        id: 6,
        title: 'Հայոց պատմություն',
        author: 'Ագաթանգեղոս',
        genre: Genre.history,
      ),
      Book(
        id: 7,
        title: 'Վերք Հայաստանի',
        author: 'Խաչատուր Աբովյան',
        genre: Genre.novel,
      ),
      Book(
        id: 8,
        title: 'Թմկաբերդի առումը',
        author: 'Հովհաննես Թումանյան',
        genre: Genre.poetry,
      ),
      Book(
        id: 9,
        title: 'Սպիտակ ժանիքը',
        author: 'Ջեք Լոնդոն',
        genre: Genre.fantasy,
      ),
      Book(
        id: 10,
        title: 'Անահիտ',
        author: 'Ղազարոս Աղայան',
        genre: Genre.fantasy,
      ),
    ];
  }
}
