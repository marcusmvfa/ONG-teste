import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ong_wa_project/view_models/profile_view_model.dart';
import 'package:ong_wa_project/views/login/login_view.dart';
import 'package:provider/provider.dart';

class HeaderHomeView extends StatelessWidget {
  const HeaderHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileViewModel>(context, listen: true);
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: const CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: AssetImage('assets/waProject.jpg'),
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
                text: 'Bem-vindo, ',
                style:
                    const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: viewModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ]),
          ),
          const Spacer(),
          IconButton(
              onPressed: () async {
                await viewModel.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: ((context) => const LoginView()),
                  ),
                );
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
