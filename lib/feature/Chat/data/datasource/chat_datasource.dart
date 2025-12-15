import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/firebase/firebase_conumer_impl.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/chat_message.dart';
import '../model/chat_user.dart';

abstract class ChatDataSource {
  Stream<List<ChatUser>> getContacts();
  Stream<List<ChatMessage>> getMessages(String userId);
  Future<Either<Failure, void>> sendMessage({
    required String receiverId,
    required ChatMessage message,
  });
}

class ChatDataSourceImpl extends BaseFirebaseConsumer
    implements ChatDataSource {
  ChatDataSourceImpl({super.firestore});

  // Assuming 'users' collection exists needed for contacts.
  // If not, we might need to rely on 'chats' collection to find people we've talked to.
  // But user asked for "contacts" from fetched data.
  // We can also sync API users to Firestore here if needed, but for now we read from Firestore.
  static const String usersCollection = 'users';
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';

  @override
  Stream<List<ChatUser>> getContacts() {
    // This streams all users who could be contacts.
    // Optimization: Only users with whom we have a chat,
    // or all users if the admin can initiate chat with anyone.
    return firestore.collection(usersCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
    });
  }

  @override
  Stream<List<ChatMessage>> getMessages(String userId) {
    // userId is the OTHER person in the chat.
    // We assume the chat document ID is a combination of IDs or we query subcollection.
    // For simplicity, let's assume specific structure: chats/{chatId}/messages
    // Constructing chatId: keys should be sorted to ensure uniqueness purely based on participants
    // (but here we are admin, so maybe we use userId directly if each user has one chat with admin).

    // User-Admin chat model: One chat per user.
    // Collection: chats (docId: userId) -> subcollection: messages

    return firestore
        .collection(chatsCollection)
        .doc(userId)
        .collection(messagesCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String receiverId,
    required ChatMessage message,
  }) async {
    try {
      // Create/Update chat document to update last message info if needed
      final chatDocRef = firestore.collection(chatsCollection).doc(receiverId);

      await chatDocRef.set({
        'lastMessage': message.content,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'userId': receiverId,
        // We can add more info here like user name if we have it
      }, SetOptions(merge: true));

      // Add message to subcollection
      await chatDocRef
          .collection(messagesCollection)
          .add(message.toFirestore());

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
