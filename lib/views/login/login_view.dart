import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/view_models/login_view_model.dart';
import 'package:ong_wa_project/views/home/home_view.dart';
import 'package:ong_wa_project/views/login/components/header_login_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  TextEditingController field = TextEditingController();
  late LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<LoginViewModel>(context, listen: false);
    viewModel.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: viewModel.isLoadindUsers,
          builder: (context, bool model, child) {
            return Center(
              child: model
                  ? const CircularProgressIndicator()
                  : ListView(shrinkWrap: true, children: [
                      const HeaderLoginView(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: customShadow,
                        ),
                        child: ValueListenableBuilder<bool>(
                            valueListenable: viewModel.loginError,
                            builder: (context, bool model, child) {
                              return TextField(
                                autofocus: false,
                                controller: field,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'email@teste.com',
                                  errorText: model ? "E-mail inválido" : null,
                                  // helperStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  border: InputBorder.none,
                                ),
                              );
                            }),
                      ),
                      StatefulBuilder(
                        builder: ((context, setState) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 50,
                              width: 100,
                              padding: const EdgeInsets.only(top: 8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var result = await viewModel.login(field.text);
                                  Future.delayed(const Duration(milliseconds: 1500), () {
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
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text("Login"),
                              ),
                            ),
                          );
                        }),
                      ),
                    ]),
            );
          }),
    );
  }
}
