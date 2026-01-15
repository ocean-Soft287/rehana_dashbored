import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';

class BondsSearchFilter extends StatefulWidget {
  final Function(String?, String?, String?, String?) onSearch;
  final VoidCallback onClear;

  const BondsSearchFilter({
    super.key,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<BondsSearchFilter> createState() => _BondsSearchFilterState();
}

class _BondsSearchFilterState extends State<BondsSearchFilter> {
  final TextEditingController villaNumberController = TextEditingController();
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  bool isExpanded = false;

  @override
  void dispose() {
    villaNumberController.dispose();
    memberNameController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _handleSearch() {
    widget.onSearch(
      villaNumberController.text.isEmpty ? null : villaNumberController.text,
      memberNameController.text.isEmpty ? null : memberNameController.text,
      fromDateController.text.isEmpty ? null : fromDateController.text,
      toDateController.text.isEmpty ? null : toDateController.text,
    );
  }

  void _handleClear() {
    villaNumberController.clear();
    memberNameController.clear();
    fromDateController.clear();
    toDateController.clear();
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'بحث',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),

          // Search Fields
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;

                  if (isWide) {
                    // Tablet/Desktop layout
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: villaNumberController,
                                label: s.villa_number,
                                hint: s.villa_number,
                                icon: Icons.home,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: memberNameController,
                                label: s.creditor,
                                hint: s.creditor,
                                icon: Icons.person,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                context: context,
                                controller: fromDateController,
                                label: 'من تاريخ',
                                hint: 'من تاريخ',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateField(
                                context: context,
                                controller: toDateController,
                                label: 'إلى تاريخ',
                                hint: 'إلى تاريخ',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: _handleClear,
                              icon: const Icon(Icons.clear),
                              label: const Text('مسح'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: _handleSearch,
                              icon: const Icon(Icons.search),
                              label: const Text('بحث'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    // Mobile layout
                    return Column(
                      children: [
                        _buildTextField(
                          controller: villaNumberController,
                          label: s.villa_number,
                          hint: s.villa_number,
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: memberNameController,
                          label: s.creditor,
                          hint: s.creditor,
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 12),
                        _buildDateField(
                          context: context,
                          controller: fromDateController,
                          label: 'من تاريخ',
                          hint: 'من تاريخ',
                        ),
                        const SizedBox(height: 12),
                        _buildDateField(
                          context: context,
                          controller: toDateController,
                          label: 'إلى تاريخ',
                          hint: 'إلى تاريخ',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _handleClear,
                                icon: const Icon(Icons.clear),
                                label: const Text('مسح'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _handleSearch,
                                icon: const Icon(Icons.search),
                                label: const Text('بحث'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context, controller),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.calendar_today, size: 20),
        suffixIcon:
            controller.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    controller.clear();
                    setState(() {});
                  },
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}
