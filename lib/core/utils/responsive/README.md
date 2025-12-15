# Responsive State Preservation Guide

This guide explains how to implement state preservation in responsive Flutter apps to prevent data loss when switching between mobile and desktop layouts.

## Problem

When using `LayoutBuilder` or `MediaQuery` to create responsive layouts, the widget tree rebuilds when the window is resized, causing:
- Text field data to be lost
- API requests to be made again
- Form state to reset
- User input to disappear

## Solution

We've implemented a comprehensive solution with three main components:

### 1. ResponsiveBuilder

A widget that prevents unnecessary rebuilds when switching between layouts.

```dart
ResponsiveBuilder(
  breakpoint: 800, // Optional, defaults to 800
  builder: (context, isMobile) {
    if (isMobile) {
      return MobileWidget();
    } else {
      return DesktopWidget();
    }
  },
)
```

### 2. StatePersistenceMixin

A mixin that preserves TextEditingController instances and other state across rebuilds.

```dart
class _MyScreenState extends State<MyScreen> with StatePersistenceMixin {
  @override
  Widget build(BuildContext context) {
    final nameController = getController('name');
    final emailController = getController('email');
    
    return ResponsiveBuilder(
      builder: (context, isMobile) {
        // Controllers are preserved across layout changes
        return MyForm(
          nameController: nameController,
          emailController: emailController,
        );
      },
    );
  }
}
```

### 3. StatePreserver

A widget that preserves its child's state across parent rebuilds.

```dart
StatePreserver(
  key: 'unique-key',
  child: MyComplexWidget(),
)
```

### 4. ApiRequestMixin

A mixin for Cubits that prevents duplicate API requests and caches responses.

```dart
class MyCubit extends Cubit<MyState> with ApiRequestMixin {
  void loadData() async {
    try {
      final result = await executeApiRequest<List<Data>>(
        'my_data_key',
        () => apiService.getData(),
        cacheDuration: Duration(minutes: 5),
      );
      emit(DataLoaded(result));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }
}
```

## Migration Steps

### Step 1: Convert StatelessWidget to StatefulWidget

```dart
// Before
class ResponsiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(); // ❌ Recreated on every build
    return LayoutBuilder(...);
  }
}

// After
class ResponsiveScreen extends StatefulWidget {
  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> with StatePersistenceMixin {
  @override
  Widget build(BuildContext context) {
    final controller = getController('field_name'); // ✅ Preserved across rebuilds
    return ResponsiveBuilder(...);
  }
}
```

### Step 2: Move BlocProvider to initState

```dart
// Before
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => GetIt.instance<MyCubit>(), // ❌ Recreated on every build
    child: ResponsiveBuilder(...),
  );
}

// After
class _MyScreenState extends State<MyScreen> {
  late MyCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.instance<MyCubit>(); // ✅ Created once
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: ResponsiveBuilder(...),
    );
  }
}
```

### Step 3: Replace LayoutBuilder with ResponsiveBuilder

```dart
// Before
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 800) {
      return MobileWidget();
    } else {
      return DesktopWidget();
    }
  },
)

// After
ResponsiveBuilder(
  builder: (context, isMobile) {
    if (isMobile) {
      return MobileWidget();
    } else {
      return DesktopWidget();
    }
  },
)
```

### Step 4: Add API Request Caching to Cubits

```dart
// Before
class MyCubit extends Cubit<MyState> {
  void loadData() async {
    emit(Loading());
    try {
      final result = await apiService.getData(); // ❌ Called every time
      emit(Loaded(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

// After
class MyCubit extends Cubit<MyState> with ApiRequestMixin {
  void loadData() async {
    if (isApiCached('data_key')) {
      final cached = getCachedApiData<List<Data>>('data_key');
      if (cached != null) {
        emit(Loaded(cached));
        return;
      }
    }

    emit(Loading());
    try {
      final result = await executeApiRequest<List<Data>>(
        'data_key',
        () => apiService.getData(),
        cacheDuration: Duration(minutes: 5),
      );
      emit(Loaded(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
```

## Best Practices

1. **Use unique keys** for controllers and cached data
2. **Set appropriate cache durations** based on data freshness requirements
3. **Clear cache when needed** (e.g., after user actions that modify data)
4. **Test on different screen sizes** to ensure state is preserved
5. **Use StatePreserver** for complex widgets that manage their own state

## Example Implementation

See the updated files for complete examples:
- `lib/feature/Auth/presentation/view/screen/login.dart`
- `lib/feature/add_users/presentaion/screen/responsive_add_user.dart`
- `lib/feature/create_invite/presentation/view/screen/responsive_create_invite.dart`