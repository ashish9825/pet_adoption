import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/fetch/pets_fetch_bloc.dart';
import 'package:pet_adoption/common/not_found_widget.dart';
import 'package:pet_adoption/pages/history/history_page.dart';
import 'package:pet_adoption/pages/home/widgets/search_text_field.dart';
import 'package:pet_adoption/pages/home/widgets/pet_tile.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../model/pet.dart';
import 'widgets/select_pet_type_widget.dart';
import 'widgets/theme_switch_button.dart';

// First page of the application which displays the pets that are available to adopt
// and along with it giving the functionalities of searching and filtration.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode focusNode = FocusNode();

  // Variable to store the selected pet category
  String? _selectedPetCategory;

  // Variable to hold the search query text
  String? _query;

  @override
  void initState() {
    // Adding an pets fetching event to fetch the available and adopted pets.
    BlocProvider.of<PetsFetchBloc>(context)
        .add(const PetsInitialFetchingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Hi, Arthur"), actions: const [
          // Opens up the AdoptionHistory Page
          _HistoryButton(),
          // Toggles the theme
          ThemeSwitchButton(),
        ]),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SearchTextfield(onChanged: (value) {
                  _query = value;
                  // Updating the results based on the search query
                  BlocProvider.of<PetsFetchBloc>(context).add(PetsFetchingEvent(
                      query: value, category: _selectedPetCategory));
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  'Select Pet',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: SelectPetTypeWidget(
                    onCategorySelected: (category) {
                      _selectedPetCategory = category;

                      // Updating the results based on the pet category selected.
                      BlocProvider.of<PetsFetchBloc>(context).add(
                          PetsFetchingEvent(query: _query, category: category));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              // Rendering the all the available pets using and also greying out the
              // pets that've already adopted.
              BlocBuilder<PetsFetchBloc, PetsFetchState>(
                builder: (context, state) {
                  if (state is PetsFetchedState) {
                    var pets = state.pets;
                    return Flexible(
                      child: pets.isNotEmpty ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: pets.length,
                        itemBuilder: (context, index) => PetTile(
                          key: ValueKey<int>(index),
                          pet: pets[index],
                          isAdopted: _isAdopted(pets[index], state.adoptedPets),
                        ),
                      ) : const SingleChildScrollView(child: NotFoundWidget(message: 'No Pets Found.')),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isAdopted(Pet pet, List<Pet> adoptedPets) {
    var adoptedPet =
        adoptedPets.singleWhereOrNull((adoptedPet) => adoptedPet.id == pet.id);
    return adoptedPet != null ? true : false;
  }
}

class _HistoryButton extends StatelessWidget {
  const _HistoryButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetsFetchBloc, PetsFetchState>(
        builder: (context, state) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (widget, animation) =>
            ScaleTransition(scale: animation, child: widget),
        child: state is PetsFetchedState
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoryPage(adoptedPets: state.adoptedPets),
                    ),
                  );
                },
                icon: const Icon(Icons.history_toggle_off),
              )
            : const SizedBox.shrink(),
      );
    });
  }
}
