import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends GetxController {
  static final SessionController _instance = SessionController._internal();

  SessionController._internal();

  factory SessionController() {
    return _instance;
  }

  var session = SessionModel(
    id: 0,
    name: '',
    email: '',
    token: '',
  ).obs;

  Future<void> setPreference(
    int id, 
    String name,
    String email,
    String token
  ) async {
    final accountSession = await SharedPreferences.getInstance();
    if (accountSession.containsKey('session')) {
      accountSession.clear();
    }

    final data = json.encode({
      'id': id.toString(),
      'name': name.toString(),
      'email': email.toString(),
      'token': token.toString(),
    });

    accountSession.setString('session', data);
  }

  Future<void> getPreference() async {
    final accountSession = await SharedPreferences.getInstance();
    if (accountSession.containsKey('session')) {
      final data = json.decode(
        accountSession.getString('session').toString(),
      ) as Map<String, dynamic>;
      var result = SessionModel(
        id: int.parse(
          data['id'],
        ),
        name: data['name'],
        email: data['email'],
        token: data['token'],
      );
      session.value = result;
    }
  }
}

class SessionModel {
  final int id;
  final String name;
  final String email;
  final String token;

  SessionModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });
}
