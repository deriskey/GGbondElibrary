import 'package:flutter/material.dart';

class BookRecordPage extends StatelessWidget {
  const BookRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white, // White icon color for consistency
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Reservation Record',
          style: TextStyle(color: Colors.white), // White text in the app bar
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // App bar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'No book reservations found.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54, // Consistent text color for readability
              ),
            ),
          ),
        ),
      ),
    );
  }
}
