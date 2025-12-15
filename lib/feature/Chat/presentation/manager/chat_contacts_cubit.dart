import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/chat_repo.dart';
import 'chat_contacts_state.dart';

class ChatContactsCubit extends Cubit<ChatContactsState> {
  final ChatRepository repo;

  ChatContactsCubit(this.repo) : super(ChatContactsInitial());

  static ChatContactsCubit get(context) => BlocProvider.of(context);

  void getContacts() {
    emit(ChatContactsLoading());
    try {
      repo.getContacts().listen(
        (contacts) {
          emit(ChatContactsLoaded(contacts));
        },
        onError: (error) {
          emit(ChatContactsError(error.toString()));
        },
      );
    } catch (e) {
      emit(ChatContactsError(e.toString()));
    }
  }
}
