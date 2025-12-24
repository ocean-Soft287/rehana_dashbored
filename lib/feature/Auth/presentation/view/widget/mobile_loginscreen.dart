import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../core/utils/route/approutes.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../bar_navigation/presentation/screen/custom_column_slider.dart';
import '../../manger/auth_cubit.dart';
class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final _formKey = GlobalKey<FormState>();
bool isobsecure=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TriangleContainer(),
            const SizedBox(height: 20),
            Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.login,
                          style: AppStyles.styleLogin(context)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: widget.emailController,
                        decoration: InputDecoration(
                          labelText:AppLocalizations.of(context)!.email,
                          labelStyle: AppStyles.textformfieldstyle(context),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green.shade700)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.please;
                          }
                          if (!value.contains('@')) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: widget.passwordController,
                        obscureText:isobsecure ,
                        decoration: InputDecoration(
                          labelText:AppLocalizations.of(context)!.password,
                          labelStyle: AppStyles.textformfieldstyle(context),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green.shade700)),
                          suffixIcon:  GestureDetector(onTap: (){
                            setState(() {

                              isobsecure=!isobsecure;
                            });

                          },child: Icon(isobsecure==true ?Icons.visibility_off:Icons.visibility)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.please;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, Routes.forgetPassword),
                          child: Text(
                           AppLocalizations.of(context)!.did_you_forget_your_password,
                            style: TextStyle(
                                fontFamily: Fonts.font, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            showCustomSnackBar(
                              context,
                              AppLocalizations.of(
                                context,
                              )!.login_successfully,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const SidebarMenu()),
                                  (route) => false,
                            );
                          }

                          if (state is AuthFailure) {
                            showCustomSnackBar(
                              context,
                              state.message
                            );
                          }
                        },

                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final auth = context.read<AuthCubit>();
                          return SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              name:AppLocalizations.of(context)!.login,
                              textcolor: Appcolors.kprimary,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  auth.login(
                                    email:
                                    widget.emailController.text.trim(),
                                    password: widget.passwordController.text,
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.6); // Mid-left
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(0, 0); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TriangleContainer extends StatelessWidget {
  const TriangleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Appcolors.kprimary.withValues( alpha:0.30),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              Images.logo,
              height: 200, // Adjusted height to fit better
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
