import 'package:flutter/material.dart';

/// A responsive builder that preserves state when switching between layouts
class ResponsiveBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool isMobile) builder;
  final double breakpoint;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.breakpoint = 800,
  });

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  bool? _lastIsMobile;
  Widget? _cachedWidget;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < widget.breakpoint;

    // Only rebuild if the mobile state actually changed
    if (_lastIsMobile != isMobile || _cachedWidget == null) {
      _cachedWidget = widget.builder(context, isMobile);
      _lastIsMobile = isMobile;
    }

    return _cachedWidget!;
  }
}

/// A mixin to preserve controllers and state across rebuilds
mixin StatePersistenceMixin<T extends StatefulWidget> on State<T> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _values = {};

  /// Get or create a TextEditingController with the given key
  TextEditingController getController(String key, [String? initialValue]) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: initialValue);
    }
    return _controllers[key]!;
  }

  /// Store a value with the given key
  void setValue(String key, dynamic value) {
    _values[key] = value;
  }

  /// Get a stored value by key
  U? getValue<U>(String key) {
    return _values[key] as U?;
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _values.clear();
    super.dispose();
  }
}