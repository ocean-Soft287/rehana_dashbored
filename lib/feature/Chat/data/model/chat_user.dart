import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  final String id;
  final String name;
  final String? image;
  final String? email;
  final bool? isOnline;
  final DateTime? lastSeen;

  ChatUser({
    required this.id,
    required this.name,
    this.image,
    this.email,
    this.isOnline,
    this.lastSeen,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      // Parsing ID with fallbacks similar to what was requested
      id:
          json['id']?.toString() ??
          json['userId']?.toString() ??
          json['uid']?.toString() ??
          '',
      name: json['name'] ?? json['userName'] ?? json['fullName'] ?? 'Unknown',
      image: json['image'] ?? json['profileImage'],
      email: json['email'],
      isOnline: json['isOnline'],
      lastSeen:
          json['lastSeen'] != null
              ? (json['lastSeen'] as Timestamp).toDate()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }
}
