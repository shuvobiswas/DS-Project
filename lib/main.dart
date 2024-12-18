import 'package:flutter/material.dart';
import 'package:online_book_store_app/providers.dart/author_provider.dart';
import 'package:online_book_store_app/providers.dart/books_provider.dart';
import 'package:online_book_store_app/ui/book_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => AuthorProvider()),
      ],
      child: MaterialApp(
        title: 'Bookstore App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyLarge:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            bodyMedium: const TextStyle(fontSize: 16),
            bodySmall: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        home: BookListScreen(),
      ),
    );
  }
}
