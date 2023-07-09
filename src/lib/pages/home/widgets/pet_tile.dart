import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pet_adoption/pages/details/details_page.dart';
import 'package:pet_adoption/utils/color_utils.dart';
import 'package:pet_adoption/utils/rupee_formatter.dart';

import '../../../model/pet.dart';

// The widget that renders the pet details on home page as a item of a ListView.
class PetTile extends StatefulWidget {
  final Pet pet;
  final bool isAdopted;
  const PetTile({super.key, required this.pet, this.isAdopted = false});

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();

    // It slowly animates the pet tile when rendering on the screen with the use
    // of AnimatedOpacity
    if (_isStart) {
      Future.delayed(Duration(milliseconds: widget.pet.id * 100), () {
        if (mounted) {
          setState(() {
            _animate = true;
            _isStart = false;
          });
        }
      });
    } else {
      _animate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: GestureDetector(
        onTap: () {
          // If pet is not adpoted, then only it redirects the app to details page.
          if (!widget.isAdopted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(pet: widget.pet)));
          }
        },
        child: Opacity(
          opacity: widget.isAdopted ? 0.4 : 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Hero(
                  tag: widget.pet.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.pet.image,
                      height: 128,
                      width: 128,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.pet.name,
                                style: Theme.of(context).textTheme.headline4),
                            if (widget.isAdopted)
                              const Text('• Already Adopted',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.0,
                                      color: kSecondaryTextColor)),
                          ],
                        ),
                        Text(widget.pet.breed,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: kSecondaryTextColor)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.pet.price.inRupeesFormat(),
                                style: Theme.of(context).textTheme.headline3),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Text('${widget.pet.ageInYears} years',
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
