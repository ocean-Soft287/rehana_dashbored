import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_consumer.dart';

class BaseFirebaseConsumer implements FirebaseConsumer {
  final FirebaseFirestore _firestore;
  final Map<String, StreamSubscription> _activeListeners = {};

  BaseFirebaseConsumer({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  FirebaseFirestore get firestore => _firestore;

  // Add listener tracking
  @override
  void addListener(String key, StreamSubscription subscription) {
    _activeListeners[key]?.cancel();
    _activeListeners[key] = subscription;
  }

  // Cancel specific listener
  @override
  Future<void> cancelListener(String key) async {
    await _activeListeners[key]?.cancel();
    _activeListeners.remove(key);
  }

  // Cancel all listeners
  @override
  Future<void> cancelAllListeners() async {
    for (var subscription in _activeListeners.values) {
      await subscription.cancel();
    }
    _activeListeners.clear();
  }

  @override
  void dispose() {
    cancelAllListeners();
  }
}