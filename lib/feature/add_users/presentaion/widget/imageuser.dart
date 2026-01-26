import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/adduser_cubit.dart';

class Imageuser extends StatelessWidget {
  const Imageuser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdduserCubit, AdduserState>(
      builder: (context, state) {
        final cubit = context.read<AdduserCubit>();

        // لو فيه عملية تحميل أثناء اختيار الصورة
        if (state is EditImagePickerProfileViewLoading) {
          return const SizedBox(
            width: 60,
            height: 60,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        // حدّد الصورة المعروضة
        Widget thumbnail;
        if (kIsWeb && cubit.imageEditProfileBytes != null) {
          // متصفح
          thumbnail = Image.memory(
            cubit.imageEditProfileBytes!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
        } else if (!kIsWeb && cubit.imageEditProfilePhoto != null) {
          // موبايل
          thumbnail = Image.file(
            File(cubit.imageEditProfilePhoto!.path),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
        } else {
          thumbnail = Image.asset(
            'assets/photo/profilephoto.png',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
        }

        return GestureDetector(
          onTap: cubit.getProfileImageByGallery,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge, // يخلّي الصورة جوّه الدائرة
            child: thumbnail,
          ),
        );
      },
    );
  }
}
