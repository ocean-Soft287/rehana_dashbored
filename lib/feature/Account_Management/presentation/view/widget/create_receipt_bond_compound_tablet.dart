import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_drop_down_menu.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../manger/person_cubit.dart';

class CreateReceiptBondCompoundTablet extends StatefulWidget {
  const CreateReceiptBondCompoundTablet({
    super.key,
    required this.dateController,
    required this.amountController,
  });

  final TextEditingController dateController;
  final TextEditingController amountController;

  @override
  State<CreateReceiptBondCompoundTablet> createState() =>
      _CreateReceiptBondCompoundTabletState();
}

class _CreateReceiptBondCompoundTabletState
    extends State<CreateReceiptBondCompoundTablet> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCurrency;
  final List<String> currencies = ['USD', 'SAR', 'EGP', 'AED'];

  @override
  Widget build(BuildContext context) {
    final s =AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.receipt_bond_for_compound,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Appcolors.geryblack,
            ),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height * 0.9,
            ),            child: Container(
            alignment: Alignment.center,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues( alpha:0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        /// Date Field
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
                                validator: (value) =>
                                value == null || value.isEmpty
                                    ? s.please_enter_bond_date
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),

                        /// Currency Field
                        Expanded(
                          child: CustomDropdownCrud(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    /// Amount Field
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
                              if (double.tryParse(value) == null) {
                                return s.amount_must_be_numeric;
                              }
                              return null;
                            },
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 40),

                    /// Save Button
                    Row(
                      children: [
                        BlocConsumer<PersonCubit, PersonState>(
                          listener: (context, state) {

                            if (state is CreateBoncompounddSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(s.owner_disbursement_bond_created),
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
                              width: 200,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedCurrency == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(s
                                            .please_select_bond_type_and_currency),
                                      ),
                                    );

                                    return;
                                  }

                                  cubit.createBondcompounds(
                                    date: widget.dateController.text,
                                    currency: selectedCurrency!,
                                    amount: double.parse(widget
                                        .amountController.text
                                        .trim()),
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
    );
  }
}
