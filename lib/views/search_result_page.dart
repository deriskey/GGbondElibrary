import 'package:flutter/material.dart';
import 'book_info_page.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Search Results'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1510172951991-856a654063f9'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/book_covers/Oldmansea.jpg',
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                title: const Text('Book Title'),
                subtitle: const Text('Category: Fiction\nStatus: Available'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BookInfoPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 