import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:pet_adoption/utils/color_utils.dart';
import 'package:pet_adoption/utils/date_utils.dart';
import 'package:pet_adoption/utils/rupee_formatter.dart';

import '../../../model/pet.dart';

// A widget to render the details of adopted pet on HistoryPage.
class AdoptedPetTile extends StatelessWidget {
  final Pet pet;
  const AdoptedPetTile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(_extractAdoptionTime(pet.adoptedAt!),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: kBottomAppBarColor)),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl: pet.image,
                  height: 72,
                  width: 72,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pet.name,
                        style: Theme.of(context).textTheme.headline4),
                    Text(pet.breed,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: kSecondaryTextColor)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pet.price.inRupeesFormat(),
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Text('${pet.ageInYears} years',
                              style: Theme.of(context).textTheme.subtitle2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _extractAdoptionTime(DateTime dateTime) {
    if (dateTime.isYesterday) {
      return 'Yesterday | ${DateFormat('h:mm a').format(dateTime)}';
    } else if (dateTime.isToday) {
      return 'Today | ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return DateFormat('dd-MMM-yyyy | h:mm a').format(dateTime);
    }
  }
}
