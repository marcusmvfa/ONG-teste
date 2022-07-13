import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var user = {};

  get name => user['name'];
  get email => user['email'];

  ProfileViewModel() {
    getUser();
  }

  getUser() async {
    var pref = await prefs;
    var userString = pref.getString('user');
    if (userString != null) {
      user = jsonDecode(userString);
      notifyListeners();
    }
  }

  Future logout() async {
    var pref = await prefs;
    await pref.remove('user');
  }
}
