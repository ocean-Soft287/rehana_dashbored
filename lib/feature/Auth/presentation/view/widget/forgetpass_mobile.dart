import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Auth/presentation/manger/auth_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../screen/change_password.dart';
import 'mobile_loginscreen.dart';


class ForgetpassMobile extends StatefulWidget {
  const ForgetpassMobile({super.key});

  @override
  State<ForgetpassMobile> createState() => _ForgetpassMobileState();
}

class _ForgetpassMobileState extends State<ForgetpassMobile> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Email validation function
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.please_enter_your_email;
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.please_enter_valid_email;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TriangleContainer(),
            const SizedBox(height: 20),
            Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                shape: BoxShape.rectangle,
                border: Border.all(color: Appcolors.kwhite),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues( alpha:0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey, // Assign the form key
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                       AppLocalizations.of(context)!.did_you_forget_your_password,
                        style: AppStyles.styleLogin(context),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText:AppLocalizations.of(context)!.email,
                          labelStyle: AppStyles.textformfieldstyle(context),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail, // Add validator
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, Routes.forgetPassword);
                          },
                          child: Text(
                           AppLocalizations.of(context)!.did_you_forget_your_password,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthForgetPasswordSuccess) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Responsivechangepassword()),
                                  (route) => false,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.we_send_you_reset_link),
                              ),
                            );
                          }
                          if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          final auth = context.read<AuthCubit>();

                          return SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              textcolor: Appcolors.kprimary,

                              name:AppLocalizations.of(context)!.send_reset_password,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Only proceed if the form is valid
                                  auth.forgetPassword(email: emailController.text);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}