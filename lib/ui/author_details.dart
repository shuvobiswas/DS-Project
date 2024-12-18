import 'package:flutter/material.dart';
import 'package:online_book_store_app/providers.dart/author_provider.dart';
import 'package:provider/provider.dart';

class AuthorsDetailsPage extends StatelessWidget {
  const AuthorsDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authors"),
      ),
      body: FutureBuilder(
        future:
            Provider.of<AuthorProvider>(context, listen: false).fetchAuthors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<AuthorProvider>(
              builder: (context, authorProvider, child) {
                final authors = authorProvider.authors;
                return ListView.builder(
                  itemCount: authors.length,
                  itemBuilder: (context, index) {
                    final author = authors[index];
                    return ListTile(
                      title: Text(author.name),
                      subtitle: Text(author.contact),
                      trailing: Text('ID: ${author.authorID}'),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
