import 'package:flutter/material.dart';

// Widget to display the different attributes of a pet.
class PetAttributeWidget extends StatelessWidget {
  final String attributeName;
  final String attributeValue;
  const PetAttributeWidget(
      {super.key, required this.attributeName, required this.attributeValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(attributeName, style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 4.0),
          Text(attributeValue, style: Theme.of(context).textTheme.headline5)
        ],
      ),
    );
  }
}
