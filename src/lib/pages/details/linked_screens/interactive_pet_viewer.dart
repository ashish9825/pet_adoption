import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// An interactive photo viewer to display the pet's photo.
class InteractivePetViewer extends StatelessWidget {
  final String petImage;
  const InteractivePetViewer({super.key, required this.petImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(petImage),
      ),
    );
  }
}
