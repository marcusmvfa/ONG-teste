import 'package:dio/dio.dart';
import 'package:ong_wa_project/models/constants.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';

class PetService {
  PetService(this.dio);
  Dio dio;

  Future searchPet({String query = ""}) async {
    return await dio.get(Constants.searchPet, queryParameters: {'q': query});
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

  Future getPetImage(String imageId) async {
    return await dio.get(Constants.imagePet + imageId);
  }
}
