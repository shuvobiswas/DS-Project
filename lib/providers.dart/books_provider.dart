import 'package:flutter/material.dart';
import 'package:online_book_store_app/models/books.dart';
import 'package:online_book_store_app/services/api_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  // Fetch books from the API
  Future<void> fetchBooks() async {
    try {
      _books = await ApiService().getBooks();
      //  print(_books);
      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Failed to load books');
    }
  }

  // Add a book to the list (optional)
  Future<void> addBook(Book book) async {
    try {
      await ApiService().addBook(book);
      _books.add(book);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add book');
    }
  }
}
