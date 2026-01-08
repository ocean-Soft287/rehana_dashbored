// Example: How to add Bulk Disbursement to your sidebar/menu
// مثال: كيفية إضافة شاشة المصروفات الجماعية للقائمة الجانبية

import 'package:flutter/material.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/bulk_disbursement_screen_wrapper.dart';

class MenuExample extends StatelessWidget {
  const MenuExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... other menu items ...

        // Add this menu item for Bulk Disbursement
        ListTile(
          leading: Icon(Icons.dashboard, color: Color(0xFF9DC65D)),
          title: Text(
            'إدارة المصروفات',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            'صرف جماعي للفيلات',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BulkDisbursementScreenWrapper(),
              ),
            );
          },
        ),

        // ... other menu items ...
      ],
    );
  }
}

// Alternative: Using Named Routes
// بديل: استخدام Named Routes

class AppRoutes {
  static const String bulkDisbursement = '/bulk-disbursement';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // ... other routes ...
      bulkDisbursement: (context) => BulkDisbursementScreenWrapper(),
    };
  }
}

// Usage in menu:
// الاستخدام في القائمة:
/*
onTap: () {
  Navigator.pushNamed(context, AppRoutes.bulkDisbursement);
}
*/
