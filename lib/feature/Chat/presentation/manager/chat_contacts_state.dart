import '../../data/model/chat_user.dart';

abstract class ChatContactsState {}

class ChatContactsInitial extends ChatContactsState {}

class ChatContactsLoading extends ChatContactsState {}

class ChatContactsLoaded extends ChatContactsState {
  final List<ChatUser> contacts;
  ChatContactsLoaded(this.contacts);
}

class ChatContactsError extends ChatContactsState {
  final String message;
  ChatContactsError(this.message);
}
