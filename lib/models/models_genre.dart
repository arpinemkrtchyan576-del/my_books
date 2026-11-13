enum Genre { novel, history, fantasy, poetry }

extension GenreName on Genre {
  String get name {
    switch (this) {
      case Genre.novel:
        return 'Vep';
      case Genre.history:
        return 'Patmutyun';
      case Genre.fantasy:
        return 'Fantastica';
      case Genre.poetry:
        return 'Banastexcucyunner';
    }
  }
}
