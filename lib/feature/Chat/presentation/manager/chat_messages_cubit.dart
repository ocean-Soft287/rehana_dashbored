import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/chat_repo.dart';
import '../../data/model/chat_message.dart';
import 'chat_messages_state.dart';

class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  final ChatRepository repo;
  final String chatUserId; // The ID of the user we are chatting with

  ChatMessagesCubit(this.repo, this.chatUserId) : super(ChatMessagesInitial());

  static ChatMessagesCubit get(context) => BlocProvider.of(context);

  void getMessages() {
    emit(ChatMessagesLoading());
    try {
      repo
          .getMessages(chatUserId)
          .listen(
            (messages) {
              emit(ChatMessagesLoaded(messages));
            },
            onError: (error) {
              emit(ChatMessagesError(error.toString()));
            },
          );
    } catch (e) {
      emit(ChatMessagesError(e.toString()));
    }
  }

  Future<void> sendMessage({
    required String senderId, // Admin ID
    required String content,
    MessageType type = MessageType.text,
  }) async {
    // Avoid emitting Loading here to keep the list visible?
    // Usually we optimistic update or just wait for stream update.
    // But we might want to show a sending indicator.

    final message = ChatMessage(
      id: '', // Firestore auto-id, but we are passing object. Will be handled or ignored in toFirestore if we use .add()
      senderId: senderId,
      receiverId: chatUserId,
      content: content,
      timestamp: DateTime.now(),
      type: type,
    );

    final result = await repo.sendMessage(
      receiverId: chatUserId,
      message: message,
    );

    result.fold((failure) => emit(ChatMessagesError(failure.message)), (
      success,
    ) {
      // Success. Stream will update the UI.
    });
  }
}
