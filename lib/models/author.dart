class Author {
  final int authorID;
  final String name;
  final String contact;

  Author({required this.authorID, required this.name, required this.contact});

  factory Author.fromJson(List<dynamic> json) {
    return Author(
      authorID: json[0], // Index 0 for ID
      name: json[1], // Index 1 for Name
      contact: json[2], // Index 2 for Contact
    );
  }
}
