import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/create_invite/presentation/view/widget/fromtowidget.dart';

import '../../../../../core/const/dropdownformcrud.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/securityonetime_cubit.dart';
import 'custom_date_picker.dart';
final formKey = GlobalKey<FormState>();

class CreateInviteTablet extends StatefulWidget {
  const CreateInviteTablet({
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
  State<CreateInviteTablet> createState() => _CreateInviteTabletState();
}
class _CreateInviteTabletState extends State<CreateInviteTablet> {
  // 1) مفاتيح ومتغيرات الحالة على مستوى الـ State
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  List<int> _villaNumbers = [];
  int? _selectedVilla;

  @override
  Widget build(BuildContext context) {
    final security = context.read<SecurityonetimeCubit>();

    return Form(
      key: _formKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .99,
                  width: constraints.maxWidth * .95,
                  margin: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues( alpha:.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Textformcrud(
                                  controller: widget.name,
                                  name: '${AppLocalizations.of(context)!.name} *',
                                  nameinfo:AppLocalizations.of(context)!.please_enter_name,
                                  validator: (v) => (v == null || v.trim().isEmpty)
                                      ?AppLocalizations.of(context)!.please_enter_name
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Textformcrud(
                                  controller: widget.phone,
                                  name: '${AppLocalizations.of(context)!.phone} *',
                                  nameinfo:AppLocalizations.of(context)!.enter_phone_number,
                                  keyboardType: TextInputType.phone,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return AppLocalizations.of(context)!.enter_phone_number;
                                    }
                                    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(v)) {
                                      return AppLocalizations.of(context)!.enter_phone_number;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ---------- صف رقم الفيلا وسبب الزيارة ----------
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<SecurityonetimeCubit,
                                    SecurityonetimeState>(
                                  builder: (context, state) {
                                    if (state is GetVillaNumberSuccess) {
                                      _villaNumbers = state.villaNumbers;
                                    }
                                    return DropdownFormCrud(
                                      name:AppLocalizations.of(context)!.villa_number,
                                      hint: 'اختار رقم الفيلا',
                                      items: _villaNumbers
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: _selectedVilla?.toString(),
                                      onChanged: (val) => setState(() {
                                        _selectedVilla = int.tryParse(val ?? '');
                                        widget.numvilla.text = val ?? '';
                                      }),
                                      validator: (val) =>
                                      val == null ? 'برجاء اختيار رقم فيلا' : null,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Textformcrud(
                                  controller: widget.reasonofvisit,
                                  name: '${AppLocalizations.of(context)!.reason_for_visit} *',
                                  nameinfo:AppLocalizations.of(context)!.reason_for_visit,
                                  validator: (v) => (v == null || v.trim().isEmpty)
                                      ?AppLocalizations.of(context)!.please_enter_reason_for_visit
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ---------- اختيار الوقت من / إلى ----------
                          Row(
                            children: [
                              Expanded(
                                child: FromtoWidget(
                                  selectedDate: _selectedDate,
                                  fromTime: _fromTime,
                                  toTime: _toTime,
                                  onTimeSelected: (f, t) =>
                                      setState(() {
                                        _fromTime = f;
                                        _toTime = t;
                                      }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ---------- اختيار التاريخ ----------
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePicker(
                                  selectedDate: _selectedDate,
                                  onDateSelected: (d) =>
                                      setState(() => _selectedDate = d),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),

                          BlocConsumer<SecurityonetimeCubit,
                              SecurityonetimeState>(
                            listener: (context, state) {
                              if (state is SecurityonetimeSuccess) {
                                // صفِّر الحقول بعد النجاح
                                _formKey.currentState?.reset();
                                _selectedDate = null;
                                _fromTime = null;
                                _toTime = null;
                                _selectedVilla = null;
                                widget.name.clear();
                                widget.phone.clear();
                                widget.reasonofvisit.clear();
                                widget.numvilla.clear();
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
                            builder: (context, state) => CustomButton(
                              name:AppLocalizations.of(context)!.create_invitation,
                              colors: Appcolors.kBlack,
                              width: MediaQuery.of(context).size.width * .15,
                              onTap: () {
                                if (!(_formKey.currentState?.validate() ?? false)) return;

                                if (_selectedDate == null ||
                                    _fromTime == null ||
                                    _toTime == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                       AppLocalizations.of(context)!.please_select_date_and_time,
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
                                      : File(security.imageEditProfilePhoto!.path),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
