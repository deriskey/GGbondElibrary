import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final int id;
  final String name;
  bool isBooked;
  DateTime? bookingDate;

  Room({
    required this.id,
    required this.name,
    this.isBooked = false,
    this.bookingDate,
  });

  // Convert Firestore data to Room
  factory Room.fromFirestore(Map<String, dynamic> data) {
    return Room(
      id: data['id'],
      name: data['name'],
      isBooked: data['isBooked'],
      bookingDate: data['bookingDate'] != null
          ? (data['bookingDate'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert Room to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'isBooked': isBooked,
      'bookingDate': bookingDate,
    };
  }
}
