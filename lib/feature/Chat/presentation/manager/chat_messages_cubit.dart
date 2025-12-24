import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../data/repo/chat_repo.dart';
import '../../data/model/chat_message.dart';

part 'chat_messages_event.dart';

class ChatMessagesCubit extends Bloc<ChatMessageEvent, BaseState<ChatMessage>> {
  final ChatRepository repo;

  ChatMessagesCubit(this.repo) : super(const BaseState<ChatMessage>()) {
    on<ListenToMessagesEvent>(_onListenToMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkMessageAsReadEvent>(_onMarkMessageAsRead);
  }

  static ChatMessagesCubit get(context) => BlocProvider.of(context);

  Future<void> _onListenToMessages(
    ListenToMessagesEvent event,
    Emitter<BaseState<ChatMessage>> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      repo.getMessages(conversationId: event.conversationId),
      onData: (either) {
        return either.fold(
          (failure) => state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            failure: failure,
          ),
          (messages) => state.copyWith(status: Status.success, items: messages),
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          status: Status.failure,
          errorMessage: error.toString(),
        );
      },
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<BaseState<ChatMessage>> emit,
  ) async {
    final result = await repo.sendMessage(
      conversationId: event.conversationId,
      senderId: event.senderId,
      receiverId: event.receiverId,
      content: event.text,
      type: event.type,
      senderName: event.senderName,
      receiverName: event.receiverName,
      senderProfilePic: event.senderProfilePic,
      receiverProfilePic: event.receiverProfilePic,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (messageId) {
        // Message sent successfully - stream will update automatically
      },
    );
  }

  Future<void> _onMarkMessageAsRead(
    MarkMessageAsReadEvent event,
    Emitter<BaseState<ChatMessage>> emit,
  ) async {
    await repo.markMessageAsRead(
      conversationId: event.conversationId,
      messageId: event.messageId,
    );
  }
}
