# Bulk Disbursement Feature - دليل الاستخدام

## نظرة عامة
هذه الميزة تسمح بإنشاء سندات صرف جماعية للفيلات، مع إمكانية:
- عرض قائمة الفيلات مع أسماء الأعضاء
- اختيار فيلا واحدة أو أكثر
- اختيار جميع الفيلات بضغطة واحدة
- تحديد سعر المتر والتاريخ ووصف السند
- العملة ثابتة على EGP

## الملفات الجديدة المُنشأة

### 1. Models (النماذج)
- `villa_list_model.dart` - نموذج لتمثيل بيانات الفيلا من API
- `bulk_disbursement_model.dart` - نموذج لطلب الصرف الجماعي

### 2. State Management (إدارة الحالة)
- `bulk_disbursement_cubit.dart` - منطق إدارة الحالة
- `bulk_disbursement_state.dart` - حالات التطبيق المختلفة

### 3. UI (الواجهة)
- `bulk_disbursement_screen.dart` - الشاشة الأساسية
- `bulk_disbursement_screen_wrapper.dart` - Wrapper مع BlocProvider

### 4. API
تم إضافة endpoints جديدة في `endpoint.dart`:
- `villasList` - جلب قائمة الفيلات
- `bulkDisbursement` - إرسال طلب الصرف الجماعي

### 5. Repository
تم إضافة functions في:
- `accountmangmentrepo.dart` (interface)
- `accountmangmentrepoimp.dart` (implementation)

## كيفية الاستخدام

### الطريقة 1: باستخدام Wrapper
```dart
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/bulk_disbursement_screen_wrapper.dart';

// في أي مكان في التطبيق
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BulkDisbursementScreenWrapper(),
  ),
);
```

### الطريقة 2: يدوياً مع BlocProvider
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/repo/accountmangmentrepoimp.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/manger/bulk_disbursement_cubit.dart';
import 'package:rehana_dashboared/feature/Account_Management/presentation/view/screen/bulk_disbursement_screen.dart';

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => BulkDisbursementCubit(
        AccountMangmentrepoimp(
          dioConsumer: context.read<DioConsumer>(),
        ),
      ),
      child: BulkDisbursementScreen(),
    ),
  ),
);
```

### الطريقة 3: إضافة للقائمة الجانبية أو الـ Navigation
```dart
// في ملف routes أو navigation
case '/bulk-disbursement':
  return BulkDisbursementScreenWrapper();
```

## الميزات

### 1. جلب قائمة الفيلات
عند فتح الشاشة، يتم تلقائياً جلب قائمة الفيلات من:
```
GET /api/Dashboard/list
```

Response:
```json
[
  {
    "villaNumber": 1,
    "memberName": "أحمد محمد"
  },
  ...
]
```

### 2. اختيار الفيلات
- **اختيار فردي**: اضغط على أي فيلا لتحديدها
- **اختيار الكل**: استخدم زر "اختيار الكل" لتحديد/إلغاء تحديد جميع الفيلات

### 3. إدخال البيانات
يجب إدخال:
- **سعر المتر**: رقم عشري
- **التاريخ**: اختر من date picker (يسمح باختيار تاريخ قديم)
- **وصف السند**: نص وصفي
- **العملة**: ثابتة على EGP (لا يمكن التعديل)

### 4. إرسال الطلب
عند الضغط على "إرسال الطلب"، يتم:
1. التحقق من صحة البيانات
2. إرسال POST request إلى:
```
POST /api/Dashboard/bulkDisbursement
```

Request Body:
```json
{
  "villaNumbers": [1, 2, 3],
  "pricePerMeter": 150.5,
  "date": "2026-01-08T14:23:57.561Z",
  "currency": "EGP",
  "bondDescription": "وصف السند"
}
```

## التحقق من الأخطاء

تتضمن الشاشة validation للتأكد من:
- اختيار فيلا واحدة على الأقل
- إدخال سعر المتر
- إدخال وصف السند

## الرسائل

### رسائل النجاح
- عند نجاح الإرسال: "تم إرسال الطلب بنجاح" (أخضر)
- يتم إعادة تعيين النموذج تلقائياً

### رسائل الخطأ
- عند فشل جلب البيانات: تظهر رسالة خطأ (أحمر)
- عند فشل الإرسال: "حدث خطأ: [تفاصيل الخطأ]" (أحمر)

## التصميم

### الألوان
- اللون الأساسي: `#9DC65D` (أخضر فاتح)
- لون الخلفية: `#F5F5F5` (رمادي فاتح جداً)
- لون النص: `#2C3E50` (رمادي غامق)

### الأيقونات
- Dashboard: `Icons.dashboard`
- المال: `Icons.attach_money`
- التقويم: `Icons.calendar_today`
- الوصف: `Icons.description`
- العملة: `Icons.monetization_on`
- المنزل: `Icons.home`
- إرسال: `Icons.send`

## ملاحظات مهمة

1. **RTL Support**: الشاشة تدعم العربية بالكامل مع TextDirection.rtl
2. **Loading States**: تظهر مؤشرات تحميل أثناء جلب البيانات والإرسال
3. **Error Handling**: معالجة شاملة للأخطاء مع رسائل واضحة
4. **Form Reset**: يتم إعادة تعيين النموذج تلقائياً بعد النجاح
5. **Validation**: التحقق من جميع الحقول قبل الإرسال

## الاعتماديات المطلوبة

الحزم المستخدمة (موجودة بالفعل في pubspec.yaml):
- `flutter_bloc` - إدارة الحالة
- `equatable` - مقارنة الكائنات
- `dartz` - Either monad
- `dio` - HTTP requests
- `intl` - تنسيق التاريخ

## للمطورين

### إضافة ميزات جديدة
لإضافة حقول جديدة:
1. عدّل `BulkDisbursementModel` 
2. أضف TextField في `BulkDisbursementScreen`
3. عدّل `_submitBulkDisbursement()` method

### تخصيص التصميم
جميع الألوان والأحجام موجودة في:
- `_buildSectionTitle()` - عناوين الأقسام
- `_buildInputField()` - حقول الإدخال
- Constants في build method - باقي التصميم
