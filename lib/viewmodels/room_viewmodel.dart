import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/room_model.dart';

class RoomViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Room> _rooms = [];
  List<Room> _reservedRooms = [];

  List<Room> get rooms => _rooms;
  List<Room> get reservedRooms => _reservedRooms;

  RoomViewModel() {
    _listenToRoomUpdates();
  }

  // Listen to real-time updates for all rooms
  void _listenToRoomUpdates() {
    _firestore.collection('rooms').snapshots().listen((snapshot) {
      _rooms = snapshot.docs.map((doc) {
        return Room.fromFirestore(doc.data());
      }).toList();
      notifyListeners();
    });
  }

  // Fetch rooms reserved by the current user
  Future<void> fetchReservedRooms(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('rooms')
          .where('isBooked', isEqualTo: true)
          .where('userId', isEqualTo: userId)
          .get();

      _reservedRooms = querySnapshot.docs.map((doc) {
        return Room.fromFirestore(doc.data());
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching reserved rooms: $e');
    }
  }

  // Book a room
  Future<void> bookRoom(int roomId, DateTime bookingDate, String userId) async {
    final roomQuerySnapshot = await _firestore
        .collection('rooms')
        .where('id', isEqualTo: roomId)
        .limit(1)
        .get();

    if (roomQuerySnapshot.docs.isEmpty) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: 'Room with ID $roomId does not exist.',
        code: 'not-found',
      );
    }

    final roomDoc = roomQuerySnapshot.docs.first;

    // Ensure the room is not already booked
    if (roomDoc.data()['isBooked'] == true) {
      throw Exception('Room is already booked.');
    }

    await _firestore.collection('rooms').doc(roomDoc.id).update({
      'isBooked': true,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'userId': userId,
    });
  }

  // Cancel a booking
  Future<void> cancelBooking(int roomId, String userId) async {
    final roomQuerySnapshot = await _firestore
        .collection('rooms')
        .where('id', isEqualTo: roomId)
        .limit(1)
        .get();

    if (roomQuerySnapshot.docs.isEmpty) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: 'Room with ID $roomId does not exist.',
        code: 'not-found',
      );
    }

    final roomDoc = roomQuerySnapshot.docs.first;

    // Ensure the user attempting to cancel is the one who booked the room
    if (roomDoc.data()['userId'] != userId) {
      throw Exception('You can only cancel your own bookings.');
    }

    await _firestore.collection('rooms').doc(roomDoc.id).update({
      'isBooked': false,
      'bookingDate': null,
      'userId': null,
    });
  }
}
