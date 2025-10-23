import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/add_users/data/model/securitygardmodel.dart';
import 'package:rehana_dashboared/feature/security_view/presentation/view/widget/secuirtyimage.dart';
import '../../../../../core/const/widget/table/status_cell.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/security_cubit.dart';

final _formKey = GlobalKey<FormState>();

class SecurityEditAlertDialog extends StatelessWidget {
  const SecurityEditAlertDialog({super.key, required this.securityGuardModel});

  final SecurityGuardModel securityGuardModel;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    final usernameController = TextEditingController(text: securityGuardModel.userName);
    final emailController = TextEditingController(text: securityGuardModel.email);
    final passwordController = TextEditingController();
    final phoneController = TextEditingController(text: securityGuardModel.phoneNumber);
    final gateController = TextEditingController(text: securityGuardModel.gateNumber);
    final imageName = securityGuardModel.pictureUrl;

    return BlocProvider.value(
      value: GetIt.instance<SecurityCubit>(),
      child: BlocConsumer<SecurityCubit, SecurityState>(
        listener: (context, state) {
          if (state is SecuritySuccful) Navigator.pop(context);
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text(
             AppLocalizations.of(context)!.edit_security_guard_title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: isTablet
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Secuirtyimage(image: imageName.toString()),
                      Textformcrud(
                        controller: usernameController,
                        name:AppLocalizations.of(context)!.name,
                        nameinfo:AppLocalizations.of(context)!.please_enter_name,
                        validator: (value) {

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: emailController,
                        name:AppLocalizations.of(context)!.email,
                        nameinfo:AppLocalizations.of(context)!.email_hint,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: passwordController,
                        name:AppLocalizations.of(context)!.password,
                        nameinfo:AppLocalizations.of(context)!.password_hint,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.password_required;
                          }
                          if (value.length < 8) {
                            return AppLocalizations.of(context)!.password_too_short;
                          }

                            const pattern =
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';

                            if (!RegExp(pattern).hasMatch(value)) {
                              return AppLocalizations.of(context)!.password_complexity_error;

                            }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: phoneController,
                        name:AppLocalizations.of(context)!.phone_number,
                        nameinfo:AppLocalizations.of(context)!.phone_number_hint,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !RegExp(r'^\d{10,15}$').hasMatch(value)) {
                            return AppLocalizations.of(context)!.invalid_phone_number;
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: gateController,
                        name:AppLocalizations.of(context)!.gate_number,
                        nameinfo:AppLocalizations.of(context)!.gate_number,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !RegExp(r'^\d+$').hasMatch(value)) {
                            return AppLocalizations.of(context)!.invalid_gate_number;
                          }
                          return null;
                        },

                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              StatusCell(
                accept:AppLocalizations.of(context)!.edit,
                refuse:AppLocalizations.of(context)!.cancel,
                onAccept: () {
                  if (_formKey.currentState!.validate()) {
                    final cubit = BlocProvider.of<SecurityCubit>(context);
                    cubit.updateMember(
                      id: securityGuardModel.id.toString(),
                      name: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phoneNumber: phoneController.text,
                      gateNumber: gateController.text,
                    );
                  }
                },

                onReject: () => Navigator.pop(context),
              ),
            ],
          );
        },
      ),
    );
  }
}