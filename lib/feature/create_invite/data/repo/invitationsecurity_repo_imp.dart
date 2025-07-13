import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../model/invitation.dart';
import 'invitationsecurity_repo.dart';

class Invitatiosecuritynrepoimp implements InvitationsecurityRepo {
  final DioConsumer dioConsumer;

  Invitatiosecuritynrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, Invitation>> sendOneTimeInvitation({
    required String reasonForVisit,
    required DateTime dateFrom,
    required DateTime dateTo,
    required String guestName,
    required String guestPhoneNumber,
    required int vilaNumber,
    File? guestPicture,
  }) async {
    try {
      final formData = FormData.fromMap({
        'ReasonForVisit': reasonForVisit,
        'DateFrom': dateFrom.toUtc().toIso8601String(),
        'DateTo': dateTo.toUtc().toIso8601String(),
        'GuestName': guestName,
        'GuestPhoneNumber': guestPhoneNumber,
        'VillaNumber':vilaNumber,
        if (guestPicture != null)
          'GuestPicture': await MultipartFile.fromFile(
            guestPicture.path,
            filename: guestPicture.path.split('/').last,
          ),
      });

      final response = await dioConsumer.post(
        EndPoint.ownerOneTimeInvitation,
        data: formData,
        isFromData: true,
      );

      return Right(Invitation.fromJson(response));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure("Request failed: ${e.toString()}"));
    }
  }

  Failure _handleDioError(DioException error) {
    return ServerFailure(error.message ?? "Unknown error occurred");
  }
}