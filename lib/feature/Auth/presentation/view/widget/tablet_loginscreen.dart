import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/utils/appstyle/app_styles.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/core/widgets/custom_snack_bar.dart';
import 'package:rehana_dashboared/feature/Auth/presentation/manger/auth_cubit.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../core/utils/route/approutes.dart';
import '../../../../bar_navigation/presentation/screen/custom_column_slider.dart';

class TabletLoginScreen extends StatefulWidget {
  const TabletLoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<TabletLoginScreen> createState() => _TabletLoginScreenState();
}

class _TabletLoginScreenState extends State<TabletLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isobsecure = true;

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
                // الخلفية الخضراء
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: double.infinity,
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
                // فورم الدخول
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFABBD66),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 50,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyles.styletitlelogin(context),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: widget.emailController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.email,
                                labelStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[700],
                                ),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.please_enter_your_email,
                                hintStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppLocalizations.of(context)!.please;
                                }
                                if (!value.contains('@')) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.invalid_email; // ضيف الترجمة دى عندك
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: widget.passwordController,
                              obscureText: isobsecure,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context)!.password,
                                labelStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[700],
                                ),
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.please_enter_your_password,
                                hintStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isobsecure = !isobsecure;
                                    });
                                  },
                                  child: Icon(
                                    isobsecure == true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
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
                                onPressed:
                                    () => Navigator.pushNamed(
                                      context,
                                      Routes.forgetPassword,
                                    ),
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.did_you_forget_your_password,
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (_) {},
                                  activeColor: Appcolors.kprimary,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.remember_me,
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            "تم تسجيل الدخول بنجاح",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Appcolors.bIcon,
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: EdgeInsets.all(16),
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SidebarMenu(),
                                    ),
                                    (route) => false,
                                  );
                                }

                                if (state is AuthFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Colors.red,
                                    ),
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
                                    name: AppLocalizations.of(context)!.login,
                                    textcolor: Appcolors.kprimary,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        auth.login(
                                          email:
                                              widget.emailController.text
                                                  .trim(),
                                          password:
                                              widget.passwordController.text,
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
