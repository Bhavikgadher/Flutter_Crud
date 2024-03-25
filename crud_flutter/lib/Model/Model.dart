class Model {
  late String _bookID;
  late String _bookName;
  late String _bookAuthor;
  late String _bookGenre;
  late String _bookAvailableCopies;

  String get bookID => _bookID;

  set bookID(String value) {
    _bookID = value;
  }

  String get bookName => _bookName;

  String get bookAvailableCopies => _bookAvailableCopies;

  set bookAvailableCopies(String value) {
    _bookAvailableCopies = value;
  }

  String get bookGenre => _bookGenre;

  set bookGenre(String value) {
    _bookGenre = value;
  }

  String get bookAuthor => _bookAuthor;

  set bookAuthor(String value) {
    _bookAuthor = value;
  }

  set bookName(String value) {
    _bookName = value;
  }
}
