import 'package:intl/intl.dart';

String formatMonthYear(String isoDate) {
  try {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    String result = DateFormat("MMM yyyy").format(dateTime);
    return result.replaceAll("Sep", "Sept");
  } catch (e) {
    return "";
  }
}
