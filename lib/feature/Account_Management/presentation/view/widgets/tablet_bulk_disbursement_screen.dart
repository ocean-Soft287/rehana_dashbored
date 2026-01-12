import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../manger/bulk_disbursement_cubit.dart';
import '../../manger/bulk_disbursement_state.dart';
import '../../../data/model/villa_list_model.dart';

class TabletBulkDisbursementScreen extends StatefulWidget {
  const TabletBulkDisbursementScreen({super.key});

  @override
  State<TabletBulkDisbursementScreen> createState() =>
      _TabletBulkDisbursementScreenState();
}

class _TabletBulkDisbursementScreenState
    extends State<TabletBulkDisbursementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pricePerMeterController = TextEditingController();
  final _bondDescriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  List<VillaListModel> _allVillas = [];
  Set<String> _selectedVillaNumbers = {};
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    context.read<BulkDisbursementCubit>().fetchVillasList();
  }

  @override
  void dispose() {
    _pricePerMeterController.dispose();
    _bondDescriptionController.dispose();
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

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedVillaNumbers = _allVillas.map((v) => v.villaNumber).toSet();
      } else {
        _selectedVillaNumbers.clear();
      }
    });
  }

  void _toggleVillaSelection(String villaNumber) {
    setState(() {
      if (_selectedVillaNumbers.contains(villaNumber)) {
        _selectedVillaNumbers.remove(villaNumber);
        _selectAll = false;
      } else {
        _selectedVillaNumbers.add(villaNumber);
        if (_selectedVillaNumbers.length == _allVillas.length) {
          _selectAll = true;
        }
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedVillaNumbers.isNotEmpty) {
      final pricePerMeter = double.tryParse(_pricePerMeterController.text) ?? 0;
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);

      context.read<BulkDisbursementCubit>().submitBulkDisbursement(
        villaNumbers: _selectedVillaNumbers.toList(),
        pricePerMeter: pricePerMeter,
        date: dateStr,
        bondDescription: _bondDescriptionController.text,
      );
    } else if (_selectedVillaNumbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار فيلا واحدة على الأقل')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BulkDisbursementCubit, BulkDisbursementState>(
      listener: (context, state) {
        if (state is VillasListLoaded) {
          setState(() {
            _allVillas = state.villas;
          });
        }
        if (state is BulkDisbursementSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إرسال المصروفات بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          _pricePerMeterController.clear();
          _bondDescriptionController.clear();
          setState(() {
            _selectedVillaNumbers.clear();
            _selectAll = false;
            _selectedDate = DateTime.now();
          });
          context.read<BulkDisbursementCubit>().fetchVillasList();
        } else if (state is BulkDisbursementError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is BulkDisbursementLoading && _allVillas.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF9DC183), Colors.white],
              stops: [0.0, 0.3],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                margin: const EdgeInsets.all(40),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'إدارة المصروفات',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9DC183),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Price Per Meter Field
                      CustomTextField(
                        controller: _pricePerMeterController,
                        labelText: 'سعر المتر',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال سعر المتر';
                          }
                          if (double.tryParse(value) == null) {
                            return 'يرجى إدخال رقم صحيح';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Bond Description Field
                      CustomTextField(
                        controller: _bondDescriptionController,
                        labelText: 'وصف السند',
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال وصف السند';
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

                      // Select All Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _selectAll
                                  ? const Color(0xFF9DC183)
                                  : Colors.transparent,
                          border: Border.all(color: const Color(0xFF9DC183)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectAll,
                              onChanged: (_) => _toggleSelectAll(),
                              activeColor: Colors.white,
                              checkColor: const Color(0xFF9DC183),
                            ),
                            Text(
                              'تحديد الكل',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _selectAll ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Villas List
                      const Text(
                        'اختيار الفلل:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _allVillas.length,
                          itemBuilder: (context, index) {
                            final villa = _allVillas[index];
                            final isSelected = _selectedVillaNumbers.contains(
                              villa.villaNumber,
                            );
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(
                                          0xFF9DC183,
                                        ).withOpacity(0.1)
                                        : Colors.white,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? const Color(0xFF9DC183)
                                          : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  '${villa.memberName} - فيلا ${villa.villaNumber}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                value: isSelected,
                                onChanged:
                                    (_) => _toggleVillaSelection(
                                      villa.villaNumber,
                                    ),
                                activeColor: const Color(0xFF9DC183),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Submit Button
                      state is BulkDisbursementLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            text: 'إرسال المصروفات',
                            onPressed: _submitForm,
                            backgroundColor: const Color(0xFF9DC183),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
