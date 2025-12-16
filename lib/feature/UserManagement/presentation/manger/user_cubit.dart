
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Auth/data/model/login_model.dart';
import '../../data/model/owner_model.dart';
import '../../data/usermangmentrepo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userMangmentRepo) : super(UserInitial());
  final UserMangmentRepo userMangmentRepo;

  Future<void> adduser({
    required String email,
    required String password,
    required String fullName,
    required String phonenumber,
    required String role,
  }) async {
    emit(AdduserLoading());
    final response = await userMangmentRepo.addOwner(
      email: email,
      password: password,
      fullName: fullName,
      phonenumber: phonenumber,
      role: role,
    );
    response.fold((failure) {
      emit(Adduserfailure(message: failure.message.toString()));
    }, (userModel) {
      emit(Addusersuccful(userModel: userModel));
    });
  }


  Future<void> getAllMembers() async {
    emit(GetallmemeberLoading());
    final response = await userMangmentRepo.getAllMembers();
    response.fold((failure) {
      emit(Getallmemeberfailure(message: failure.message.toString()));
    }, (usermodel) {
      emit(Getallmemebersuccful(userModel: usermodel));
    });
  }

  Future<void> getAllOwners() async {
    emit(GetAllUsersLoadingState());
    final response = await userMangmentRepo.getAllOwners();
    response.fold((failure) {
      emit(GetAllUsersFailureState(message: failure.message));
    }, (owners) {
      emit(GetAllUsersSuccessState(userModel: owners));
    });
  }





}
