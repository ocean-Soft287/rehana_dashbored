import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../manger/securityonetime_cubit.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/image/images.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';

class Picturewidget extends StatelessWidget {
  const Picturewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // العنوان
        Row(
          children: [
            Text(
             AppLocalizations.of(context)!.picture,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.font,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),

        // الصورة + زر الاختيار
        BlocConsumer<SecurityonetimeCubit, SecurityonetimeState>(
          listener: (_, __) {},
          builder: (context, state) {
            final cubit = context.read<SecurityonetimeCubit>();
            final XFile? pickedFile = cubit.imageEditProfilePhoto;
            final Uint8List? pickedBytes = cubit.imageEditProfileBytes;

            Widget thumbnail;
            if (kIsWeb && pickedBytes != null) {
              thumbnail = Image.memory(
                pickedBytes,
                width: 146,
                height: 132,
                fit: BoxFit.contain,
              );
            } else if (!kIsWeb && pickedFile != null) {
              thumbnail = Image.file(
                File(pickedFile.path),
                width: 146,
                height: 132,
                fit: BoxFit.contain,
              );
            } else {
              thumbnail = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.photo, width: 18, height: 18),
                  const SizedBox(height: 21),
                  Text(
                   AppLocalizations.of(context)!.add_photo,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: Fonts.font,
                    ),
                  ),
                ],
              );
            }

            return GestureDetector(
              onTap: cubit.getProfileImageByGallery,
              child: Container(
                alignment: Alignment.center,
                width: 146,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Appcolors.black),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: thumbnail,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 26),
      ],
    );
  }
}
