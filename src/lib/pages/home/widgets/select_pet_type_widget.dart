import 'package:flutter/material.dart';

import '../../../model/pet_type.dart';
import '../../../utils/constants.dart';
import 'pet_type_widget.dart';

class SelectPetTypeWidget extends StatefulWidget {
  final Function(String?) onCategorySelected;
  const SelectPetTypeWidget({super.key, required this.onCategorySelected});

  @override
  State<SelectPetTypeWidget> createState() => _SelectPetTypeWidgetState();
}

class _SelectPetTypeWidgetState extends State<SelectPetTypeWidget> {

  // Four Pet Categories that are being used for filtration.
  final List<PetType> _petTypes = const [
    PetType(name: 'Dog', icon: kDogIcon),
    PetType(name: 'Cat', icon: kCatIcon),
    PetType(name: 'Bird', icon: kBirdIcon),
    PetType(name: 'Rabbit', icon: kRabbitIcon)
  ];

  PetType? _selectedPetType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _petTypes.length,
          (index) => PetTypeWidget(
            key: ValueKey<String>(_petTypes[index].name),
            petType: _petTypes[index],
            selectedPetType: _selectedPetType,
            onSelected: (petType) {
              setState(() {
                _selectedPetType = petType;
              });
              widget.onCategorySelected(_selectedPetType?.name);
            },
          ),
        ),
      ),
    );
  }
}
