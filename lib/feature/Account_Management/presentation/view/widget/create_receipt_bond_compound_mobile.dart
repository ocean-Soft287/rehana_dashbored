import 'package:flutter/material.dart';
import '../../../../../core/utils/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/person_cubit.dart';

class CreateReceiptBondCompoundMobile extends StatefulWidget {
  const CreateReceiptBondCompoundMobile({
    super.key,
    required this.dateController,
    required this.amountController,
  });

  final TextEditingController dateController;
  final TextEditingController amountController;

  @override
  State<CreateReceiptBondCompoundMobile> createState() =>
      _CreateReceiptBondCompoundMobileState();
}

class _CreateReceiptBondCompoundMobileState
    extends State<CreateReceiptBondCompoundMobile> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCurrency;
  final List<String> currencies = ['USD', 'SAR', 'EGP', 'AED'];

  @override
  Widget build(BuildContext context) {
    final s =AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.receipt_bond_for_compound,
              style: TextStyle(
                color: Appcolors.geryblack,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues( alpha:0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Date
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

                    /// Currency
                    CustomDropdownCrud(
                      name: '${s.currency} *',
                      hint: s.currency,
                      items: currencies,
                      selectedItem: selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value;
                        selectedCurrency = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 15),

                    /// Amount
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
                    const SizedBox(height: 30),

                    /// Submit Button
                    BlocConsumer<PersonCubit, PersonState>(
                      listener: (context, state) {

                        if (state is CreateBoncompounddSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(s.bond_created_successfully),
                            ),
                          );
                          widget.dateController.clear();
                          selectedCurrency=null;
                          widget.amountController.clear();
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
                              if (selectedCurrency == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        s.please_select_bond_type_and_currency),
                                  ),
                                );
                                return;
                              }
                              cubit.createBondcompounds(
                                date: widget.dateController.text,
                                currency: selectedCurrency!,
                                amount: double.parse(
                                  widget.amountController.text.trim(),
                                ),
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
