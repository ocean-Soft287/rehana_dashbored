import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/auth_cubit.dart';
import 'mobile_loginscreen.dart';


class ChangePasswordMobile extends StatefulWidget {
  const ChangePasswordMobile({super.key});

  @override
  State<ChangePasswordMobile> createState() => _ChangePasswordMobileState();
}

class _ChangePasswordMobileState extends State<ChangePasswordMobile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    tokenController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).emailisrequired;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value)) {
      return S.of(context).invalidemail;
    }
    return null;
  }

  String? _validateToken(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).tokenisrequired;
    }
    // You can add more validation for token if needed
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).passwordisrequired;
    }
    final passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%^_])[A-Za-z\d!@#\$&*~%^_]{8,}$';
    if (!RegExp(passwordPattern).hasMatch(value)) {
      return S.of(context).password_validation_message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TriangleContainer(),
            const SizedBox(height: 20),
            Container(
              width: 0.85 * MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      S.of(context).confirmchangepassword,
                      style: AppStyles.styleLogin(context),
                    ),
                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Token
                    TextFormField(
                      controller: tokenController,
                      keyboardType: TextInputType.number,
                      validator: _validateToken,
                      decoration: InputDecoration(
                        labelText: S.of(context).token,
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // New Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        labelText: S.of(context).newpassword,
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        // Handle state changes (show success/error message, etc.)
                      },
                      builder: (context, state) {
                        final auth = context.read<AuthCubit>();
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            textcolor: Appcolors.kprimary,
                            name: "تأكيد",
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                auth.resetPassword(
                                  email: emailController.text,
                                  token: tokenController.text,
                                  newPassword: passwordController.text,
                                );
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}