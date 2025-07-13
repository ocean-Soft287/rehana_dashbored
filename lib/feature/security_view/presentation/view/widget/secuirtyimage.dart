import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../add_users/presentaion/manger/adduser_cubit.dart';
import '../../manger/security_cubit.dart';


class Secuirtyimage extends StatelessWidget {
  const Secuirtyimage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder< SecurityCubit, SecurityState>(
      builder: (context, state) {
        final cubit = context.read<SecurityCubit>();

        if (state is EditImagePickerProfileViewLoading) {
          return const SizedBox(
            width: 60,
            height: 60,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        Widget thumbnail;

        if (kIsWeb && cubit.imageEditProfileBytes != null) {
          thumbnail = Image.memory(
            cubit.imageEditProfileBytes!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        } else if (!kIsWeb && cubit.imageEditProfilePhoto != null) {
          thumbnail = Image.file(
            File(cubit.imageEditProfilePhoto!.path),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        } else if (image.isNotEmpty) {
          thumbnail = Image.network(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/photo/profilephoto.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        } else {
          thumbnail = Image.asset(
            'assets/photo/profilephoto.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        }

        return GestureDetector(
          onTap: cubit.getProfileImageByGallery,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: thumbnail,
          ),
        );
      },
    );
  }
}
