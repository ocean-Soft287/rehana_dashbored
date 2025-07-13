import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/add_users/presentaion/manger/adduser_cubit.dart';

import '../../../../core/const/dropdownformcrud.dart';
import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../generated/l10n.dart';


final _formKey = GlobalKey<FormState>();

class AddAccountMangmentTablet extends StatefulWidget {
  const AddAccountMangmentTablet({
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
  State<AddAccountMangmentTablet> createState() => _AddAccountMangmentTabletState();
}

class _AddAccountMangmentTabletState extends State<AddAccountMangmentTablet> {
  String? _selectedstatus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1.3 * MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
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
              const SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Textformcrud(
                      controller: widget.name,
                      name: S.of(context).name,
                      nameinfo: S.of(context).name,
                      validator: (val) =>
                      val == null || val.isEmpty ? S.of(context).enter_name : null,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Textformcrud(
                      controller: widget.phone,
                      name: S.of(context).phone,
                      nameinfo: S.of(context).phone,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return S.of(context).enter_phone;
                        }
                        if (!RegExp(r'^\d{10,}$').hasMatch(val)) {
                          return S.of(context).enter_valid_phone_number;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Textformcrud(
                      controller: widget.address,
                      name: S.of(context).villa_address,
                      nameinfo: S.of(context).enter_villa_address,
                      validator: (val) =>
                      val == null || val.isEmpty ? S.of(context).enter_address : null,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: DropdownFormCrud(name: S.of(context).status, hint:S.of(context).status, items: [S.of(context).single,S.of(context).married],
                      value: _selectedstatus?.toString(),
                      onChanged: (val) => setState(() {
                        _selectedstatus = (val ?? '');
                        widget.status.text = val ?? '';
                      }),
                      validator: (val) =>
                      val == null ?  S.of(context).enter_status: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Textformcrud(
                      controller: widget.numofvila,
                      name: S.of(context).villanumber,
                      nameinfo: S.of(context).villanumber,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return S.of(context).enter_villa_number;
                        }
                        if (!RegExp(r'^\d+$').hasMatch(val)) {
                          return S.of(context).please_enter_numbers_only;
                        }
                        return null;
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 104),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<AdduserCubit, AdduserState>(
                  listener: (context, state) {
                    if(state is AdduserpersonSuccess){
                      widget.name.clear();
                      widget.phone.clear();
                      _selectedstatus=null;
                      widget.address.clear();
                      widget.numofvila.clear();


                    }
                  },
                  builder: (context, state) {
                    final addUserCubit = context.read<AdduserCubit>();

                    return CustomButton(
                      name: S.of(context).create_account,
                      colors: Appcolors.brown,
                      width: MediaQuery.of(context).size.width * .2,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addUserCubit.adduserperson(fullName: widget.name.text,
                              phoneNumber: widget.phone.text,
                              isMarried: _selectedstatus==S.of(context).married?true:false,
                              address: widget.address.text,
                              date: DateTime.now().toUtc().toIso8601String(),
                              villaNumber: int.parse(widget.numofvila.text));

                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
