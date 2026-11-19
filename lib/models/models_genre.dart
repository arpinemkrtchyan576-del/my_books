enum Genre { novel, history, fantasy, poetry }

extension GenreLabel on Genre {
  String get label {
    switch (this) {
      case Genre.novel:
        return 'Վեպ';
      case Genre.history:
        return 'Պատմություն';
      case Genre.fantasy:
        return 'Ֆանտաստիկա';
      case Genre.poetry:
        return 'Բանաստեղծություն';
    }
  }
}
