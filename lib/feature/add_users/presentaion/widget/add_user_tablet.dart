import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rehana_dashboared/core/widgets/loading_widget.dart';
import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../manger/adduser_cubit.dart';
import 'imageuser.dart';

class AddUserTablet extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController villaAddress;
  final TextEditingController villaNumber;
  final TextEditingController villaLocation;
  final TextEditingController street;
  final TextEditingController area;
  final TextEditingController numOfFloors;
  final TextEditingController villaspace;

  const AddUserTablet({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.villaAddress,
    required this.villaNumber,
    required this.villaLocation,
    required this.street,
    required this.area,
    required this.numOfFloors,
    required this.villaspace,
  });

  @override
  State<AddUserTablet> createState() => _AddUserTabletState();
}

class _AddUserTabletState extends State<AddUserTablet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedMemberType;
  String? selectedVillaType;
  String completePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1.3 * MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile picture
              Imageuser(),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.upload_new_member_photo,
                style: const TextStyle(
                  fontFamily: Fonts.font,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Appcolors.kprimary,
                ),
              ),
              const SizedBox(height: 24),

              // Name and Phone fields
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: widget.name,
                      name: AppLocalizations.of(context)!.name,
                      nameinfo: AppLocalizations.of(context)!.please_enter_name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_name;
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.phone,
                        hintText:
                            AppLocalizations.of(context)!.enter_phone_number,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Appcolors.kprimary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialCountryCode: 'EG',
                      onChanged: (phone) {
                        completePhoneNumber = phone.completeNumber;
                      },
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.enter_phone_number;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email and Password fields
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
                          return AppLocalizations.of(
                            context,
                          )!.enter_valid_email;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Textformcrud(
                      controller: widget.password,
                      name: AppLocalizations.of(context)!.password,
                      nameinfo:
                          AppLocalizations.of(
                            context,
                          )!.please_enter_your_password,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_your_password;
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

              // Villa address and Villa number fields
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: widget.villaAddress,
                      name: AppLocalizations.of(context)!.villa_address,
                      nameinfo:
                          AppLocalizations.of(context)!.enter_villa_address,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.enter_villa_address;
                        }
                        if (value.length < 5) {
                          return AppLocalizations.of(
                            context,
                          )!.villa_address_must_be_at_least_5_characters;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Textformcrud(
                      controller: widget.villaNumber,
                      name: AppLocalizations.of(context)!.villa_number,
                      nameinfo:
                          AppLocalizations.of(
                            context,
                          )!.please_enter_villa_number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_villa_number;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Villa location and Street fields
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: widget.villaLocation,
                      name: AppLocalizations.of(context)!.villa_location,
                      nameinfo:
                          AppLocalizations.of(context)!.enter_villa_location,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.enter_villa_location;
                        }
                        if (value.length < 5) {
                          return AppLocalizations.of(
                            context,
                          )!.villa_location_must_be_at_least_5_characters;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Textformcrud(
                      controller: widget.street,
                      name: AppLocalizations.of(context)!.street,
                      nameinfo: AppLocalizations.of(context)!.select_street,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.select_street;
                        }
                        if (value.length < 3) {
                          return AppLocalizations.of(
                            context,
                          )!.street_must_be_at_least_3_characters;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Area and Member Type dropdown
              Row(
                children: [
                  Expanded(
                    child: Textformcrud(
                      controller: widget.villaspace,
                      name: AppLocalizations.of(context)!.area,
                      nameinfo: AppLocalizations.of(context)!.enter_area,
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enter_area;
                        }
                        if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                          return AppLocalizations.of(
                            context,
                          )!.area_must_be_valid_number;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedMemberType,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.member_type,
                        hintText:
                            AppLocalizations.of(context)!.select_member_type,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Appcolors.kprimary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'مالك',
                          child: Text(AppLocalizations.of(context)!.owner),
                        ),
                        DropdownMenuItem(
                          value: 'مستأجر',
                          child: Text(AppLocalizations.of(context)!.tenant),
                        ),
                        DropdownMenuItem(
                          value: 'مفوض',
                          child: Text(AppLocalizations.of(context)!.authorized),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedMemberType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.select_member_type;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Villa Type dropdown
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedVillaType,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.villa_type,
                        hintText:
                            AppLocalizations.of(context)!.select_villa_type,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Appcolors.kprimary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'مشطبة',
                          child: Text(AppLocalizations.of(context)!.finished),
                        ),
                        DropdownMenuItem(
                          value: 'غير مشطبة',
                          child: Text(AppLocalizations.of(context)!.unfinished),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedVillaType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.select_villa_type;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 50),

              // Save button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<AdduserCubit, AdduserState>(
                    listener: (context, state) {
                      if (state is AdduserSuccess) {
                        widget.name.clear();
                        widget.email.clear();
                        widget.password.clear();
                        widget.phone.clear();
                        widget.villaAddress.clear();
                        widget.villaLocation.clear();
                        widget.villaNumber.clear();
                        widget.villaspace.clear();
                        widget.street.clear();
                        widget.numOfFloors.clear();
                        setState(() {
                          selectedMemberType = null;
                          selectedVillaType = null;
                          completePhoneNumber = '';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "تم إضافة المستخدم بنجاح",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final adduser = context.read<AdduserCubit>();

                      return state is AdduserLoading
                          ? const Center(child: LoadingButton())
                          : CustomButton(
                            name: AppLocalizations.of(context)!.save,
                            colors: Appcolors.kBlack,
                            width: MediaQuery.of(context).size.width * 0.15,
                            onTap: () {
                              log(
                                "Adding user with data: "
                                "name: ${widget.name.text}, "
                                "email: ${widget.email.text}, "
                                "password: ${widget.password.text}, "
                                "phoneNumber: $completePhoneNumber, "
                                "villaAddress: ${widget.villaAddress.text}, "
                                "villaLocation: ${widget.villaLocation.text}, "
                                "villaNumber: ${widget.villaNumber.text}, "
                                "villaSpace: ${widget.villaspace.text}, "
                                "villaStreet: ${widget.street.text}, "
                                "villaFloorsNumber: ${widget.numOfFloors.text}, "
                                "memberType: $selectedMemberType, "
                                "villaType: $selectedVillaType",
                              );
                              if (_formKey.currentState!.validate()) {
                                adduser.addOwner(
                                  name: widget.name.text,
                                  email: widget.email.text,
                                  password: widget.password.text,
                                  phoneNumber: completePhoneNumber,
                                  villaAddress: widget.villaAddress.text,
                                  villaLocation: widget.villaLocation.text,
                                  villaNumber: widget.villaNumber.text,
                                  villaSpace: widget.villaspace.text,
                                  villaStreet: widget.street.text,
                                  // villaFloorsNumber:
                                  //     int.tryParse(widget.numOfFloors.text) ?? 0,
                                  memberType: selectedMemberType ?? '',
                                  villaType: selectedVillaType ?? '',
                                );
                              }
                            },
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
