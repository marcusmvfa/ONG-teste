import 'package:flutter/material.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';
import 'package:provider/provider.dart';

class PetCategories extends StatefulWidget {
  PetCategories({Key? key}) : super(key: key);

  @override
  _PetCategoriesState createState() => _PetCategoriesState();
}

class _PetCategoriesState extends State<PetCategories> {
  int selectedCategory = 0;
  late PetViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PetViewModel>(context, listen: false);
    return Container(
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                      viewModel.petTypeSelected.value = categories[index]['type'];
                      if (categories[index]['type'] != PetTypes.all) viewModel.getPetList();
                    });
                  },
                  child: Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: customShadow,
                        border: selectedCategory == index
                            ? Border.all(
                                color: secondaryGreen,
                                width: 2,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        color: Colors.purple,
                      )
                      // Image.asset(
                      //   categories[index]['iconPath'],
                      //   scale: 1.8,
                      // ),
                      ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  categories[index]['name'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
