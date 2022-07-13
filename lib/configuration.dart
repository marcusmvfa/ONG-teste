import 'package:flutter/material.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';

Color primaryGreen = Color(0xff416d6d);
Color secondaryGreen = Color(0xff16a085);
Color fadedBlack = Colors.black.withAlpha(150);
List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 30,
    offset: Offset(0, 10),
  ),
];

List<Map> categories = [
  {"name": "All", "iconPath": "assets/pets.png", "type": PetTypes.all},
  {"name": "Cats", "iconPath": "assets/cat-icon.png", "type": PetTypes.cats},
  {"name": "Dogs", "iconPath": "assets/dog-icon.png", "type": PetTypes.dogs},
];
