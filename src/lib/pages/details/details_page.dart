import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/cubit/adopt/pet_adopt_cubit.dart';
import 'package:pet_adoption/pages/details/linked_screens/interactive_pet_viewer.dart';
import 'package:pet_adoption/pages/details/widgets/adopt_success_dialog.dart';
import 'package:pet_adoption/repo/pet/pet_repo.dart';
import 'package:pet_adoption/utils/color_utils.dart';
import 'package:pet_adoption/utils/rupee_formatter.dart';
import 'package:pet_adoption/utils/snackbar_helper.dart';

import '../../bloc/fetch/pets_fetch_bloc.dart';
import '../../model/pet.dart';
import 'widgets/pet_attribute_widget.dart';

// DetailsPage to display the details of a Pet and also giving the functionality
// of adopting the pet to the user.
class DetailsPage extends StatelessWidget {
  final Pet pet;
  const DetailsPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PetAdoptCubit>(
      create: (context) => PetAdoptCubit(
        petRepo: RepositoryProvider.of<PetRepo>(context),
        petsFetchBloc: BlocProvider.of<PetsFetchBloc>(context),
      ),
      child: _DetailsPageWidget(
        pet: pet,
      ),
    );
  }
}

class _DetailsPageWidget extends StatefulWidget {
  final Pet pet;
  const _DetailsPageWidget({required this.pet});

  @override
  State<_DetailsPageWidget> createState() => __DetailsPageWidgetState();
}

class __DetailsPageWidgetState extends State<_DetailsPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.pet.id,
            child: GestureDetector(
              onTap: () {
                // Opens up the Interactive Viewer to open up the pet photo
                // with Zoom In and Zoom Out functionalities.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InteractivePetViewer(petImage: widget.pet.image),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: widget.pet.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          _PetDetailsWidget(pet: widget.pet)
        ],
      ),
      bottomNavigationBar: _AdoptMeButton(
        pet: widget.pet,
      ),
    );
  }
}

class _PetDetailsWidget extends StatelessWidget {
  final Pet pet;
  const _PetDetailsWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pet.name, style: Theme.of(context).textTheme.headline2),
              Text(pet.breed, style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 12),
              Text(pet.price.inRupeesFormat(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(color: kBottomAppBarColor, fontSize: 28)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PetAttributeWidget(
                    attributeName: 'Age',
                    attributeValue: '${pet.ageInYears} Years',
                  ),
                  PetAttributeWidget(
                    attributeName: 'Gender',
                    attributeValue: pet.gender,
                  ),
                  PetAttributeWidget(
                    attributeName: 'Category',
                    attributeValue: pet.category,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _OwnerTile(ownerName: pet.owner)
            ],
          ),
        ),
      ),
    );
  }
}

// Displays the pet owner's information
class _OwnerTile extends StatelessWidget {
  final String ownerName;
  const _OwnerTile({required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/images/owner.png', width: 64),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ownerName, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 4),
                Text('Owner', style: Theme.of(context).textTheme.bodyText1)
              ],
            )
          ],
        ),
        Text('2.0 km', style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }
}

// AdoptMe Button to adopt the pet
class _AdoptMeButton extends StatefulWidget {
  final Pet pet;
  const _AdoptMeButton({required this.pet});

  @override
  State<_AdoptMeButton> createState() => _AdoptMeButtonState();
}

class _AdoptMeButtonState extends State<_AdoptMeButton>
    with SingleTickerProviderStateMixin {
  bool _adopted = false;

  // Declaring the animationController to animate the Paw Icon on
  // Adopt Me Button.
  late AnimationController animationController;

  //Declaring the animation to perform a CurvedAnimation on the Paw Icon
  late Animation<double> _doubleAnimation;

  // Declaration of confetti controller that will be used to display the confetti
  // after successful adoption.
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _doubleAnimation = Tween<double>(begin: 8, end: 24).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
          child: BlocListener<PetAdoptCubit, PetAdoptState>(
            listener: (context, state) {
              if (state is PetAdoptedState) {

                setState(() {
                  _adopted = true;
                });

                // Shows the dialog after successful adoption.
                showDialog(
                  context: context,
                  builder: (context) => AdoptSuccessDialog(
                    pet: widget.pet,
                    confettiController: _controllerBottomCenter,
                  ),
                );
              }
            },
            child: TextButton(
              onPressed: () {
                if (!_adopted) {
                  BlocProvider.of<PetAdoptCubit>(context).adoptPet(widget.pet);
                } else {
                  showSnackbarError(
                      message: '${widget.pet.name} already adopted.',
                      scaffoldContext: context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Adopt Me',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: kPrimaryLightColor),
                  ),
                  const SizedBox(width: 16),
                  AnimatedBuilder(
                    animation: _doubleAnimation,
                    builder: (context, _) => Image.asset(
                      'assets/images/paw.png',
                      color: kPrimaryLightColor,
                      width: _doubleAnimation.value,
                      height: _doubleAnimation.value,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Disposes the Confetti Controller and AnimationController after DetailsPage gets destroyed.
  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    animationController.dispose();
    super.dispose();
  }
}
