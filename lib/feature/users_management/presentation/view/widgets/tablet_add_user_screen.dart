import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/add_user_request_model.dart';
import '../../manger/users_management_cubit.dart';

class TabletAddUserScreen extends StatefulWidget {
  const TabletAddUserScreen({super.key});

  @override
  State<TabletAddUserScreen> createState() => _TabletAddUserScreenState();
}

class _TabletAddUserScreenState extends State<TabletAddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  UserRole? _selectedRole;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedRole != null) {
      context.read<UsersManagementCubit>().addUser(
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneController.text,
        roles: [_selectedRole!.englishName],
      );
    } else if (_selectedRole == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى اختيار الصلاحية')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersManagementCubit, UsersManagementState>(
      listener: (context, state) {
        if (state is UsersManagementUserAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة المستخدم بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          _emailController.clear();
          _passwordController.clear();
          _fullNameController.clear();
          _phoneController.clear();
          setState(() {
            _selectedRole = null;
          });
        } else if (state is UsersManagementError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
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
                constraints: const BoxConstraints(maxWidth: 600),
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
                        'إضافة مستخدم',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9DC183),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        labelText: 'البريد الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          if (!value.contains('@')) {
                            return 'يرجى إدخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        labelText: 'كلمة المرور',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF9DC183),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Full Name Field
                      CustomTextField(
                        controller: _fullNameController,
                        labelText: 'الاسم الكامل',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال الاسم الكامل';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Phone Field
                      CustomTextField(
                        controller: _phoneController,
                        labelText: 'رقم الهاتف',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال رقم الهاتف';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Role Dropdown
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF9DC183)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<UserRole>(
                            isExpanded: true,
                            hint: const Text('اختر الصلاحية'),
                            value: _selectedRole,
                            items:
                                UserRole.values.map((role) {
                                  return DropdownMenuItem<UserRole>(
                                    value: role,
                                    child: Text(role.arabicName),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Submit Button
                      state is UsersManagementAddingUser
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            text: 'إضافة مستخدم',
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
