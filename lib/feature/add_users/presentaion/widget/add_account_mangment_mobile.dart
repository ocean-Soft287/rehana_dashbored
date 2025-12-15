import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/dropdownformcrud.dart';
import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../l10n/app_localizations.dart';import '../manger/adduser_cubit.dart';


final _formKey = GlobalKey<FormState>();

class AddAccountMangmentMobile extends StatefulWidget {
  const AddAccountMangmentMobile({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
    required this.numofvila,
    required this.date,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController status;
  final TextEditingController numofvila;
  final TextEditingController date;

  @override
  State<AddAccountMangmentMobile> createState() => _AddAccountMangmentMobileState();
}

class _AddAccountMangmentMobileState extends State<AddAccountMangmentMobile> {
  String? _selectedstatus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Textformcrud(
              controller: widget.name,
              name:AppLocalizations.of(context)!.name,
              nameinfo:AppLocalizations.of(context)!.name,
              validator: (val) =>
              val == null || val.isEmpty ?AppLocalizations.of(context)!.enter_name : null,
            ),
            const SizedBox(height: 16),
            Textformcrud(
              controller: widget.phone,
              name:AppLocalizations.of(context)!.phone,
              nameinfo:AppLocalizations.of(context)!.phone,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return AppLocalizations.of(context)!.enter_phone;
                }
                if (!RegExp(r'^\d{10,}$').hasMatch(val)) {
                  return AppLocalizations.of(context)!.enter_valid_phone_number;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),
            Textformcrud(
              controller: widget.address,
              name:AppLocalizations.of(context)!.villa_address,
              nameinfo:AppLocalizations.of(context)!.enter_villa_address,
              validator: (val) =>
              val == null || val.isEmpty ?AppLocalizations.of(context)!.enter_address : null,
            ),
            const SizedBox(height: 12),

            DropdownFormCrud(name:AppLocalizations.of(context)!.status, hint:AppLocalizations.of(context)!.status, items: [AppLocalizations.of(context)!.single,AppLocalizations.of(context)!.married],
              value: _selectedstatus?.toString(),
              onChanged: (val) => setState(() {
                _selectedstatus = (val ?? '');
                widget.status.text = val ?? '';
              }),
              validator: (val) =>
              val == null ? AppLocalizations.of(context)!.enter_status: null,
            ),

            const SizedBox(height: 16),
            Textformcrud(
              controller: widget.numofvila,
              name:AppLocalizations.of(context)!.villa_number,
              nameinfo:AppLocalizations.of(context)!.villa_number,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return AppLocalizations.of(context)!.enter_villa_number;
                }
                if (!RegExp(r'^\d+$').hasMatch(val)) {
                  return AppLocalizations.of(context)!.please_enter_numbers_only;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),
            const SizedBox(height: 16),
            BlocConsumer<AdduserCubit, AdduserState>(
                listener: (context, state) {
                  if(state is AdduserpersonSuccess){
                    widget.name.clear();
                    widget.phone.clear();
                    _selectedstatus=null;
                    widget.address.clear();
                    widget.numofvila.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('تم انشاء الحساب بنجاح')),
                        backgroundColor: Appcolors.kprimary,
                      ),
                    );

                  }
                },
  builder: (context, state) {
    final user=context.read<AdduserCubit>();
    if(state is AdduserLoading){
      return const Center(child: CircularProgressIndicator());
    }
    return CustomButton(
              name:AppLocalizations.of(context)!.create_account,
              colors: Appcolors.brown,
              width: MediaQuery.of(context).size.width * .2,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  user.adduserperson(fullName: widget.name.text,
                      phoneNumber: widget.phone.text,
                      isMarried: _selectedstatus==AppLocalizations.of(context)!.married?true:false,
                      address: widget.address.text,
                      date: DateTime.now().toUtc().toIso8601String(),
                      villaNumber: int.parse(widget.numofvila.text));

                }
              },
            );
  },
),
          ],
        ),
    ));
  }
}
