import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseConsumer {
  /// Get the Firestore instance
  FirebaseFirestore get firestore;

  /// Add a listener with a unique key
  void addListener(String key, StreamSubscription subscription);

  /// Cancel a specific listener by key
  Future<void> cancelListener(String key);

  /// Cancel all active listeners
  Future<void> cancelAllListeners();

  /// Dispose and clean up all resources
  void dispose();
}