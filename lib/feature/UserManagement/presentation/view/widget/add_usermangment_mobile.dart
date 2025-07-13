import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/UserManagement/presentation/manger/user_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class AddUsermangmentMobile extends StatefulWidget {
  const AddUsermangmentMobile({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.password, required this.jobs,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final List<String>jobs;

  @override
  State<AddUsermangmentMobile> createState() => _AddUsermangmentMobileState();
}

class _AddUsermangmentMobileState extends State<AddUsermangmentMobile> {
  String? selectedJob;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            /// Name field
            Textformcrud(
              controller: widget.name,
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

            /// Phone field
            Textformcrud(
              controller: widget.phone,
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
              controller: widget.email,
              name: S.of(context).email,
              nameinfo: S.of(context).please_entre_your_email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_your_email;
                }
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return S.of(context).enter_valid_email;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            /// Password field
            Textformcrud(
              controller: widget.password,
              name: S.of(context).password,
              nameinfo: S.of(context).please_entre_your_password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_your_password;
                }
                if (value.length < 8) {
                  return S
                      .of(context)
                      .password_must_be_at_least_6_characters;
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

            CustomDropdownCrud(
              name: '${S.of(context).job} *',
              hint: S.of(context).job,
              items:widget.jobs,
              selectedItem: selectedJob,
              onChanged: (String? value) {
                setState(() {
                  selectedJob = value;
                });
              },
            ),

            const SizedBox(height: 50),

        BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {

        if(state is Adduserfailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message.toString()),
            ),
          );
          if (state is Addusersuccful||state is Getallmemebersuccful){
            Navigator.pop(context);
            widget.name.text = '';
            widget.phone.text = '';
            widget.email.text = '';
            widget.password.text = '';
            setState(() {
              selectedJob = null;
            });
          }
          print("objectobjectobject");
          Navigator.pop(context);

        }
          },
          builder: (context, state) {
            final usercubit=context.read<UserCubit>();
            return CustomButton(
          name: S.of(context).add,
          colors: Appcolors.bIcon,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (selectedJob == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).please_choose_job),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              else{
                usercubit.adduser(email: widget.email.text,
                    password: widget.password.text,
                    fullName: widget.name.text,
                    phonenumber: widget.phone.text,
                    role: selectedJob.toString()=="مدير الحساب"?"Account Manager":"Admin");
              }


            }
          },
        );
          },
        )
          ],
        ),
      ),
    );
  }
}
