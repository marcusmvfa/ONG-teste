import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/view_models/login_view_model.dart';
import 'package:ong_wa_project/views/home/home_view.dart';
import 'package:ong_wa_project/views/login/components/header_login_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  bool isLoading = false;

  LoginView({Key? key}) : super(key: key);
  TextEditingController field = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: viewModel.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ListView(shrinkWrap: true, children: [
                  const HeaderLoginView(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: customShadow,
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: field,
                      decoration: const InputDecoration(
                        hintText: 'email@tesdte.com',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: ((context, setState) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: 100,
                          padding: EdgeInsets.only(top: 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var result = await viewModel.login(field.text);
                              Future.delayed(Duration(milliseconds: 1500), () {
                                if (result) {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Login"),
                          ),
                        ),
                      );
                    }),
                  ),
                ]);
              }
            }),
      ),
    );
  }
}
