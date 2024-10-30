import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

extension DatetimeExtension on DateTime {
  String format(String format) {
    initializeDateFormatting();
    return DateFormat(format, 'id').format(this);
  }

  String formatFilter() {
    return DateFormat('dd / MM / yyyy').format(this);
  }

  String formatReadAbleDate(String date) {
    return DateFormat('d MMMM yyyy').format(DateTime.parse(date));
  }

  String formatReadAbleDateTime(String date) {
    return DateFormat('d MMMM yyyy, HH:mm').format(DateTime.parse(date));
  }
}

extension PickerDateRangeExtension on PickerDateRange {
  String periode() {
    final startDate = (this.startDate ?? DateTime.now());
    final endDate = (this.endDate ?? DateTime.now());
    return '${startDate.format(startDate.year == endDate.year ? 'dd MMM' : 'dd MMM yyyy')} - ${endDate.format('dd MMM yyyy')}';
  }
}
