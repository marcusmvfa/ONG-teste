import 'package:ong_wa_project/models/image_model.dart';
import 'package:ong_wa_project/models/measure.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';

class PetModel {
  Measure? weight;
  Measure? height;
  String? id;
  String? name;
  String? bredFor;
  String? breedGroup;
  String? lifeSpan;
  String? temperament;
  String? origin;
  String? referenceImageId;
  ImageModel? image;
  PetTypes? petType;

  PetModel(
      {this.weight,
      this.height,
      this.id,
      this.name,
      this.bredFor,
      this.breedGroup,
      this.lifeSpan,
      this.temperament,
      this.origin,
      this.referenceImageId,
      this.image,
      this.petType});

  PetModel.fromJson(Map<String, dynamic> json) {
    try {
      weight = json['weight'] != null ? new Measure.fromJson(json['weight']) : null;
      height = json['height'] != null ? new Measure.fromJson(json['height']) : null;
      id = json['id'].toString();
      name = json['name'];
      bredFor = json['bred_for'];
      breedGroup = json['breed_group'];
      lifeSpan = json['life_span'];
      temperament = json['temperament'];
      origin = json['origin'];
      referenceImageId = json['reference_image_id'];
      image = json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
    } catch (e) {
      var error = e;
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weight != null) {
      data['weight'] = this.weight!.toJson();
    }
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['bred_for'] = this.bredFor;
    data['breed_group'] = this.breedGroup;
    data['life_span'] = this.lifeSpan;
    data['temperament'] = this.temperament;
    data['origin'] = this.origin;
    data['reference_image_id'] = this.referenceImageId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}
