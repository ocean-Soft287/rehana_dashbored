part of 'chat_messages_cubit.dart';

abstract interface class ChatMessageEvent extends Equatable {
  const ChatMessageEvent();
  @override
  List<Object?> get props => [];
}

class ListenToMessagesEvent extends ChatMessageEvent {
  final String conversationId;
  const ListenToMessagesEvent(this.conversationId);
  @override
  List<Object?> get props => [conversationId];
}

class SendMessageEvent extends ChatMessageEvent {
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final String senderName;
  final String receiverName;
  final String type;
  final String? senderProfilePic;
  final String? receiverProfilePic;

  const SendMessageEvent({
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.senderName,
    required this.receiverName,
    this.type = 'text',
    this.senderProfilePic,
    this.receiverProfilePic,
  });

  @override
  List<Object?> get props => [
    conversationId,
    senderId,
    receiverId,
    text,
    senderName,
    receiverName,
    type,
    senderProfilePic,
    receiverProfilePic,
  ];
}

class MarkMessageAsReadEvent extends ChatMessageEvent {
  final String conversationId;
  final String messageId;
  const MarkMessageAsReadEvent({
    required this.conversationId,
    required this.messageId,
  });
  @override
  List<Object?> get props => [conversationId, messageId];
}
