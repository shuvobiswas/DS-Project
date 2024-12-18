import 'package:flutter/material.dart';
import 'package:online_book_store_app/models/books.dart';
import 'package:online_book_store_app/providers.dart/author_provider.dart';
import 'package:online_book_store_app/providers.dart/books_provider.dart';
import 'package:online_book_store_app/services/upload_book.dart';
import 'package:online_book_store_app/ui/author_details.dart';
import 'package:online_book_store_app/ui/book_details.dart';
import 'package:provider/provider.dart';
// Import BookDetails screen

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final _author =
        Provider.of<AuthorProvider>(context, listen: false).fetchAuthors();
    final provider = Provider.of<BookProvider>(context, listen: false);
    provider.fetchBooks().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Books'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.deepPurple],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              iconSize: 50,
              color: Colors.white,
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Bookstore App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Author\'s'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthorsDetailsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Genres'),
              onTap: () {
                //Navigator.push(
                //  context,
                //  MaterialPageRoute(builder: (context) => GenrePage()),
                //);
              },
            ),
            // Add more tiles here
            ListTile(
              title: const Text('Books'),
              onTap: () {
                // Navigate to the Books screen (you can modify it as per your app structure)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : provider.books.isEmpty
              ? const Center(
                  child: Text(
                    'No books available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://media.gettyimages.com/id/157482029/photo/stack-of-books.jpg?s=612x612&w=gi&k=20&c=_Yaofm8sZLZkKs1eMkv-zhk8K4k5u0g0fJuQrReWfdQ=", // Placeholder
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            book.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          subtitle: Text(
                            'Author: ${book.authorName}\nStock: ${book.stockQuantity}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepPurple,
                          ),
                          onTap: () {
                            // Navigate to BookDetails
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetails(
                                  imageUrl:
                                      "https://media.gettyimages.com/id/157482029/photo/stack-of-books.jpg?s=612x612&w=gi&k=20&c=_Yaofm8sZLZkKs1eMkv-zhk8K4k5u0g0fJuQrReWfdQ=", // Placeholder
                                  book: book,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddBookScreen()));
        },
        label: const Text(
          'Add Book',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.add, size: 24),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        tooltip: 'Add a new book',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6.0,
      ),
    );
  }
}
