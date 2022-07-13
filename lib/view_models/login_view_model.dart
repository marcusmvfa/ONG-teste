import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  late FirebaseFirestore _instance;
  var listUser = [];
  ValueNotifier<bool> loginError = ValueNotifier(false);
  ValueNotifier<bool> isLoadindUsers = ValueNotifier(true);
  var user = {};
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginViewModel() {
    _instance = FirebaseFirestore.instance;
  }

  Future getUsers() async {
    await _instance.collection('users').get().then((value) {
      for (var doc in value.docs) {
        listUser.add(doc.data());
        print(doc.data());
      }
      isLoadindUsers.value = false;
    });
  }

  login(String email) {
    loginError.value = false;
    for (var user in listUser) {
      if (email == user['email']) {
        this.user = user;
        setUser();
        return true;
      } else {
        loginError.value = true;
        return false;
      }
    }
  }

  setUser() async {
    var prefs = await _prefs;
    var encoded = jsonEncode(user);
    await prefs.setString("user", encoded);
  }
}
