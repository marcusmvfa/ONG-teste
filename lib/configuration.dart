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
  {"name": "All", "iconPath": "images/cat.png", "type": PetTypes.all},
  {"name": "Cats", "iconPath": "images/cat.png", "type": PetTypes.cats},
  {"name": "Dogs", "iconPath": "images/dog.png", "type": PetTypes.dogs},
];

List<Map> drawerItems = [
  {
    "icon": Icons.house,
    "title": "Adoption",
  },
  {
    "icon": Icons.mark_email_read_outlined,
    "title": "Donation",
  },
  {
    "icon": Icons.add,
    "title": "Add Pet",
  },
  {
    "icon": Icons.favorite,
    "title": "Favourites",
  },
  {
    "icon": Icons.message,
    "title": "Messages",
  },
  {
    "icon": Icons.person,
    "title": "Profile",
  }
];
