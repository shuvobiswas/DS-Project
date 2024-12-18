import 'package:flutter/material.dart';
import 'package:online_book_store_app/models/author.dart';
import 'package:online_book_store_app/services/api_service.dart';

class AuthorProvider with ChangeNotifier {
  List<Author> _authors = [];

  List<Author> get authors => _authors;

  Future<void> fetchAuthors() async {
    try {
      _authors = await ApiService().getAuthors();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load authors');
    }
  }

  Future<void> addAuthor(Author author) async {
    try {
      await ApiService().addAuthor(author);
      _authors.add(author);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add author');
    }
  }
}
