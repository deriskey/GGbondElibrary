import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/book_viewmodel.dart';
import 'categories_page.dart';

class BookReservationPage extends StatelessWidget {
  const BookReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BookViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
           icon: const Icon(
              Icons.arrow_circle_left_outlined,
              color: Colors.white,  // Set the color of the icon to white
              ),
            onPressed: () => Navigator.pop(context),
      ),

        title: const Text('Book Available', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Search Bar
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search by book name...',
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        bookViewModel.filterBooks(query); // Filter books dynamically
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      // Optional: Implement any action when search icon is pressed
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Search Results
            Expanded(
              child: bookViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : bookViewModel.filteredBooks.isEmpty
                      ? const Center(child: Text('No books found'))
                      : ListView.builder(
                          itemCount: bookViewModel.filteredBooks.length,
                          itemBuilder: (context, index) {
                            final book = bookViewModel.filteredBooks[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              elevation: 6,
                              child: ListTile(
                                title: Text(book.title),
                                subtitle: Text(book.author),
                                trailing: book.isAvailable
                                    ? const Text(
                                        'Available',
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : const Text(
                                        'Not Available',
                                        style: TextStyle(color: Colors.red),
                                      ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 20),
            // Search by Category Button
            SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.library_books),
                label: const Text(
                  'Search by Category',
                  style: TextStyle(color: Colors.white), // Text color updated to white
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  backgroundColor: Colors.blueAccent, // Consistent with gradient
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
