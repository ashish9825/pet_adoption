import 'package:flutter/material.dart';
import 'package:pet_adoption/utils/color_utils.dart';

void showSnackbarError(
    {required String message,
    required BuildContext scaffoldContext,
    int duration = 3,
    bool isFloating = true}) {
  final snackBar = SnackBar(
    content: SizedBox(
      child: Row(children: [
        Container(
          color: Colors.white.withOpacity(0.2),
          padding: const EdgeInsets.all(16.0),
          child: const Icon(Icons.cancel_rounded, color: Colors.white),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            message,
            softWrap: true,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
      ]),
    ),
    padding: EdgeInsets.zero,
    backgroundColor: kSnackbarErrorColor,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(isFloating ? 4.0 : 0.0))),
    behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    duration: Duration(seconds: duration),
  );

  ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
}
