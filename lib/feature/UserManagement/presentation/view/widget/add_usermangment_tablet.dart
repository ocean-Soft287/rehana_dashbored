import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../manger/user_cubit.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class AddUsermangmentTablet extends StatefulWidget {
  const AddUsermangmentTablet({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.jobs,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final List<String> jobs;

  @override
  State<AddUsermangmentTablet> createState() => _AddUsermangmentTabletState();
}

class _AddUsermangmentTabletState extends State<AddUsermangmentTablet> {
  String? selectedJob;
  late final UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
  }

  void _clearForm() {
    widget.name.clear();
    widget.phone.clear();
    widget.email.clear();
    widget.password.clear();
    setState(() {
      selectedJob = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            /// Name and Phone fields side by side
            Row(
              children: [
                Expanded(
                  child: Textformcrud(
                    controller: widget.name,
                    name: AppLocalizations.of(context)!.name,
                    nameinfo: AppLocalizations.of(context)!.please_enter_name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_name;
                      }
                      if (value.length < 2) {
                        return AppLocalizations.of(
                          context,
                        )!.name_must_be_at_least_2_characters;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Textformcrud(
                    controller: widget.phone,
                    name: AppLocalizations.of(context)!.phone,
                    nameinfo: AppLocalizations.of(context)!.enter_phone_number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enter_phone_number;
                      }
                      if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                        return AppLocalizations.of(
                          context,
                        )!.enter_valid_phone_number;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Email and Password fields side by side
            Row(
              children: [
                Expanded(
                  child: Textformcrud(
                    controller: widget.email,
                    name: AppLocalizations.of(context)!.email,
                    nameinfo:
                        AppLocalizations.of(context)!.please_enter_your_email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.please_enter_your_email;
                      }
                      if (!RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return AppLocalizations.of(context)!.enter_valid_email;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Textformcrud(
                    controller: widget.password,
                    name: AppLocalizations.of(context)!.password,
                    nameinfo:
                        AppLocalizations.of(
                          context,
                        )!.please_enter_your_password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.please_enter_your_password;
                      }
                      if (value.length < 8) {
                        return AppLocalizations.of(
                          context,
                        )!.password_must_be_at_least_8_characters;
                      }
                      const pattern =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
                      if (!RegExp(pattern).hasMatch(value)) {
                        return AppLocalizations.of(
                          context,
                        )!.password_complexity_error;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Job dropdown
            CustomDropdownCrud(
              name: '${AppLocalizations.of(context)!.job} *',
              hint: AppLocalizations.of(context)!.job,
              items: widget.jobs,
              selectedItem: selectedJob,
              onChanged: (String? value) {
                setState(() {
                  selectedJob = value;
                });
              },
            ),

            const SizedBox(height: 50),

            BlocConsumer<UserCubit, UserState>(
              buildWhen: (previous, current) => current != previous,
              listener: (context, state) {
                if (state is Adduserfailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is Addusersuccful) {
                  // Clear form
                  _clearForm();

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.add_user_successfully,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Only pop if in a bottom sheet (mobile)
                  if (isMobile) {
                    Navigator.pop(context);
                  }
                }
                // ❌ REMOVED: Getallmemebersuccful condition - it doesn't belong in Add User form
              },
              builder: (context, state) {
                if (state is AdduserLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CustomButton(
                  name: AppLocalizations.of(context)!.add,
                  colors: Appcolors.bIcon,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (selectedJob == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.please_choose_job,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      _userCubit.adduser(
                        email: widget.email.text,
                        password: widget.password.text,
                        fullName: widget.name.text,
                        phonenumber: widget.phone.text,
                        role:
                            selectedJob.toString() == "مدير الحساب"
                                ? "Account Manager"
                                : "Admin",
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
