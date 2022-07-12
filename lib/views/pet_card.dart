import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ong_wa_project/configuration.dart';
import 'package:ong_wa_project/models/image_model.dart';
import 'package:ong_wa_project/views/details.dart';

class PetCard extends StatelessWidget {
  String? petId = '';
  String? petName = '';
  String? breed = '';
  String? age = '';
  String? distance = '';
  String? gender = '';
  ImageModel? imagePath;

  PetCard({
    this.petId,
    this.petName,
    this.breed,
    this.age,
    this.distance,
    this.gender,
    this.imagePath,
  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final randomColor = colors[_random.nextInt(colors.length)];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: petId,
                color: randomColor,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: customShadow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        // height: 150,
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  // color: randomColor,
                  boxShadow: customShadow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                    child: Hero(
                      tag: petId!,
                      child: imagePath!.url != null
                          ? Image.network(
                              imagePath!.url!,
                              fit: BoxFit.fill,
                              errorBuilder: (context, obj, stack) {
                                print(obj);
                                return Container();
                              },
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(children: [
                      Text(
                        petName!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Text(
                      breed!,
                      style: TextStyle(
                        fontSize: 12,
                        color: fadedBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      age! + ' years',
                      style: TextStyle(
                        fontSize: 12,
                        color: fadedBlack,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 16,
                          color: primaryGreen,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   'Distance: ' + distance! + ' Km',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: fadedBlack,
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
