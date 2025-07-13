import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/const/widget/textformcrud.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/manger/adduser_cubit.dart';

import '../../../../core/const/widget/custom_button.dart';
import 'package:flutter/material.dart'; // Added for Form and SnackBar

import '../../../../generated/l10n.dart';
import 'imageuser.dart';

class AddUserMobile extends StatelessWidget {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddUserMobile({
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
    required this.numOfFloors, required this.villaspace,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Imageuser(),

                  const SizedBox(height: 8),
                  Text(
                    S.of(context).upload_new_member_photo,
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Name field
            Textformcrud(
              controller: name,
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

            // Phone field
            Textformcrud(
              controller: phone,
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

            // Email field
            Textformcrud(
              controller: email,
              name: S.of(context).email,
              nameinfo: S.of(context).please_entre_your_email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_your_email;
                }
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return S.of(context).enter_valid_email;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password field
            Textformcrud(
              controller: password,
              name: S.of(context).password,
              nameinfo: S.of(context).please_entre_your_password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_entre_your_password;
                }
                if (value.length < 8) {
                  return S.of(context).password_must_be_at_least_6_characters;
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

            // Villa address field
            Textformcrud(
              controller: villaAddress,
              name: S.of(context).villa_address,
              nameinfo: S.of(context).enter_villa_address,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_villa_address;
                }
                if (value.length < 5) {
                  return S.of(context).villa_address_must_be_at_least_5_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Villa number field
            Textformcrud(
              controller: villaNumber,
              name: S.of(context).villanumber,
              nameinfo: S.of(context).please_enter_villa_number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_villa_number;
                }
                if (!RegExp(r'^\d+$').hasMatch(value)) {
                  return S.of(context).villa_number_must_be_numeric;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Villa location field
            Textformcrud(
              controller: villaLocation,
              name: S.of(context).villa_location,
              nameinfo: S.of(context).enter_villa_location,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_villa_location;
                }
                if (value.length < 5) {
                  return S.of(context).villa_location_must_be_at_least_5_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Street field
            Textformcrud(
              controller: street,
              name: S.of(context).street,
              nameinfo: S.of(context).select_street,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).select_street;
                }
                if (value.length < 3) {
                  return S.of(context).street_must_be_at_least_3_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Area field
            Textformcrud(
              controller: area,
              name: S.of(context).area,
              nameinfo: S.of(context).enter_area,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_area;
                }
                if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
                  return S.of(context).area_must_be_valid_number;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Number of floors field
            Textformcrud(
              controller: numOfFloors,
              name: S.of(context).number_of_floors,
              nameinfo: S.of(context).enter_number_of_floors,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).enter_number_of_floors;
                }
                if (!RegExp(r'^\d+$').hasMatch(value)) {
                  return S.of(context).number_of_floors_must_be_numeric;
                }
                return null;
              },
            ),
            const SizedBox(height: 50),

            // Save button
            BlocConsumer<AdduserCubit, AdduserState>(
  listener: (context, state) {
if(state is AdduserSuccess){

  name.clear();
  email.clear();
  password.clear();
  phone.clear();
  villaAddress.clear();
  villaLocation.clear();
  villaNumber.clear();
  villaspace.clear();
  street.clear();
  numOfFloors.clear();

}

  },
  builder: (context, state) {
   final adduser=context.read<AdduserCubit>();
    return CustomButton(
              name: S.of(context).save,
              colors: Appcolors.kBlack,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                 adduser.addOwner(
                    name: name.text,
                    email: email.text,
                    password: password.text,
                    phoneNumber: phone.text,

                    villaAddress: villaAddress.text,
                    villaLocation: villaLocation.text,
                    villaNumber: int.tryParse(villaNumber.text) ?? 0,
                    villaSpace: villaspace.text,
                    villaStreet: street.text,
                    villaFloorsNumber: int.tryParse(numOfFloors.text) ?? 0,
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


