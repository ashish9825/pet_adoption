import 'package:flutter/material.dart';
import 'package:pet_adoption/utils/color_utils.dart';

import '../../../model/pet_type.dart';

// A widget to display the pet categories on the home page
// that is used for filtration. It tells tha parent widget that is HomePage
// a particular pet category has been selected and then HomePage renders the
// list accordingly.
class PetTypeWidget extends StatelessWidget {
  final PetType petType;
  final PetType? selectedPetType;
  final Function(PetType?) onSelected;
  const PetTypeWidget(
      {super.key,
      required this.petType,
      required this.selectedPetType,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          if (selectedPetType?.name != petType.name) {
            onSelected(petType);
          } else {
            onSelected(null);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: selectedPetType?.name != petType.name
                    ? Theme.of(context).colorScheme.secondary
                    : kBottomAppBarColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset(petType.icon,
                  color: Theme.of(context).iconTheme.color, width: 48),
            ),
            const SizedBox(height: 4),
            Text(petType.name)
          ],
        ),
      ),
    );
  }
}
