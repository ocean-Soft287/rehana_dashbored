import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../data/model/chat_user.dart';
import '../../data/repo/chat_repo.dart';

part 'chat_contacts_event.dart';

class ChatContactsCubit extends Bloc<ChatContactEvent, BaseState<ChatUser>> {
  final ChatRepository repo;

  ChatContactsCubit(this.repo) : super(const BaseState<ChatUser>()) {
    on<GetContactsEvent>(_onGetContacts);
    on<GetUsersEvent>(_onGetUsers);
  }

  static ChatContactsCubit get(context) => BlocProvider.of(context);

  Future<void> _onGetContacts(
    GetContactsEvent event,
    Emitter<BaseState<ChatUser>> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      repo.getContacts(),
      onData: (either) {
        return either.fold(
          (failure) => state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
          ),
          (users) => state.copyWith(status: Status.success, items: users),
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

  Future<void> _onGetUsers(
    GetUsersEvent event,
    Emitter<BaseState<ChatUser>> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      repo.getUsers(),
      onData: (either) {
        return either.fold(
          (failure) => state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
          ),
          (users) => state.copyWith(status: Status.success, items: users),
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
}
