import 'package:intl/intl.dart';

class AppHelper {


static String formatNumber(int number) {
    final formatter = new NumberFormat("#,###");
    return formatter.format(number);
}
}