import 'package:flutter/material.dart';
import 'package:online_book_store_app/models/books.dart';
import 'package:online_book_store_app/ui/author_details.dart';

class BookDetails extends StatefulWidget {
  final String imageUrl;
  final Book book;

  const BookDetails({required this.imageUrl, required this.book, Key? key})
      : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  int _quantity = 1;

  void _increaseQuantity() {
    if (_quantity < widget.book.stockQuantity) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.deepPurple],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Chip(
                    label: Text(
                      'In Stock: ${widget.book.stockQuantity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Title
                  Text(
                    widget.book.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Author Name
                  Text(
                    'Author: ${widget.book.authorName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Genre
                  Text(
                    'Genre: ${widget.book.genre}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Publication Date
                  Text(
                    'Publication Date: ${widget.book.publicationDate}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Author Contact
                  Text(
                    'Author Contact: ${widget.book.authorContact}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Quantity:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _decreaseQuantity,
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: _increaseQuantity,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Divider
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${_quantity} x 500 BDT', // Replace 500 with actual price if available
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color.fromARGB(255, 73, 55, 105),
              ),
              onPressed: () {
                // Add buy logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$_quantity book(s) added to your cart!'),
                  ),
                );
              },
              child: const Text(
                'Buy This Book',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
