import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/book_model.dart';
import 'package:flutter/material.dart';

class BookViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Book> _books = [];
  List<Book> get books => _books;

  List<Book> _filteredBooks = [];
  List<Book> get filteredBooks => _filteredBooks;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  BookViewModel() {
    fetchBooks(); // Automatically fetch books on initialization
  }

  // Fetch all books from Firestore
  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await _firestore.collection('books').get();
      _books = querySnapshot.docs
          .map((doc) => Book.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      _filteredBooks = List.from(_books); // Initialize filtered list with all books
    } catch (e) {
      debugPrint("Error fetching books: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Filter books based on search query
  void filterBooks(String query) {
    if (query.isEmpty) {
      _filteredBooks = List.from(_books);
    } else {
      _filteredBooks = _books
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
