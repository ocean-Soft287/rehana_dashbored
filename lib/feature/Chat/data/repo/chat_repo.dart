import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/chat_message.dart';
import '../model/chat_user.dart';

abstract class ChatRepository {
  /// Get messages stream for a specific conversation
  Stream<Either<Failure, List<ChatMessage>>> getMessages({
    required String conversationId,
  });

  /// Send a message to a conversation
  Future<Either<Failure, String>> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String content,
    required String senderName,
    required String receiverName,
    String type = 'text',
    String? senderProfilePic,
    String? receiverProfilePic,
  });

  /// Mark message as read
  Future<Either<Failure, void>> markMessageAsRead({
    required String conversationId,
    required String messageId,
  });

  /// Get all users to chat with
  Stream<Either<Failure, List<ChatUser>>> getContacts();
  Stream<Either<Failure, List<ChatUser>>> getUsers();
}
