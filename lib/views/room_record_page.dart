import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/room_viewmodel.dart';

class ReservedRoomsPage extends StatelessWidget {
  final String userId;

  ReservedRoomsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomViewModel()..fetchReservedRooms(userId),
      child: Consumer<RoomViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Your Reservations',
                style: TextStyle(color: Colors.white), // White text in the app bar
              ),
              backgroundColor: Colors.blueAccent, // Consistent app bar color
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: viewModel.reservedRooms.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: viewModel.reservedRooms.length,
                      itemBuilder: (context, index) {
                        final room = viewModel.reservedRooms[index];
                        return Card(
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white.withOpacity(0.8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            title: Text(
                              room.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Dark text for readability
                              ),
                            ),
                            subtitle: Text(
                              'Booking Date: ${room.bookingDate ?? "N/A"}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

