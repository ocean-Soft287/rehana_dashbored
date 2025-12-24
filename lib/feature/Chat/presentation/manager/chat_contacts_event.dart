part of "chat_contacts_cubit.dart";

abstract interface class ChatContactEvent extends Equatable {
  const ChatContactEvent();
  @override
  List<Object?> get props => [];
}

class GetContactsEvent extends ChatContactEvent {
  const GetContactsEvent();
}

class GetUsersEvent extends ChatContactEvent {
  const GetUsersEvent();
}
