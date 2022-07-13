import 'package:flutter/material.dart';
import 'package:ong_wa_project/firebase_options.dart';
import 'package:ong_wa_project/view_models/login_view_model.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';
import 'package:ong_wa_project/views/home/home_view.dart';
import 'package:ong_wa_project/views/login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_models/profile_view_model.dart';

void main() async {
  bool islogged = false;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferences.getInstance().then((vaslue) {
    islogged = vaslue.getString("user") != null;
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => PetViewModel()),
      ],
      child: MyApp(islogged),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.islogged, {Key? key}) : super(key: key);
  final bool islogged;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ONG Wa Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      home: islogged ? HomeScreen() : LoginView(),
    );
  }
}
