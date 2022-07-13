import 'package:dio/dio.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:ong_wa_project/models/constants.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';

class PetService {
  PetService(this.dio);
  Dio dio;

  Future searchPet({String query = "", required PetTypes petType}) async {
    var petsList = [];
    if (petType == PetTypes.all) {
      return Future.wait([
        dio.get(Constants.dogBaseURL + Constants.searchPet, queryParameters: {'q': query}).then(
            (value) {
          petsList.add({'data': value.data, 'type': PetTypes.dogs});
        }),
        dio.get(Constants.catBaseURL + Constants.searchPet, queryParameters: {'q': query}).then(
            (value) {
          petsList.add({'data': value.data, 'type': PetTypes.cats});
        })
      ]).then((value) {
        return petsList;
      });
    } else {
      await dio.get(Constants.searchPet, queryParameters: {'q': query}).then(
        (value) => petsList.add({'data': value.data, 'type': petType}),
      );
      return petsList;
    }
  }

  Future<Response> getPetList() async {
    return await dio.get(Constants.getPetList);
  }

  Future getAllPets() async {
    var petsList = [];
    return Future.wait([
      dio.get(Constants.dogBaseURL + Constants.getPetList).then((value) {
        petsList.add({'data': value.data, 'type': PetTypes.dogs});
      }),
      dio.get(Constants.catBaseURL + Constants.getPetList).then((value) {
        petsList.add({'data': value.data, 'type': PetTypes.cats});
      })
    ]).then((value) {
      return petsList;
    });
  }

  Future getPetImage(String imageId, PetTypes petTypeSelected) async {
    if (petTypeSelected == PetTypes.dogs) {
      return await dio.get(Constants.dogBaseURL + Constants.imagePet + imageId);
    } else if (petTypeSelected == PetTypes.cats) {
      return await dio.get(Constants.catBaseURL + Constants.imagePet + imageId);
    }
    return await dio.get(Constants.imagePet + imageId);
  }
}
