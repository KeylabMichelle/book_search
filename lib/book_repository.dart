import 'dart:convert';

import 'package:http/http.dart' as http;

class BookRepository {
  Future<dynamic> apiRequest(String search) async {
    http.Response response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$search'));


    var booksResponse = jsonDecode(response.body);

    if (booksResponse['items'] == null) {
      return [];
    }

    List<dynamic> books = booksResponse['items'] as List;

    print('books: $books');

    return books;
  }
}
