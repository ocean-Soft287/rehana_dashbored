import 'package:flutter/material.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';

// Model for Villa
class VillaModel {
  final String number;
  final double area;
  bool isSelected;

  VillaModel({
    required this.number,
    required this.area,
    this.isSelected = false,
  });
}

class ResponsiveAddBond extends StatelessWidget {
  const ResponsiveAddBond({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const AddBondDesktop();
        } else if (constraints.maxWidth > 800) {
          return const AddBondTablet();
        } else {
          return const AddBondMobile();
        }
      },
    );
  }
}

// Desktop Layout
class AddBondDesktop extends StatelessWidget {
  const AddBondDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddBondContent();
  }
}

// Tablet Layout
class AddBondTablet extends StatelessWidget {
  const AddBondTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddBondContent();
  }
}

// Mobile Layout
class AddBondMobile extends StatelessWidget {
  const AddBondMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddBondContent();
  }
}

// Shared Content
class AddBondContent extends StatefulWidget {
  const AddBondContent({super.key});

  @override
  State<AddBondContent> createState() => _AddBondContentState();
}

class _AddBondContentState extends State<AddBondContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pricePerMeterController =
      TextEditingController();

  // TODO: Later this will come from API
  List<VillaModel> villas = [
    VillaModel(number: 'V-001', area: 250.5),
    VillaModel(number: 'V-002', area: 300.0),
    VillaModel(number: 'V-003', area: 275.8),
    VillaModel(number: 'V-004', area: 320.5),
    VillaModel(number: 'V-005', area: 290.0),
    VillaModel(number: 'V-006', area: 310.3),
    VillaModel(number: 'V-007', area: 265.7),
    VillaModel(number: 'V-008', area: 295.2),
  ];

  bool selectAll = false;
  bool isExpanded = false;

  @override
  void dispose() {
    _pricePerMeterController.dispose();
    super.dispose();
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var villa in villas) {
        villa.isSelected = selectAll;
      }
    });
  }

  void _toggleVillaSelection(int index, bool? value) {
    setState(() {
      villas[index].isSelected = value ?? false;

      // Check if all are selected
      selectAll = villas.every((villa) => villa.isSelected);
    });
  }

  Future<void> _submitExpenses() async {
    if (_formKey.currentState!.validate()) {
      final selectedVillas = villas.where((villa) => villa.isSelected).toList();

      if (selectedVillas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'يرجى اختيار فيلا واحدة على الأقل',
              style: TextStyle(fontFamily: Fonts.font),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final pricePerMeter = double.tryParse(_pricePerMeterController.text);
      if (pricePerMeter == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'سعر المتر غير صحيح',
              style: TextStyle(fontFamily: Fonts.font),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Prepare the data for POST request
      final List<String> villaNumbers =
          selectedVillas.map((v) => v.number).toList();

      // TODO: Make POST request here
      // Example:
      // final response = await http.post(
      //   Uri.parse('your-api-endpoint'),
      //   body: json.encode({
      //     'price_per_meter': pricePerMeter,
      //     'villa_numbers': villaNumbers,
      //   }),
      // );

      print('Price per meter: $pricePerMeter');
      print('Selected villas: $villaNumbers');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'سيتم حفظ البيانات:\nسعر المتر: $pricePerMeter\nعدد الفلل: ${villaNumbers.length}',
            style: TextStyle(fontFamily: Fonts.font),
          ),
          backgroundColor: Appcolors.kprimary,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 32,
                  color: Appcolors.kprimary,
                ),
                const SizedBox(width: 12),
                Text(
                  'إدارة المصروفات',
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kprimary1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Form Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price per meter
                    _buildTextField(
                      controller: _pricePerMeterController,
                      label: 'سعر المتر',
                      hint: 'أدخل سعر المتر',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),

                    // Villas Dropdown Section
                    Text(
                      'اختر الفلل',
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Appcolors.kprimary1,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Select All Checkbox
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Appcolors.kprimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Appcolors.kprimary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: selectAll,
                            onChanged: _toggleSelectAll,
                            activeColor: Appcolors.kprimary,
                          ),
                          Text(
                            'اختيار الكل',
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Appcolors.kprimary1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Expandable Villas List
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Dropdown Header
                          InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft:
                                      isExpanded
                                          ? Radius.zero
                                          : const Radius.circular(12),
                                  bottomRight:
                                      isExpanded
                                          ? Radius.zero
                                          : const Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Appcolors.kprimary,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'قائمة الفلل (${villas.where((v) => v.isSelected).length}/${villas.length})',
                                        style: TextStyle(
                                          fontFamily: Fonts.font,
                                          fontSize: 16,
                                          color: Appcolors.kprimary1,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.home,
                                        color: Appcolors.kprimary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Villas List
                          if (isExpanded)
                            Container(
                              constraints: const BoxConstraints(maxHeight: 300),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: villas.length,
                                separatorBuilder:
                                    (context, index) => Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                itemBuilder: (context, index) {
                                  final villa = villas[index];
                                  return CheckboxListTile(
                                    value: villa.isSelected,
                                    onChanged:
                                        (value) =>
                                            _toggleVillaSelection(index, value),
                                    activeColor: Appcolors.kprimary,
                                    title: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'فيلا ${villa.number}',
                                            style: TextStyle(
                                              fontFamily: Fonts.font,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Appcolors.kprimary
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'المساحة: ${villa.area} م²',
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: 13,
                                                color: Appcolors.kprimary1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitExpenses,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolors.kprimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'حفظ المصروفات',
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: Fonts.font,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Appcolors.kprimary1,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: Fonts.font, color: Colors.grey),
            prefixIcon: Icon(icon, color: Appcolors.kprimary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolors.kprimary, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          style: TextStyle(fontFamily: Fonts.font, fontSize: 16),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            if (keyboardType == TextInputType.number) {
              if (double.tryParse(value) == null) {
                return 'يرجى إدخال رقم صحيح';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
