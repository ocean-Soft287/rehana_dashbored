import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/invitation.dart';
import '../../data/repo/invitationsecurity_repo.dart';
part 'securityonetime_state.dart';


class SecurityonetimeCubit extends Cubit<SecurityonetimeState> {
  SecurityonetimeCubit(this.invitationRepo) : super(SecurityonetimeInitial());

  final InvitationsecurityRepo invitationRepo;

  void sendinvitation({
    required String reasonForVisit,
    required DateTime dateFrom,
    required DateTime dateTo,
    required String guestName,
    required String guestPhoneNumber,
    required int vilaNumber,
    File? guestPicture,
  }) async {
    emit(SecurityonetimeLoading());
    final response = await invitationRepo.sendOneTimeInvitation(
      reasonForVisit: reasonForVisit,
      dateFrom: dateFrom,
      dateTo: dateTo,
      guestName: guestName,
      guestPhoneNumber: guestPhoneNumber,
      vilaNumber: vilaNumber,
      guestPicture: guestPicture,
    );
    response.fold(
          (failure) => emit(SecurityonetimeFailure(failure.message)),
          (invitation) => emit(SecurityonetimeSuccess(invitation)),
    );
  }

  XFile? imageEditProfilePhoto;     // للموبايل فقط
  Uint8List? imageEditProfileBytes; // للويب فقط

  var pickerPhoto = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    try {
      emit(EditImagePickerProfileViewLoading());

      final XFile? pickedFile = await pickerPhoto.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      // لو المستخدم لغى الاختيار
      if (pickedFile == null) {
        emit(EditImagePickerProfileViewError());
        return;
      }

      if (kIsWeb) {
        // المتصفح: نحفظ الـ bytes ونسِّف الـ XFile
        imageEditProfileBytes = await pickedFile.readAsBytes();
        imageEditProfilePhoto = null;
      } else {
        imageEditProfilePhoto = pickedFile;
        imageEditProfileBytes = null;
      }

      emit(EditImagePickerProfileViewSuccess());
    } catch (e) {
      emit(EditImagePickerProfileViewError());
    }
  }

  final List<int> vilanumber=[];

  void getvilanumber() async {
    emit(GetVillaNumberLoading());
    try {
      final Dio dio = Dio();
      final response = await dio.get("http://78.89.159.126:9393/TheOneAPIRehana/api/Member/villaNumbers");

      if (response.statusCode == 200 && response.data is List) {
        vilanumber
          ..clear()
          ..addAll(List<int>.from(response.data));
        emit(GetVillaNumberSuccess(vilanumber));
      } else {
        emit(GetVillaNumberError("Unexpected response format"));
      }
    } catch (e) {
      emit(GetVillaNumberError(e.toString()));
    }
  }

}