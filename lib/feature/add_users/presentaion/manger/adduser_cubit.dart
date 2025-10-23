import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:rehana_dashboared/core/utils/Failure/failure.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/ownermodel.dart';
import 'package:rehana_dashboared/feature/add_users/data/repo/adduserrepo.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../data/model/person_model.dart';
import '../../data/model/securitygardmodel.dart';

part 'adduser_state.dart';



class AdduserCubit extends Cubit<AdduserState> {
  final Adduserrepo _repo;
  AdduserCubit(this._repo) : super(AdduserInitial());

  XFile?   _pickedXFile;  // للموبايل
  Uint8List? _pickedBytes; // للويب

  XFile?   get imageEditProfilePhoto  => _pickedXFile;
  Uint8List? get imageEditProfileBytes => _pickedBytes;

  final _picker = ImagePicker();

  Future<void> getProfileImageByGallery() async {
    emit(EditImagePickerProfileViewLoading());

    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked == null) {
        emit(EditImagePickerProfileViewError());
        return;
      }

      if (kIsWeb) {
        _pickedBytes = await picked.readAsBytes();
        _pickedXFile = null;
      } else {
        _pickedXFile  = picked;
        _pickedBytes  = null;
      }

      emit(EditImagePickerProfileViewSuccess());
    } catch (e) {
      emit(EditImagePickerProfileViewError());
    }
  }
  Future<void> adduserperson({
    required String fullName,
    required String phoneNumber,
    required bool isMarried,
    required String address,
    required String date,
    required int villaNumber,
  }) async {
    emit(AdduserLoading());

    final Either<Failure, Person> res = await _repo.adduserperson(
      fullName: fullName,
      phoneNumber: phoneNumber,
      isMarried: isMarried,
      address: address,
      date: date,
      villaNumber: villaNumber,
    );

    res.fold(
          (f) {
        emit(AdduserFailure(f.message));
      },
          (person) {
            _pickedXFile = null;
            _pickedBytes = null;
        emit(AdduserpersonSuccess( person: person));
      },
    );
  }

  Future<void> addOwner({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String villaAddress,
    required String villaLocation,
    required int    villaNumber,
    required String villaSpace,
    required String villaStreet,
    required int    villaFloorsNumber,
  }) async {
    emit(AdduserLoading());

    MultipartFile? imagePart;
    if (kIsWeb && _pickedBytes != null) {
      imagePart = MultipartFile.fromBytes(
        _pickedBytes!,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.png',
        contentType: MediaType('image', 'png'),
      );
    } else if (!kIsWeb && _pickedXFile != null) {
      imagePart = await MultipartFile.fromFile(
        _pickedXFile!.path,
        filename: path.basename(_pickedXFile!.path),
      );
    }

    final Either<Failure, OwnerModel> res = await _repo.addOwner(
      name              : name,
      email             : email,
      password          : password,
      phoneNumber       : phoneNumber,
      image             : imagePart,
      villaAddress      : villaAddress,
      villaLocation     : villaLocation,
      villaNumber       : villaNumber,
      villaSpace        : villaSpace,
      villaStreet       : villaStreet,
      villaFloorsNumber : villaFloorsNumber,
    );

    res.fold(
          (f) {emit(AdduserFailure(f.message));

          },
          (o) {
            _pickedXFile = null;
            _pickedBytes = null;
            emit(AdduserSuccess(o));
          },
    );
  }
 Future<void>addsecurity({
   required String name,
   required String email,
   required String password,
   required String phoneNumber,
   required String gateNumber,
 })async{
    emit(AdduserLoading());
   MultipartFile? imagePart;
   if (kIsWeb && _pickedBytes != null) {
     imagePart = MultipartFile.fromBytes(
       _pickedBytes!,
       filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.png',
       contentType: MediaType('image', 'png'),
     );
   } else if (!kIsWeb && _pickedXFile != null) {
     imagePart = await MultipartFile.fromFile(
       _pickedXFile!.path,
       filename: path.basename(_pickedXFile!.path),
     );
   }

   final Either<Failure, SecurityGuardModel> res = await _repo.addsecurity(
     name              : name,
     email             : email,
     password          : password,
     phoneNumber       : phoneNumber,
     image             : imagePart,
     gateNumber: gateNumber,

   );

   res.fold(
         (f) {emit(AddsecurityFailure(f.message));
     print(f.message);

     },
         (o) {
           _pickedXFile = null;
           _pickedBytes = null;
           emit(Addsecuritysucces( securityGuardModel: o));
         }
   );
 }
}
