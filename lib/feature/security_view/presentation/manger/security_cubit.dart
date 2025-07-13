import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/securitygardmodel.dart';
import 'package:rehana_dashboared/feature/security_view/data/repo/security_repo.dart';

import '../../../../core/utils/Network/local/hive_crud_manager.dart';

part 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit(this.securityrepo) : super(SecurityInitial());

  final Securityrepo securityrepo;

  List<SecurityGuardModel> _currentList = [];

  Future<void> getallSecurity() async {
    final response = await securityrepo.getSecurityData();
    if (isClosed) return;

    response.fold(
          (failure) {
        if (isClosed) return; // تأكد هنا كمان
        emit(SecurityFailure(error: failure.message));
      },
          (securityList) {
        if (isClosed) return;
        _currentList = securityList;
        HiveCrudManager.saveList(
          "shared_data_box",
          "category",
          _currentList.map((e) => e.toJson()).toList(),
        );
        emit(SecuritySuccful(securityguard: securityList));
      },
    );
  }

  Future<void> deleteMember(int id) async {
    final response = await securityrepo.deleteSecurity(id);
    if (isClosed) return;

    response.fold(
          (failure) {
        if (isClosed) return;
        emit(SecurityFailure(error: failure.message));
      },
          (message) async {
        _currentList.removeWhere((element) => element.id == id);

        if (isClosed) return;
        emit(Securitydelete(message));

        if (isClosed) return;
        emit(SecuritySuccful(securityguard: List.from(_currentList)));
      },
    );
  }

  XFile? _pickedXFile;
  Uint8List? _pickedBytes;

  XFile? get imageEditProfilePhoto => _pickedXFile;
  Uint8List? get imageEditProfileBytes => _pickedBytes;

  final _picker = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (isClosed) return;

      if (picked == null) {
        if (isClosed) return;
        emit(EditImagePickerProfileViewError());
        return;
      }

      if (kIsWeb) {
        _pickedBytes = await picked.readAsBytes();
        if (isClosed) return;
        _pickedXFile = null;
      } else {
        _pickedXFile = picked;
        _pickedBytes = null;
      }

      if (isClosed) return;
      emit(EditImagePickerProfileViewSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(EditImagePickerProfileViewError());
    }
  }

  Future<void> updateMember({
    required String id,
    required String password,
    String? name,
    String? email,
    String? phoneNumber,
    String? gateNumber,
  }) async {
    MultipartFile? imageFile;

    if (_pickedXFile != null && !kIsWeb) {
      imageFile = await MultipartFile.fromFile(_pickedXFile!.path, filename: _pickedXFile!.name);
      if (isClosed) return;
    } else if (_pickedBytes != null && kIsWeb) {
      imageFile = MultipartFile.fromBytes(_pickedBytes!, filename: 'profile.jpg');
    }

    final response = await securityrepo.updatesecurity(
      id: id,
      password: password,
      name: name.toString(),
      email: email.toString(),
      phoneNumber: phoneNumber.toString(),
      image: imageFile,
      gateNumber: gateNumber.toString(),
    );
    if (isClosed) return;

    response.fold(
          (failure) {
        if (isClosed) return;
        emit(SecurityFailure(error: failure.message));
      },
          (updatedGuard) async {
        final index = _currentList.indexWhere((e) => e.id.toString() == id);
        if (index != -1) {
          _currentList[index] = updatedGuard;
        }

        if (isClosed) return;
        emit(SecurityUpdate(securityGuardModel: updatedGuard));

        if (isClosed) return;
        emit(SecuritySuccful(securityguard: List.from(_currentList)));
      },
    );
  }
}
