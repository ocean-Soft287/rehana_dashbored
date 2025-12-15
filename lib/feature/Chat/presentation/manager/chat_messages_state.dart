import '../../data/model/chat_message.dart';

abstract class ChatMessagesState {}

class ChatMessagesInitial extends ChatMessagesState {}

class ChatMessagesLoading extends ChatMessagesState {}

class ChatMessagesLoaded extends ChatMessagesState {
  final List<ChatMessage> messages;
  ChatMessagesLoaded(this.messages);
}

class ChatMessagesError extends ChatMessagesState {
  final String message;
  ChatMessagesError(this.message);
}

class ChatMessageSending extends ChatMessagesState {}

class ChatMessageSent
    extends ChatMessagesState {} // Optional, or just stay in Loaded
