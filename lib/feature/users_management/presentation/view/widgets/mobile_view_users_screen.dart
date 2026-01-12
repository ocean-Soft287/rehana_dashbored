import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/users_management_cubit.dart';
import 'users_table_shimmer.dart';

class MobileViewUsersScreen extends StatefulWidget {
  const MobileViewUsersScreen({super.key});

  @override
  State<MobileViewUsersScreen> createState() => _MobileViewUsersScreenState();
}

class _MobileViewUsersScreenState extends State<MobileViewUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersManagementCubit>().loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'جميع المستخدمين',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9DC183),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<UsersManagementCubit>().loadAllUsers();
            },
          ),
        ],
      ),
      body: BlocBuilder<UsersManagementCubit, UsersManagementState>(
        builder: (context, state) {
          if (state is UsersManagementLoadingUsers) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: const UsersTableShimmer(),
            );
          }

          if (state is UsersManagementError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UsersManagementCubit>().loadAllUsers();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is UsersManagementUsersLoaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'لا يوجد مستخدمين',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    const Color(0xFF9DC183).withOpacity(0.2),
                  ),
                  dataRowHeight: 70,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'الاسم الكامل',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'البريد الإلكتروني',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'رقم الهاتف',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'الصلاحية',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows:
                      state.users.map((user) {
                        return DataRow(
                          cells: [
                            DataCell(Text(user.fullName)),
                            DataCell(Text(user.email)),
                            DataCell(Text(user.phoneNumber)),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF9DC183,
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  user.getRolesInArabic(),
                                  style: const TextStyle(
                                    color: Color(0xFF9DC183),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
