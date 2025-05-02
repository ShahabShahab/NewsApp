import 'package:intl/intl.dart';

class DateService {
  const DateService._();

  static String convertToDateTimeToUserReadableDate(final DateTime dateTime) {
    return DateFormat.yMMMMd().add_Hm().format(dateTime);
  }
}
