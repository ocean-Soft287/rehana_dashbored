import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';


import '../../../../l10n/app_localizations.dart';import '../manger/adduser_cubit.dart';
import 'imageuser.dart';

class AddSecurityTablet extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController numofgate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddSecurityTablet({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.numofgate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1.3 * MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withValues( alpha:0.1),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Imageuser(),

              const SizedBox(height: 16),
              Text(
               AppLocalizations.of(context)!.security_guard_photo_upload,
                style: const TextStyle(
                  fontFamily: Fonts.font,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Appcolors.kprimary,
                ),
              ),
              const SizedBox(height: 24),

              // الاسم - رقم التليفون
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: name,
                      name:AppLocalizations.of(context)!.name,
                      nameinfo:AppLocalizations.of(context)!.please_enter_name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_name;
                        }
                        if (value.length < 2) {
                          return AppLocalizations.of(context)!.name_must_be_at_least_2_characters;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Textformcrud(
                      controller: phone,
                      name:AppLocalizations.of(context)!.phone,
                      nameinfo:AppLocalizations.of(context)!.enter_phone_number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enter_phone_number;
                        }
                        if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                          return AppLocalizations.of(context)!.enter_valid_phone_number;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // البريد الإلكتروني - كلمة السر
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: email,
                      name:AppLocalizations.of(context)!.email,
                      nameinfo:AppLocalizations.of(context)!.please_enter_your_email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_email;
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return AppLocalizations.of(context)!.enter_valid_email;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Textformcrud(
                      controller: password,
                      name:AppLocalizations.of(context)!.password,
                      nameinfo:AppLocalizations.of(context)!.please_enter_your_password,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_password;
                        }
                        const pattern =
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';

                        if (!RegExp(pattern).hasMatch(value)) {
                                                      return AppLocalizations.of(context)!.password_complexity_error;

                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // رقم البوابة
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: numofgate,
                      name:AppLocalizations.of(context)!.enter_gate_number,
                      nameinfo:AppLocalizations.of(context)!.enter_gate_number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enter_gate_number;
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return AppLocalizations.of(context)!.gate_number_must_be_numeric;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(child: SizedBox()), // لحفظ تنسيق الـRow
                ],
              ),
              const SizedBox(height: 50),

              // زر الحفظ
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocConsumer<AdduserCubit, AdduserState>(
  listener: (context, state) {
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
                    name:AppLocalizations.of(context)!.save,
                    colors: Appcolors.kBlack,
                    width: MediaQuery.of(context).size.width * 0.15,
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
            ],
          ),
        ),
      ),
    );
  }
}
