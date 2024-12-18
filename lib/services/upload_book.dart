import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController bookIDController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController publicationDateController =
      TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController authorContactController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newBook = {
        "BookID": int.parse(bookIDController.text),
        "Title": titleController.text,
        "Genre": genreController.text,
        "PublicationDate": publicationDateController.text,
        "StockQuantity": int.tryParse(stockQuantityController.text) ?? 0,
        "AuthorName": authorNameController.text,
        "AuthorContact": authorContactController.text,
      };

      try {
        final response = await http.post(
          Uri.parse('http://192.168.56.1:5000/books'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(newBook),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book added successfully!')),
          );
          _clearForm();
        } else {
          final errorMsg =
              json.decode(response.body)['message'] ?? 'An error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $errorMsg')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _clearForm() {
    bookIDController.clear();
    titleController.clear();
    genreController.clear();
    publicationDateController.clear();
    stockQuantityController.clear();
    authorNameController.clear();
    authorContactController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: bookIDController,
                label: 'Book ID',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a Book ID'
                    : null,
              ),
              _buildTextField(
                controller: titleController,
                label: 'Title',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              _buildTextField(
                controller: genreController,
                label: 'Genre',
              ),
              _buildTextField(
                controller: publicationDateController,
                label: 'Publication Date',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a publication date'
                    : null,
              ),
              _buildTextField(
                controller: stockQuantityController,
                label: 'Stock Quantity',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: authorNameController,
                label: 'Author Name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter an author name'
                    : null,
              ),
              _buildTextField(
                controller: authorContactController,
                label: 'Author Contact',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
