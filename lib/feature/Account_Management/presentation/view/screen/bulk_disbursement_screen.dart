import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/model/villa_list_model.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/bulk_disbursement_cubit.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/bulk_disbursement_state.dart';

class BulkDisbursementScreen extends StatefulWidget {
  const BulkDisbursementScreen({super.key});

  @override
  State<BulkDisbursementScreen> createState() => _BulkDisbursementScreenState();
}

class _BulkDisbursementScreenState extends State<BulkDisbursementScreen> {
  final TextEditingController pricePerMeterController = TextEditingController();
  final TextEditingController bondDescriptionController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();
  List<VillaListModel> allVillas = [];
  Set<String> selectedVillaNumbers = {};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    context.read<BulkDisbursementCubit>().fetchVillasList();
  }

  @override
  void dispose() {
    pricePerMeterController.dispose();
    bondDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF9DC65D),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      if (selectAll) {
        selectedVillaNumbers = allVillas.map((v) => v.villaNumber).toSet();
      } else {
        selectedVillaNumbers.clear();
      }
    });
  }

  void _toggleVillaSelection(String villaNumber) {
    setState(() {
      if (selectedVillaNumbers.contains(villaNumber)) {
        selectedVillaNumbers.remove(villaNumber);
        selectAll = false;
      } else {
        selectedVillaNumbers.add(villaNumber);
        if (selectedVillaNumbers.length == allVillas.length) {
          selectAll = true;
        }
      }
    });
  }

  void _submitBulkDisbursement() {
    if (selectedVillaNumbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء اختيار فيلا واحدة على الأقل'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (pricePerMeterController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء إدخال سعر المتر'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (bondDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء إدخال وصف السند'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<BulkDisbursementCubit>().submitBulkDisbursement(
      villaNumbers: selectedVillaNumbers.toList(),
      pricePerMeter: double.parse(pricePerMeterController.text),
      date: DateFormat('yyyy-MM-dd').format(selectedDate),
      bondDescription: bondDescriptionController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: BlocConsumer<BulkDisbursementCubit, BulkDisbursementState>(
        listener: (context, state) {
          if (state is VillasListLoaded) {
            setState(() {
              allVillas = state.villas;
            });
          }
          if (state is BulkDisbursementSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم إرسال الطلب بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            // Reset form
            setState(() {
              selectedVillaNumbers.clear();
              selectAll = false;
              pricePerMeterController.clear();
              bondDescriptionController.clear();
              selectedDate = DateTime.now();
            });
          }
          if (state is BulkDisbursementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('حدث خطأ: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(Icons.dashboard, color: Color(0xFF9DC65D), size: 32),
                      SizedBox(width: 16),
                      Text(
                        'إدارة المصروفات',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  // Price per meter input
                  _buildSectionTitle('سعر المتر'),
                  SizedBox(height: 12),
                  _buildInputField(
                    controller: pricePerMeterController,
                    hint: 'أدخل سعر المتر',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 24),

                  // Date picker
                  _buildSectionTitle('التاريخ'),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE0E0E0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Color(0xFF9DC65D)),
                          SizedBox(width: 12),
                          Text(
                            DateFormat('yyyy-MM-dd').format(selectedDate),
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Bond description
                  _buildSectionTitle('وصف السند'),
                  SizedBox(height: 12),
                  _buildInputField(
                    controller: bondDescriptionController,
                    hint: 'أدخل وصف السند',
                    prefixIcon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: 24),

                  // Currency (fixed to EGP)
                  _buildSectionTitle('العملة'),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF9DC65D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF9DC65D)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on, color: Color(0xFF9DC65D)),
                        SizedBox(width: 12),
                        Text(
                          'EGP - الجنيه المصري',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Select all button
                  _buildSectionTitle('اختيار الفلل'),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _toggleSelectAll,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: selectAll ? Color(0xFF9DC65D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFF9DC65D), width: 2),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectAll,
                            onChanged: (_) => _toggleSelectAll(),
                            activeColor: Colors.white,
                            checkColor: Color(0xFF9DC65D),
                            side: BorderSide(
                              color:
                                  selectAll ? Colors.white : Color(0xFF9DC65D),
                              width: 2,
                            ),
                          ),
                          Text(
                            'اختيار الكل',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  selectAll ? Colors.white : Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Villas list
                  if (state is VillasListLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF9DC65D),
                        ),
                      ),
                    )
                  else if (state is VillasListError)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'خطأ في تحميل البيانات: ${state.message}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  else if (allVillas.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text('لا توجد فلل متاحة'),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF9DC65D).withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.home, color: Color(0xFF9DC65D)),
                                SizedBox(width: 8),
                                Text(
                                  'قائمة الفلل (${allVillas.length})',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Villas
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allVillas.length,
                            separatorBuilder:
                                (context, index) => Divider(height: 1),
                            itemBuilder: (context, index) {
                              final villa = allVillas[index];
                              final isSelected = selectedVillaNumbers.contains(
                                villa.villaNumber,
                              );

                              return InkWell(
                                onTap:
                                    () => _toggleVillaSelection(
                                      villa.villaNumber,
                                    ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  color:
                                      isSelected
                                          ? Color(0xFF9DC65D).withOpacity(0.1)
                                          : Colors.white,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isSelected,
                                        onChanged:
                                            (_) => _toggleVillaSelection(
                                              villa.villaNumber,
                                            ),
                                        activeColor: Color(0xFF9DC65D),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'فيلا : ${villa.villaNumber.toString()}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2C3E50),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              villa.memberName,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 32),

                  // Submit button
                  if (state is BulkDisbursementLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF9DC65D),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitBulkDisbursement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9DC65D),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'إرسال الطلب',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF9DC65D),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon, color: Color(0xFF9DC65D)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF9DC65D), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
