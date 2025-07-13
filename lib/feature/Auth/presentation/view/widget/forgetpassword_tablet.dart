import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Auth/presentation/manger/auth_cubit.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../generated/l10n.dart';
import '../screen/change_password.dart';


class ForgetpasswordTablet extends StatefulWidget {
  const ForgetpasswordTablet({super.key});

  @override
  State<ForgetpasswordTablet> createState() => _ForgetpasswordTabletState();
}

class _ForgetpasswordTabletState extends State<ForgetpasswordTablet> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_entre_your_email;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return S.of(context).please_enter_valid_email;
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
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                // خلفية خضراء باهتة
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

                // خلفية خضراء أساسية + الفورم
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
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).did_you_forget_your_password,
                              style: AppStyles.styletitlelogin(context),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 30),

                            // Email Input
                            TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: S.of(context).email,
                                labelStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[700],
                                ),
                                hintText: S.of(context).please_entre_your_email,
                                hintStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 20),

                            // Send Reset Password Button
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthForgetPasswordSuccess) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Responsivechangepassword(),
                                    ),
                                        (route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(S.of(context).wesendyouresetlink),
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
                                    name: S.of(context).sendresetpasword,
                                    textcolor: Appcolors.kprimary,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        auth.forgetPassword(email: emailController.text.trim());
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
            child: Center(
              child: Image.asset(
                Images.logo,
                fit: BoxFit.contain,
                width: width < 1200 ? 200 : 300,
                height: width < 1200 ? 300 : 500,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
