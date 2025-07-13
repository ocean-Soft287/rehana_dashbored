import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';
import '../../../../generated/l10n.dart';
import '../manger/adduser_cubit.dart';
import 'imageuser.dart';

class AddSecurityMobile extends StatelessWidget {
  AddSecurityMobile({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.numofgate,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController numofgate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Imageuser(),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).security_guard_photo_upload,
                    style: const TextStyle(
                      fontFamily: Fonts.font,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Appcolors.kprimary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Textformcrud(
              controller: name,
              name: S.of(context).name,
              nameinfo: S.of(context).please_entre_name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_name;
                }
                if (value.length < 2) {
                  return S.of(context).name_must_be_at_least_2_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Textformcrud(
              controller: phone,
              name: S.of(context).phone,
              nameinfo: S.of(context).enter_phone_number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_phone_number;
                }
                if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                  return S.of(context).enter_valid_phone_number;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Textformcrud(
              controller: email,
              name: S.of(context).email,
              nameinfo: S.of(context).please_entre_your_email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_your_email;
                }
                if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return S.of(context).enter_valid_email;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Textformcrud(
              controller: password,
              name: S.of(context).password,
              nameinfo: S.of(context).please_entre_your_password,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).please_entre_your_password;
                }
                const pattern =
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';

                if (!RegExp(pattern).hasMatch(value)) {
                                              return S.of(context).password_complexity_error;

                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            Textformcrud(
              controller: numofgate,
              name: S.of(context).enter_gate_number,
              nameinfo: S.of(context).enter_gate_number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_gate_number;
                }
                if (!RegExp(r'^\d+$').hasMatch(value)) {
                  return S.of(context).gate_number_must_be_numeric;
                }
                return null;
              },
            ),
            const SizedBox(height: 50),

            BlocConsumer<AdduserCubit, AdduserState>(
    listener: (context,state){
      if (state is Addsecuritysucces) {
        name.clear();
        email.clear();
        password.clear();
        phone.clear();
        numofgate.clear();
      }
    },
  builder: (context, state) {
    final adduser=context.read<AdduserCubit>();

    return CustomButton(
              name: S.of(context).save,
              colors: Appcolors.kBlack,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  adduser.addsecurity(
                    name: name.text,
                    email: email.text,
                    password: password.text,
                    phoneNumber: phone.text,  gateNumber: numofgate.text,

                  );
                }
              },
            );
  },
),
          ],
        ),
      ),
    );
  }
}
