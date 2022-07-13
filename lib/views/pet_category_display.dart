import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/models/image_model.dart';
import 'package:ong_wa_project/models/pet_model.dart';
import 'package:ong_wa_project/view_models/pet_view_model.dart';
import 'package:ong_wa_project/views/pet_card.dart';
import 'package:provider/provider.dart';

class PetCategoryDisplay extends StatelessWidget {
  PetCategoryDisplay({Key? key}) : super(key: key);
  ValueNotifier<List<PetModel>> petsList = ValueNotifier([]);
  late PetViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PetViewModel>(context, listen: false);
    return FutureBuilder(
      future: viewModel.getPets(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else {
          return ValueListenableBuilder(
            valueListenable: viewModel.petList,
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount:
                    viewModel.petList.value.length > 20 ? 20 : viewModel.petList.value.length,
                itemBuilder: (context, index) {
                  var pet = viewModel.petList.value[index];
                  if (pet.image != null) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: PetCard(
                        petId: pet.id,
                        petName: pet.name,
                        age: pet.lifeSpan,
                        breed: pet.bredFor ?? "",
                        imagePath: pet.image!,
                        temperament: pet.temperament,
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: FutureBuilder(
                        future: viewModel.getPetImage(pet.referenceImageId ?? null, pet.petType!),
                        builder: (context, snapshot) {
                          ImageModel data =
                              snapshot.data != null ? snapshot.data as ImageModel : ImageModel();
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return LinearProgressIndicator();
                          } else {
                            return PetCard(
                              petId: pet.id,
                              petName: pet.name,
                              age: pet.lifeSpan,
                              breed: pet.bredFor ?? "",
                              imagePath: data,
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
