import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ong_wa_project/models/api_keys.dart';
import 'package:ong_wa_project/models/category.dart' as Categ;
import 'package:ong_wa_project/models/constants.dart';
import 'package:ong_wa_project/models/image_model.dart';
import 'package:ong_wa_project/models/pet_model.dart';
import 'package:dio/dio.dart';
import 'package:ong_wa_project/services/pet_service.dart';

enum PetTypes { all, dogs, cats }

class PetViewModel extends ChangeNotifier {
  ValueNotifier petTypeSelected = ValueNotifier<PetTypes>(PetTypes.all);
  ValueNotifier<List<PetModel>> dogList = ValueNotifier(<PetModel>[]);
  ValueNotifier<List<PetModel>> catList = ValueNotifier(<PetModel>[]);
  ValueNotifier<List<PetModel>> petList = ValueNotifier(<PetModel>[]);
  List<Categ.Category> categories = [];
  Dio dio = Dio();

  PetViewModel() {
    petTypeSelected.addListener(() {
      getPetURL();
      fillPetSpecificList(petType: petTypeSelected.value);
    });
  }

  fillPetSpecificList({List<PetModel>? list, PetTypes? petType}) {
    print("#### fillPetSpecific: ${petType.toString()}");

    switch (petType) {
      case PetTypes.dogs:
        dogList.value = list ?? dogList.value;
        petList.value = dogList.value;
        break;
      case PetTypes.cats:
        catList.value = list ?? catList.value;
        petList.value = catList.value;
        break;
      case PetTypes.all:
        var pets = <PetModel>[];
        pets.addAll(dogList.value);
        pets.addAll(catList.value);
        // pets.shuffle();
        petList.value = pets;
        break;
      case null:
        // var pets = <PetModel>[];
        // pets.addAll(dogList.value);
        // pets.addAll(catList.value);
        // pets.shuffle();
        // list!.shuffle();
        petList.value = list!;
        break;
    }
  }

  getPetURL() {
    switch (petTypeSelected.value) {
      case PetTypes.dogs:
        dio.options.baseUrl = Constants.dogBaseURL;
        dio.options.headers = {'x-api-key': ApiKeys.dogApi};
        break;
      case PetTypes.cats:
        dio.options.baseUrl = Constants.catBaseURL;
        dio.options.headers = {'x-api-key': ApiKeys.catApi};
        break;
    }
  }

  Future getPetList() async {
    print("#### GetPetList ####");
    await PetService(dio).getPetList().then((response) async {
      var list = <PetModel>[];
      await Future.forEach(response.data, (dynamic element) async {
        var pet = PetModel.fromJson(element);
        pet.petType = petTypeSelected.value;
        list.add(pet);
        // if (petTypeSelected.value == PetTypes.dogs) dogList.value.clear();
        // if (petTypeSelected.value == PetTypes.cats) catList.value.clear();
      }).then((value) => fillPetSpecificList(list: list, petType: petTypeSelected.value));
    });
  }

  Future getAllPets() async {
    print("#### GetAllPets");
    petList.value.clear();
    await PetService(Dio(BaseOptions(headers: {'x-api-key': ApiKeys.dogApi})))
        .getAllPets()
        .then((response) async {
      var list = <PetModel>[];
      await Future.forEach(response, (dynamic element) async {
        await compute(parsePetModel, element['data']).then((value) {
          list.addAll(value);
        });
      });
      petList.value = list;
      petList.value.shuffle();
      // Future.delayed(Duration(seconds: 2), () => fillPetSpecificList(list: list));
    });
  }

  Future getPets() async {
    if (petTypeSelected.value == PetTypes.all) {
      await getAllPets();
    } else {
      await getPetList();
    }
  }

  Future searchPet(String query) async {
    await PetService(dio).searchPet(query: query).then((response) {
      petList.value.clear();
      var list = <PetModel>[];
      response.data.forEach((element) {
        var pet = PetModel.fromJson(element);
        pet.petType = petTypeSelected.value;
        list.add(pet);
        // switch (petTypeSelected.value) {
        //   case PetTypes.dogs:
        //     dogList.value.clear();
        //     dogList.value.add(pet);
        //     break;
        //   case PetTypes.cats:
        //     catList.value.clear();
        //     catList.value.add(pet);
        //     break;
        // }
      });
      petList.value = list;
    });
  }

  Future getPetImage(String? imageId) async {
    if (imageId != null) {
      return await PetService(dio)
          .getPetImage(imageId)
          .then((value) => ImageModel.fromJson(value.data));
    } else {
      return null;
    }
  }
}

parsePetModel(list) {
  return List<PetModel>.from(list.map((e) => PetModel.fromJson(e)).toList());
}
