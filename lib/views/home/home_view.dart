import 'package:flutter/material.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/views/home/components/header_home_view.dart';
import 'package:ong_wa_project/views/home/components/pet_categories.dart';
import 'package:ong_wa_project/views/home/components/pet_category_display.dart';
import 'package:ong_wa_project/views/home/components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: ListView(
              shrinkWrap: true,
              children: [
                HeaderHomeView(),
                const SizedBox(
                  height: 20,
                ),
                SearchBar(),
                const SizedBox(
                  height: 20,
                ),
                PetCategories(),
                PetCategoryDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
