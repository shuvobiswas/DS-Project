import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_book_store_app/models/author.dart';
import 'package:online_book_store_app/models/books.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.56.1:5000'; // Use your API URL

  // Fetch Authors
  Future<List<Author>> getAuthors() async {
    final response = await http.get(Uri.parse('$baseUrl/authors'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((author) => Author.fromJson(author)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }

  // Add Author
  Future<void> addAuthor(Author author) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authors'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'AuthorID': author.authorID,
        'Name': author.name,
        'Contact': author.contact,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add author');
    }
  }

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((book) {
        return Book.fromJsonList(book); // Use a new method to handle the list
      }).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Add Book (If you want to implement adding books)
  Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'bookID': book.bookID,
        'title': book.title,
        'genre': book.genre, // Added genre
        'publicationDate': book.publicationDate, // Added publicationDate
        'stockQuantity': book.stockQuantity, // Added stockQuantity
        'authorName': book.authorName, // Corrected authorName
        'authorContact': book.authorContact, // Added authorContact
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add book');
    }
  }
}
