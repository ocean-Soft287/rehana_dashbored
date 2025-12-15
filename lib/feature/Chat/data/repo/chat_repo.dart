import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/chat_message.dart';
import '../model/chat_user.dart';

abstract class ChatRepository {
  Stream<List<ChatUser>> getContacts();
  Stream<List<ChatMessage>> getMessages(String userId);
  Future<Either<Failure, void>> sendMessage({
    required String receiverId,
    required ChatMessage message,
  });
}
