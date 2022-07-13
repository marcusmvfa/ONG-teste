import 'package:flutter/material.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  TextEditingController field = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<PetViewModel>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: customShadow,
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          Expanded(
            child: TextField(
              autofocus: false,
              controller: field,
              onEditingComplete: () => viewModel.searchPet(field.text),
              decoration: const InputDecoration(
                hintText: 'Procure por seu pet',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
