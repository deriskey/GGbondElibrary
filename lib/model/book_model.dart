

class Book {
  final String bookId; // Updated to camelCase
  final String title;
  final String author;
  final bool isAvailable;
  final String categories;

  Book({
    required this.bookId, // Updated to camelCase
    required this.title,
    required this.author,
    required this.isAvailable,
    required this.categories,
  });

  // Convert Firestore document to Book object
  factory Book.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Book(
      bookId: documentId, // Use documentId for bookId
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      isAvailable: data['isAvailable'] ?? true,
      categories: data['categories'] ?? '',
    );
  }

  // Convert Book object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'isAvailable': isAvailable,
      'categories': categories,
    };
  }
}

