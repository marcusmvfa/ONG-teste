import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewModel extends ChangeNotifier {
  late FirebaseFirestore _instance;
  var listUser = [];
  LoginViewModel() {
    _instance = FirebaseFirestore.instance;
  }

  Future getUsers() async {
    await _instance.collection('users').get().then((value) {
      for (var doc in value.docs) {
        listUser.add(doc.data());
        print(doc.data());
      }
    });
  }

  login(String email) {
    for (var user in listUser) {
      if (email == user['email']) {
        return true;
      } else {
        return false;
      }
    }
  }
}
