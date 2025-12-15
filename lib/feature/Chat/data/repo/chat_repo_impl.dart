import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../datasource/chat_datasource.dart';
import '../model/chat_message.dart';
import '../model/chat_user.dart';
import 'chat_repo.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Stream<List<ChatUser>> getContacts() {
    return dataSource.getContacts();
  }

  @override
  Stream<List<ChatMessage>> getMessages(String userId) {
    return dataSource.getMessages(userId);
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String receiverId,
    required ChatMessage message,
  }) {
    return dataSource.sendMessage(receiverId: receiverId, message: message);
  }
}
