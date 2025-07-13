
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Auth/data/model/login_model.dart';
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
  Future<void> getallmemeber() async {
    final response = await userMangmentRepo.getallowner();
    response.fold((failure) {
      emit(Getallmemeberfailure(message: failure.message.toString()));
    }, (usermodel) {
      emit(Getallmemebersuccful(userModel: usermodel));
    });
  }





}
