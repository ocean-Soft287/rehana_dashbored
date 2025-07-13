import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/create_invite/presentation/view/widget/picturewidget.dart';
import '../../../../../core/const/dropdownformcrud.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/securityonetime_cubit.dart';
import 'fromtowidget.dart';
import 'custom_date_picker.dart';

class CreateInviteMobile extends StatefulWidget {
  const CreateInviteMobile({
    super.key,
    required this.name,
    required this.phone,
    required this.numvilla,
    required this.reasonofvisit,
    required this.numofperson,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController numvilla;
  final TextEditingController reasonofvisit;
  final TextEditingController numofperson;

  @override
  State<CreateInviteMobile> createState() => _CreateInviteMobileState();
}

class _CreateInviteMobileState extends State<CreateInviteMobile> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  List<int> villaNumbers = [];
  int? selectedVilla;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم الضيف
            Textformcrud(
              controller: widget.name,
              name: '${S.of(context).name} *',
              nameinfo: S.of(context).please_entre_name,
              validator: (value) =>
              (value == null || value.trim().isEmpty)
                  ? S.of(context).please_entre_name
                  : null,
            ),
            const SizedBox(height: 10),
            // رقم الهاتف
            Textformcrud(
              controller: widget.phone,
              name: '${S.of(context).phone} *',
              nameinfo: S.of(context).enter_phone_number,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).enter_phone_number;
                }
                if(value.length!=12){
                  return S.of(context).enter_phone_number;

                }
                if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                  return S.of(context).enter_phone_number;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // رقم الفيلا
            BlocBuilder<SecurityonetimeCubit, SecurityonetimeState>(
              builder: (context, state) {


                // لو الـ Cubit رجّع الأرقام بنحطها فى الـ list
                if (state is GetVillaNumberSuccess) {
                  villaNumbers = state.villaNumbers;
                }


                return DropdownFormCrud(
                  name: S.of(context).villanumber ,
                  hint: 'اختار رقم الفيلا',
                  items: villaNumbers.map((e) => e.toString()).toList(),
                  value: selectedVilla?.toString(),
                  onChanged: (val) {
                    setState(() {
                      selectedVilla = int.tryParse(val ?? '');
                      widget.numvilla.text = val ?? '';
                    });
                  },
                  validator: (val) => val == null ? 'برجاء اختيار رقم فيلا' : null,
                );
              },
            ),
         
            const SizedBox(height: 10),
            // سبب الزيارة
            Textformcrud(
              controller: widget.reasonofvisit,
              name: '${S.of(context).reasonforvisit} *',
              nameinfo: S.of(context).reasonforvisit,
              validator: (value) =>
              (value == null || value.trim().isEmpty)
                  ? S.of(context).please_enter_reason_for_visit
                  : null,
            ),
            // اختيار التاريخ
            CustomDatePicker(
              selectedDate: _selectedDate,
              onDateSelected: (date) => setState(() => _selectedDate = date),
            ),
            const SizedBox(height: 10),
            // اختيار الوقت من/إلى
            FromtoWidget(
              selectedDate: _selectedDate,
              fromTime: _fromTime,
              toTime: _toTime,
              onTimeSelected: (from, to) =>
                  setState(() {
                    _fromTime = from;
                    _toTime = to;
                  }),
            ),
            const SizedBox(height: 10),
            Picturewidget(),
            const SizedBox(height: 50),
            // زر إنشاء الدعوة
            BlocConsumer<SecurityonetimeCubit, SecurityonetimeState>(
              listener: (context, state) {
                if (state is SecurityonetimeSuccess) {

                  _selectedDate = null;
                  _fromTime = null;
                  _toTime = null;
                  selectedVilla = null;
                  widget.phone.clear();
                  widget.name.clear();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  state.invitation.qrCode,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 100, color: Colors.red),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const CircularProgressIndicator();
                                  },
                                ),
                                const SizedBox(height: 20),
                                SelectableText(state.invitation.qrCode), // ده يتحدد ويتنسخ
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  });
                }


              },
              builder: (context, state) {
                final security = context.read<SecurityonetimeCubit>();

                return CustomButton(
                  name: S.of(context).create_invitation,
                  colors: Appcolors.kBlack,
                  onTap: () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;

                    if (_selectedDate == null ||
                        _fromTime == null ||
                        _toTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).pleaseSelectDateAndTime,
                          ),
                        ),
                      );
                      return;
                    }

                    final dateFrom = DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      _fromTime!.hour,
                      _fromTime!.minute,
                    );
                    final dateTo = DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      _toTime!.hour,
                      _toTime!.minute,
                    );

                    security.sendinvitation(
                      reasonForVisit: widget.reasonofvisit.text,
                      dateFrom: dateFrom,
                      dateTo: dateTo,
                      guestName: widget.name.text,
                      guestPhoneNumber: widget.phone.text,
                      vilaNumber: int.parse(widget.numvilla.text),
                      guestPicture: security.imageEditProfilePhoto == null
                          ? null
                          : File(security.imageEditProfilePhoto!.path),   // <-- التحويل
                    );
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
