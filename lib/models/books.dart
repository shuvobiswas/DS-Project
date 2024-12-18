class Book {
  final int bookID;
  final String title;
  final String genre;
  final String publicationDate;
  final int stockQuantity;
  final String authorName;
  final String authorContact;

  Book({
    required this.bookID,
    required this.title,
    required this.genre,
    required this.publicationDate,
    required this.stockQuantity,
    required this.authorName,
    required this.authorContact,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookID: json['BookID'],
      title: json['Title'],
      genre: json['Genre'],
      publicationDate: json['PublicationDate'],
      stockQuantity: json['StockQuantity'],
      authorName: json['AuthorName'],
      authorContact: json['AuthorContact'],
    );
  }

  // Fix the 'fromJsonList' method
  factory Book.fromJsonList(List<dynamic> jsonList) {
    return Book(
      bookID: jsonList[0], // 'int' for bookID is correct
      title: jsonList[1].toString(), // Ensure title is a String
      genre: jsonList[2].toString(), // Ensure genre is a String
      publicationDate:
          jsonList[3].toString(), // Ensure publicationDate is a String
      stockQuantity: jsonList[4], // stockQuantity is an int
      authorName: jsonList[5].toString(), // Ensure authorName is a String
      authorContact: '', // Assuming you don't have 'authorContact' in the list
    );
  }
}
