import 'package:e_pesan_resto/models/cart_model.dart';
import 'package:flutter/material.dart';
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

String calculateCartItem(List<CartModel> data) {
  var value = 0;
  for (var e in data) {
    value += e.price!;
  }
  return value.toIDR();
}

Future<bool> checkInternetConnection() async {
  bool isConnected = await InternetConnectionChecker().hasConnection;
  if (isConnected) {
    return true;
  } else {
    return false;
  }
}

String checkIconStatus(String status) {
  if (status.contains('process')) {
    return 'assets/images/icon_process.svg';
  } else if (status.contains('pending')){
    return 'assets/images/icon_pending.svg';
  }

  return 'assets/images/icon_completed.svg'; 
}


Color checkIconColorStatus(String status) {
  if (status.contains('process')) {
    return Colors.blue;
  } else if (status.contains('pending')){
    return Colors.yellow;
  }

  return Colors.green; 
}