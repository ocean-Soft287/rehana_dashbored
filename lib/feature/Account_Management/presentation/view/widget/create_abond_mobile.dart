import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/person_cubit.dart';
final _formKey = GlobalKey<FormState>();

class CreateBondMobile extends StatefulWidget {
  const CreateBondMobile({
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
  final TextEditingController amountController;
  final TextEditingController accountNumberController;
  final TextEditingController descriptionController;
  final TextEditingController villaNumberController;

  @override
  State<CreateBondMobile> createState() => _CreateBondMobileState();
}

class _CreateBondMobileState extends State<CreateBondMobile> {
  String? selectedBondType;
  String? selectedCurrency;
  final List<String> currencies = ['USD', 'SAR', 'EGP', 'AED'];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.create_bond,
              style: TextStyle(
                color: Appcolors.geryblack,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
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
                          validator: (value) => value == null || value.isEmpty
                              ? s.please_enter_bond_date
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomDropdownCrud(
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
                    const SizedBox(height: 15),
                    CustomDropdownCrud(
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
                    const SizedBox(height: 15),
                    Textformcrud(
                      controller: widget.amountController,
                      name: '${s.amount} *',
                      nameinfo: s.amount,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return s.please_enter_amount;
                        }
                        if (double.tryParse(value) == null) {
                          return s.amount_must_be_numeric;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Textformcrud(
                      controller: widget.descriptionController,
                      nameinfo: s.bond_explain,
                      name: s.bond_explain,
                      validator: (value) => value == null || value.isEmpty
                          ? s.please_enter_bond_description
                          : null,
                    ),
                    const SizedBox(height: 15),
                    Textformcrud(
                      controller: widget.villaNumberController,
                      nameinfo: s.entrevillanumber,
                      name: s.villanumber,
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
                    const SizedBox(height: 30),
                    BlocConsumer<PersonCubit, PersonState>(
                      listener: (context, state) {
                        if (state is CreateBondFail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.of(context).villa_number_not_found)),
                          );
                        }
                        if (state is CreateBondSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.of(context).bond_created_successfully)),
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
                        final cubit = context.read<PersonCubit>();
                        return CustomButton(
                          name: s.save,
                          colors: Appcolors.kBlack,
                          width: double.infinity,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedBondType == null ||
                                  selectedCurrency == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text(S.of(context).please_select_bond_type_and_currency),
                                  ),
                                );
                                return;
                              }
                              cubit.createBond(
                                date: widget.dateController.text,
                                currency: selectedCurrency!,
                                amount: double.parse(
                                    widget.amountController.text.trim()),
                                type: selectedBondType == s.receipt_bond
                                    ? "Receipt"
                                    : "Disbursement",
                                villaNumber: int.parse(
                                    widget.villaNumberController.text.trim()),
                                bondDescription:
                                widget.descriptionController.text.trim(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
