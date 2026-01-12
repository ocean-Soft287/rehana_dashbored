import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/villa_model.dart';
import '../../manger/collections_cubit.dart';

class MobileCollectionsScreen extends StatefulWidget {
  const MobileCollectionsScreen({super.key});

  @override
  State<MobileCollectionsScreen> createState() =>
      _MobileCollectionsScreenState();
}

class _MobileCollectionsScreenState extends State<MobileCollectionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  VillaModel? _selectedVilla;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF9DC183)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedVilla != null) {
      final amount = double.tryParse(_amountController.text) ?? 0;
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);

      context.read<CollectionsCubit>().createCollection(
        villaNumber: _selectedVilla!.villaNumber,
        amount: amount,
        date: dateStr,
        bondDescription: _descriptionController.text,
      );
    } else if (_selectedVilla == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى اختيار الفيلا')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('مقبوضات', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF9DC183),
        centerTitle: true,
      ),
      body: BlocConsumer<CollectionsCubit, CollectionsState>(
        listener: (context, state) {
          if (state is CollectionsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إضافة القبض بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            _amountController.clear();
            _descriptionController.clear();
            setState(() {
              _selectedVilla = null;
              _selectedDate = DateTime.now();
            });
            context.read<CollectionsCubit>().loadVillas();
          } else if (state is CollectionsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CollectionsLoadingVillas) {
            return const Center(child: CircularProgressIndicator());
          }

          final villas =
              state is CollectionsVillasLoaded ? state.villas : <VillaModel>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Villa Dropdown
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF9DC183)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<VillaModel>(
                        isExpanded: true,
                        hint: const Text('اختر الفيلا'),
                        value: _selectedVilla,
                        items:
                            villas.map((villa) {
                              return DropdownMenuItem<VillaModel>(
                                value: villa,
                                child: Text(villa.toString()),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedVilla = value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Amount Field
                  CustomTextField(
                    controller: _amountController,
                    labelText: 'المبلغ المدفوع',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال المبلغ';
                      }
                      if (double.tryParse(value) == null) {
                        return 'يرجى إدخال رقم صحيح';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Description Field
                  CustomTextField(
                    controller: _descriptionController,
                    labelText: 'الوصف',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الوصف';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Date Picker
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9DC183)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(_selectedDate),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF9DC183),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Currency Display
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('العملة', style: TextStyle(fontSize: 16)),
                        Text(
                          'EGP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Submit Button
                  state is CollectionsSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        text: 'إضافة مقبوض',
                        onPressed: _submitForm,
                        backgroundColor: const Color(0xFF9DC183),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
