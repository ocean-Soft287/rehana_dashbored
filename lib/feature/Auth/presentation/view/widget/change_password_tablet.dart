import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/image/images.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/auth_cubit.dart';


class ConfirmResetPasswordTablet extends StatefulWidget {
  const ConfirmResetPasswordTablet({super.key});

  @override
  State<ConfirmResetPasswordTablet> createState() => _ConfirmResetPasswordTabletState();
}

class _ConfirmResetPasswordTabletState extends State<ConfirmResetPasswordTablet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    tokenController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.email_is_required;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalid_email;
    }
    return null;
  }

  String? _validateToken(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.token_is_required;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.password_is_required;
    }
    final passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%^_])[A-Za-z\d!@#\$&*~%^_]{8,}$';
    if (!RegExp(passwordPattern).hasMatch(value)) {
      return AppLocalizations.of(context)!.password_validation_message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Right side - form
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    decoration: const BoxDecoration(
                      color: Color(0x61ABBD66),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFABBD66),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             AppLocalizations.of(context)!.confirm_change_password,
                              style: AppStyles.styletitlelogin(context),
                            ),
                            const SizedBox(height: 30),

                            // Email
                            TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.right,
                              validator: _validateEmail,
                              decoration: InputDecoration(
                                labelText:AppLocalizations.of(context)!.email,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Token
                            TextFormField(
                              controller: tokenController,
                              textAlign: TextAlign.right,
                              validator: _validateToken,
                              decoration: InputDecoration(
                                labelText: "رمز التحقق",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // New Password
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              textAlign: TextAlign.right,
                              validator: _validatePassword,
                              decoration: InputDecoration(
                                labelText:AppLocalizations.of(context)!.new_password,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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

                            // Submit button
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                // يمكن إضافة إشعار هنا في حال النجاح أو الخطأ
                              },
                              builder: (context, state) {
                                 if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                
                              ),
                            );
                          }
                                final auth = context.read<AuthCubit>();
                                return SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    name: "تأكيد",
                                    textcolor: Appcolors.kprimary,
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
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Image.asset(
              Images.logo,
              fit: BoxFit.contain,
              width: width < 1200 ? 200 : 300,
              height: width < 1200 ? 300 : 500,
            ),
          ),
        ],
      ),
    );
  }
}