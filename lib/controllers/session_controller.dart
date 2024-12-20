import 'dart:convert';

import 'package:e_pesan_resto/presentation/authentication/auth_state.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends GetxController {
  static final SessionController _instance = SessionController._internal();
  final authState = Get.put(AuthState());

  SessionController._internal();

  factory SessionController() {
    return _instance;
  }
  void initialCondition() async {
    authState.isLoading.value = true;

    getPreference();
    await Future.delayed(Duration(seconds: 2));

    if (session.value.token.isNotEmpty || session.value.token != '') {
      if (session.value.isAdmin) {
        authState.isLoading.value = false;
        Get.offAllNamed('/admin -dashboard');
      } else {
        authState.isLoading.value = false;
        Get.offAllNamed('/user-dashboard');
      }
    }
    authState.isLoading.value = false;
  }

  var session = SessionModel(
    id: 0,
    name: '',
    email: '',
    token: '',
    isAdmin: false,
  ).obs;

  Future<void> setPreference(
    int id,
    String name,
    String email,
    String token,
    bool isAdmin,
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
      'isAdmin': isAdmin.toString()
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
          isAdmin: bool.parse(data['isAdmin']));
      session.value = result;
    }
  }
}

class SessionModel {
  final int id;
  final String name;
  final String email;
  final String token;
  final bool isAdmin;

  SessionModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.token,
      required this.isAdmin});
}
