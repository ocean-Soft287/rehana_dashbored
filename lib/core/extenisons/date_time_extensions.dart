import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Formats DateTime to dd-MM-yyyy hh:mm a format (e.g., 25-12-2000 03:45 PM)
  String toCustomFormat() {
    return DateFormat('dd-MM-yyyy hh:mm a').format(this);
  }
}