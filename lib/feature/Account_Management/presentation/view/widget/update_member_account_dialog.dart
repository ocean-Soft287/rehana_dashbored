import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/const/dropdownformcrud.dart';
import '../../../../../core/const/widget/table/status_cell.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/person_cubit.dart';


final _updateFormKey = GlobalKey<FormState>();


class UpdateMemberAccountDialog extends StatefulWidget {
  final String id;
  final String fullName;
  final String phoneNumber;
  final bool isMarried;
  final String address;
  final DateTime date;
  final int villaNumber;

  const UpdateMemberAccountDialog({
    super.key,
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.isMarried,
    required this.address,
    required this.date,
    required this.villaNumber,
  });

  @override
  State<UpdateMemberAccountDialog> createState() => _UpdateMemberAccountDialogState();
}

class _UpdateMemberAccountDialogState extends State<UpdateMemberAccountDialog> {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController dateController;
  late TextEditingController villaNumberController;
  late bool isMarried;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.fullName);
    phoneController = TextEditingController(text: widget.phoneNumber);
    addressController = TextEditingController(text: widget.address);
    villaNumberController = TextEditingController(text: widget.villaNumber.toString());
    dateController = TextEditingController(text: widget.date.toIso8601String());
    isMarried = widget.isMarried;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateController.dispose();
    villaNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return BlocProvider.value(
      value: GetIt.instance<PersonCubit>(), // ✅ استخدام صحيح لـ value
      child: BlocConsumer<PersonCubit, PersonState>(
        listener: (context, state) {
          if (state is UpdateSuccessful) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).update_success)),
            );

          // } else if (state is PersonFailure) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text(state.message)),
          //   );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text(
              S.of(context).edit_member_account_title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: SingleChildScrollView(
              child: Form(
                key: _updateFormKey,
                child: Container(
                  width: isTablet
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Textformcrud(
                        controller: fullNameController,
                        name: S.of(context).name,
                        nameinfo: S.of(context).please_entre_name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return S.of(context).please_entre_name;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: phoneController,
                        name: S.of(context).phone_number,
                        nameinfo: S.of(context).phone_number_hint,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).invalid_phone_number;
                          }

                          if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                            return S.of(context).invalid_phone_number;
                          }

                          if (value.length != 12) {
                            return S.of(context).invalid_phone_number;
                          }

                          return null;
                        },

                      ),
                      const SizedBox(height: 10),
                      DropdownFormCrud(
                        name: S.of(context).status,
                        hint: S.of(context).status,
                        items: [S.of(context).single, S.of(context).married],
                        value: isMarried ? S.of(context).married : S.of(context).single,
                        onChanged: (val) => setState(() {
                          isMarried = val == S.of(context).married;
                        }),
                        validator: (val) =>
                        val == null ? S.of(context).enter_status : null,
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: addressController,
                        name: S.of(context).address,
                        nameinfo: S.of(context).address,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return S.of(context).address;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaNumberController,
                        name: S.of(context).villanumber,
                        nameinfo: S.of(context).please_enter_villa_number,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return S.of(context).vilanumberisempty;
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                            return S.of(context).villa_number_must_be_numeric;
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
                accept: S.of(context).edit,
                refuse: S.of(context).cancel,
                onAccept: () {
                  if (_updateFormKey.currentState!.validate()) {
                    final cubit = BlocProvider.of<PersonCubit>(context);
                    cubit.update(
                      id: widget.id,
                      fullName: fullNameController.text.trim(),
                      phoneNumber: phoneController.text.trim(),
                      isMarried: isMarried,
                      address: addressController.text.trim(),
                      villaNumber: int.parse(villaNumberController.text.trim()),
                      date: DateTime.now().toIso8601String(),
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