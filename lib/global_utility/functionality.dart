import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

extension CurrencyFormatter on int {
  String toIDR() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}

Future<bool> checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }

// Future<bool> checkInternetConnection() async {
//   var connectivityResult = await Connectivity().checkConnectivity();

//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   } else {
//     return false;
//   }
// }