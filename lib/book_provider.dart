import 'package:books/book_repository.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List<dynamic> _searchResults = [];

  BookRepository bookRepository = new BookRepository();

  List<dynamic> get searchResults => _searchResults;

  bool _termina = false;

  bool get termina => _termina;

  searchBook(String bookName) async {
    notifyListeners();
    _searchResults = await bookRepository.apiRequest(bookName) as List;
    notifyListeners();
    _termina = true;
    notifyListeners();
  }
}
