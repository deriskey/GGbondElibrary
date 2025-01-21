import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/room_viewmodel.dart';

class RoomListScreen extends StatelessWidget {
  final String userId; // Pass userId to identify the current user

  RoomListScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RoomViewModel>(context);

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
          'Room Reservation System',
          style: TextStyle(color: Colors.white), // White text color for app bar
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // App bar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: viewModel.rooms.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: viewModel.rooms.length,
                itemBuilder: (context, index) {
                  final room = viewModel.rooms[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(room.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        room.isBooked
                            ? 'Booked on ${room.bookingDate?.toLocal().toString().split(' ')[0]}'
                            : 'Available',
                        style: TextStyle(color: room.isBooked ? Colors.red : Colors.green),
                      ),
                      trailing: room.isBooked
                          ? ElevatedButton(
                              onPressed: () {
                                viewModel.cancelBooking(room.id, userId).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Booking canceled')),
                                  );
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $error')),
                                  );
                                });
                              },
                              child: Text('Cancel', style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _showBookingDialog(context, viewModel, room.id);
                              },
                              child: Text('Book', style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context, RoomViewModel viewModel, int roomId) {
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Book Room'),
          content: GestureDetector(
            onTap: () async {
              // Show Date Picker when user taps the TextField
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                // Update the TextField with the selected date
                dateController.text = selectedDate.toLocal().toString().split(' ')[0];
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Select date',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (dateController.text.isNotEmpty) {
                  DateTime? selectedDate = DateTime.tryParse('${dateController.text} 00:00:00');
                  if (selectedDate != null) {
                    // Call bookRoom method from the ViewModel with the userId and selected date
                    viewModel.bookRoom(roomId, selectedDate, userId).then((_) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Room booked successfully on ${selectedDate.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Booking failed: $error')),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid date format')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a date')),
                  );
                }
              },
              child: Text('Book'),
            ),
          ],
        );
      },
    );
  }
}
