import 'package:flutter/material.dart';
import 'package:pet_adoption/common/not_found_widget.dart';
import 'package:pet_adoption/utils/color_utils.dart';
import 'package:pet_adoption/pages/history/widgets/adopted_pet_tile.dart';

import '../../common/hollow_circle_widget.dart';
import '../../common/timeline_widget.dart';
import '../../model/pet.dart';

// History page shows the list of adopted pets in a timeline format.
class HistoryPage extends StatelessWidget {
  final List<Pet> adoptedPets;
  const HistoryPage({super.key, required this.adoptedPets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption History'),
      ),
      body: adoptedPets.isNotEmpty
          ? TimelineWidget(
              itemGap: 20,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
              indicators: List.generate(
                adoptedPets.length,
                (index) =>
                    const HollowCircleWidget(strokeColor: kBottomAppBarColor),
              ),
              children: List.generate(
                adoptedPets.length,
                (index) => AdoptedPetTile(pet: adoptedPets[index]),
              ),
            )
          : const NotFoundWidget(message: 'No Pets Adopted Yet.'),
    );
  }
}
