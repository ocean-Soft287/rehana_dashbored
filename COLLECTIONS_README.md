# صفحة المقبوضات - دليل التشغيل

## التغييرات التي تمت

### 1. حذف صفحة إنشاء الحساب

تم استبدال صفحة "إنشاء حساب" بصفحة "مقبوضات" الجديدة في القائمة الجانبية.

### 2. إنشاء صفحة المقبوضات الجديدة

تم إنشاء صفحة جديدة تحتوي على:

- **Dropdown** لاختيار الفيلا (يعرض اسم المالك ورقم الفيلا)
- **Text Field** لإدخال المبلغ المدفوع
- **Text Field** لإدخال الوصف
- **Date Picker** لاختيار التاريخ
- **عرض العملة** (EGP - ثابتة)

### 3. الملفات المُنشأة

#### Models

- `lib/feature/collections/data/models/villa_model.dart` - نموذج بيانات الفيلا
- `lib/feature/collections/data/models/collection_request_model.dart` - نموذج طلب المقبوض

#### Repository

- `lib/feature/collections/data/repo/collections_repo.dart` - واجهة Repository
- `lib/feature/collections/data/repo/collections_repo_impl.dart` - تنفيذ Repository

#### Cubit (State Management)

- `lib/feature/collections/presentation/manger/collections_cubit.dart` - إدارة الحالة
- `lib/feature/collections/presentation/manger/collections_state.dart` - حالات الصفحة

#### Screens

- `lib/feature/collections/presentation/view/screen/responsive_collections_screen.dart` - الشاشة الرئيسية
- `lib/feature/collections/presentation/view/widgets/mobile_collections_screen.dart` - نسخة الموبايل
- `lib/feature/collections/presentation/view/widgets/tablet_collections_screen.dart` - نسخة التابلت

#### Shared Widgets

- `lib/core/widgets/custom_text_field.dart` - حقل نص مخصص
- `lib/core/widgets/custom_button.dart` - زر مخصص

### 4. الملفات المُحدَّثة

#### Endpoints

- `lib/core/utils/api/endpoint.dart`
  - إضافة endpoint جديد: `createCollection`

#### Navigation

- `lib/feature/bar_navigation/manger/bar_cubit.dart`
  - استبدال "إنشاء حساب" بـ "مقبوضات" في القائمة الجانبية (Index 1, SubIndex 2)
  - تحديث الأيقونة إلى `Icons.payments`

#### Dependency Injection

- `lib/core/utils/services/services_locator.dart`
  - تسجيل `CollectionsRepo` و `CollectionsCubit`

## API Endpoints المستخدمة

### 1. جلب قائمة الفلل

```
GET /api/Dashboard/list
```

### 2. إنشاء مقبوض جديد

```
POST /api/Dashboard/createBondForMember
Body:
{
  "villaNumber": "string",
  "amount": 0,
  "date": "2026-01-12",
  "currency": "EGP",
  "bondDescription": "string"
}
```

## كيفية الوصول للصفحة

1. افتح التطبيق
2. من القائمة الجانبية، اضغط على "إدارة الحساب"
3. اختر "مقبوضات" (الخيار الثالث)

## الميزات

✅ Dropdown تفاعلي لاختيار الفيلا مع عرض اسم المالك ورقم الفيلا
✅ حقول إدخال محمية بـ Validation
✅ Date Picker مخصص
✅ عرض العملة ثابت (EGP)
✅ رسائل نجاح وخطأ واضحة
✅ تصميم Responsive (موبايل وتابلت)
✅ تكامل كامل مع State Management (Cubit)

## ملاحظات مهمة

- العملة ثابتة على "EGP" ولا يمكن تغييرها
- التاريخ بصيغة ISO: `yyyy-MM-dd`
- يجب ملء جميع الحقول قبل الإرسال
- بعد النجاح، يتم مسح الحقول تلقائياً

## إذا واجهت مشكلة CORS

إذا ظهرت رسالة خطأ تتعلق بـ CORS عند استخدام Web، قم بأحد الحلول التالية:

1. **الحل الموصى به**: اطلب من فريق Backend إضافة CORS headers
2. **للتطوير**: استخدم النسخة على Mobile أو Desktop
3. **بديل**: قم بتشغيل Chrome مع تعطيل CORS:
   ```bash
   flutter run -d chrome --web-browser-flag "--disable-web-security"
   ```
