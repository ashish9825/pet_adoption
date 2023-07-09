import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../model/pet.dart';
import '../../../utils/color_utils.dart';

// Dialog to inform the user about the successful adoption.
class AdoptSuccessDialog extends StatefulWidget {
  final Pet pet;
  final ConfettiController confettiController;
  const AdoptSuccessDialog(
      {super.key, required this.pet, required this.confettiController});

  @override
  State<AdoptSuccessDialog> createState() => _AdoptSuccessDialogState();
}

class _AdoptSuccessDialogState extends State<AdoptSuccessDialog> {
  @override
  void initState() {
    widget.confettiController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ConfettiWidget(
                    confettiController: widget.confettiController,
                    blastDirection: -pi / 2,
                    emissionFrequency: 0.01,
                    numberOfParticles: 20,
                    maxBlastForce: 100,
                    minBlastForce: 80,
                    gravity: 0.3,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/fireworks.png', width: 64),
                      const SizedBox(height: 16),
                      Text('You’ve now adopted ${widget.pet.name}',
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 16),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Okay',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: kPrimaryLightColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
