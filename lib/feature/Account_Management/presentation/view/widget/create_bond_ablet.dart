import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/person_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';


class CreateBondTablet extends StatefulWidget {
  const CreateBondTablet({
    super.key,
    required this.dateController,
    required this.currencyController,
    required this.accountNumberController,
    required this.descriptionController,
    required this.villaNumberController,
    required this.amountController,
  });

  final TextEditingController dateController;
  final TextEditingController currencyController;
  final TextEditingController accountNumberController;
  final TextEditingController amountController;

  final TextEditingController descriptionController;
  final TextEditingController villaNumberController;

  @override
  State<CreateBondTablet> createState() => _CreateBondTabletState();
}

class _CreateBondTabletState extends State<CreateBondTablet> {
  final _formKey = GlobalKey<FormState>();
  String? selectedBondType;
  String? selectedCurrency;
  final List<String> currencies = ['USD', 'SAR', 'EGP', 'AED'];

  @override
  Widget build(BuildContext context) {
    final s =AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  s.create_bond,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.geryblack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * 0.9,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues( alpha:0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  widget.dateController.text =
                                      pickedDate.toUtc().toIso8601String();
                                }
                              },
                              child: AbsorbPointer(
                                child: Textformcrud(
                                  controller: widget.dateController,
                                  name: '${s.voucher_date} *',
                                  nameinfo: s.voucher_date,
                                  validator:
                                      (value) =>
                                          value == null || value.isEmpty
                                              ? s.please_enter_bond_date
                                              : null,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomDropdownCrud(
                              name: '${s.currency} *',
                              hint: s.currency,
                              items: currencies,
                              selectedItem: selectedCurrency,
                              onChanged: (value) {
                                setState(() {
                                  selectedCurrency = value;
                                  widget.currencyController.text = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdownCrud(
                              name: s.bond_type,
                              hint: s.bond_type,
                              items: [s.receipt_bond, s.payment_bond],
                              selectedItem: selectedBondType,
                              onChanged: (value) {
                                setState(() {
                                  selectedBondType = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Textformcrud(
                              controller: widget.amountController,
                              name: '${s.amount} *',
                              nameinfo: s.amount,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return s.please_enter_amount;
                                }
                                if (int.tryParse(value) == null) {
                                  return s.amount_must_be_numeric;
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),

                          const SizedBox(width: 20),
                          Expanded(
                            child: Textformcrud(
                              controller: widget.descriptionController,
                              name: s.bond_explain,
                              nameinfo: s.bond_explain,
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? s.please_enter_bond_description
                                          : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Textformcrud(
                              controller: widget.villaNumberController,
                              name: s.villa_number,
                              nameinfo: s.villa_number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return s.please_enter_villa_number;
                                }
                                if (int.tryParse(value) == null) {
                                  return s.villa_number_must_be_numeric;
                                }
                                return null;
                              },
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BlocConsumer<PersonCubit, PersonState>(
                            listener: (context, state) {
if(state is CreateBondFail){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(AppLocalizations.of(context)!.villa_number_not_found)),

  );}
if(state is CreateBondSuccess){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(AppLocalizations.of(context)!.bond_created_successfully)),

  );
  selectedBondType=null;
  selectedCurrency=null;
  widget.dateController.clear();
  widget.amountController.clear();
  widget.villaNumberController.clear();
  widget.descriptionController.clear();
}

                            },
                            builder: (context, state) {
                              final personcubit = context.read<PersonCubit>();
                              return CustomButton(
                                name: s.save,
                                colors: Appcolors.kBlack,
                                width: 200,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (selectedBondType == null ||
                                        selectedCurrency == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                          Text(AppLocalizations.of(context)!.please_select_bond_type_and_currency),
                                        ),
                                      );
                                      return;
                                    }
                                    personcubit.createBond(
                                      date: widget.dateController.text,
                                      currency: selectedCurrency.toString(),
                                      amount: double.parse(widget.amountController.text),
                                      type: selectedBondType==s.receipt_bond?"Receipt":"Disbursement",
                                      villaNumber: int.parse(widget.villaNumberController.text),
                                      bondDescription: widget.descriptionController.text,
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
            ),
          ],
        ),
      ),
    );
  }
}
