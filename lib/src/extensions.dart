import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFormattedString() {
    return DateFormat('dd-MM-yy').format(this);
  }
}
