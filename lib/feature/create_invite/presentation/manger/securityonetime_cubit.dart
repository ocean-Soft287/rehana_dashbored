import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/state/api_request_mixin.dart';
import '../../data/model/invitation.dart';
import '../../data/repo/invitationsecurity_repo.dart';
part 'securityonetime_state.dart';


class SecurityonetimeCubit extends Cubit<SecurityonetimeState> with ApiRequestMixin {
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
    // Check if we already have cached data
    if (isApiCached('villa_numbers') && vilanumber.isNotEmpty) {
      emit(GetVillaNumberSuccess(vilanumber));
      return;
    }

    emit(GetVillaNumberLoading());
    
    try {
      final result = await executeApiRequest<List<int>>(
        'villa_numbers',
        () async {
          final Dio dio = Dio();
          final response = await dio.get("http://78.89.159.126:9393/TheOneAPIRehana/api/Member/villaNumbers");

          if (response.statusCode == 200 && response.data is List) {
            return List<int>.from(response.data);
          } else {
            throw Exception("Unexpected response format");
          }
        },
        cacheDuration: const Duration(minutes: 10), // Cache for 10 minutes
      );

      vilanumber
        ..clear()
        ..addAll(result);
      emit(GetVillaNumberSuccess(vilanumber));
    } catch (e) {
      emit(GetVillaNumberError(e.toString()));
    }
  }

}