import 'package:books/book_repository.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List<dynamic> _searchResults = [];

  BookRepository bookRepository = new BookRepository();

  List<dynamic> get searchResults => _searchResults;

  void searchBook(String bookName) async {
    _searchResults = await bookRepository.apiRequest(bookName) as List;
    notifyListeners();
  }
}
