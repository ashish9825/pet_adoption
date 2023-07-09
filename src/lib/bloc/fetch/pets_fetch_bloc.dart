import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/pet.dart';
import '../../repo/pet/pet_repo.dart';

part 'pets_fetch_state.dart';
part 'pets_fetch_event.dart';

class PetsFetchBloc extends Bloc<PetsFetchEvent, PetsFetchState> {
  final PetRepo petRepo;

  PetsFetchBloc({required this.petRepo}) : super(const PetsFetchInitState()) {
    on<PetsInitialFetchingEvent>(_onPetsInitialFetchingEvent);
    on<PetsFetchingEvent>(_onPetsFetchingEvent);
  }

  // It holds the list of available pets.
  List<Pet> _pets = [];

  // It holds the list of adopted pets.
  List<Pet> _adoptedPets = [];

  // Event that will be fired during the initial rendering of the pets as well
  // as when the new adoption happens.
  void _onPetsInitialFetchingEvent(
      PetsInitialFetchingEvent event, Emitter<PetsFetchState> emit) async {
    emit(const PetsFetchingState());
    try {
      var responses =
          await Future.wait([petRepo.fetchPets(), petRepo.fetchAdoptedPets()]);

      // responses[0] contains the list of available pets and responses[1]
      // contains the list of available pets.
      _pets = responses[0];
      _adoptedPets = responses[1];
      _adoptedPets.sort((a, b) => b.adoptedAt!.compareTo(a.adoptedAt!));
      emit(PetsFetchedState(pets: _pets, adoptedPets: _adoptedPets));
    } on Exception catch (e) {
      emit(PetsFetchFailedState(error: e.toString()));
    }
  }

  // Event that will be fired during the fitration (search and category selection).
  void _onPetsFetchingEvent(
      PetsFetchingEvent event, Emitter<PetsFetchState> emit) async {
    emit(const PetsFetchingState());
    try {
      var pets = _pets
          .where((pet) =>
              pet.name
                  .toLowerCase()
                  .startsWith(event.query?.toLowerCase() ?? '') ||
              pet.breed
                  .toLowerCase()
                  .startsWith(event.query?.toLowerCase() ?? ''))
          .where((pet) =>
              event.category != null ? (pet.category == event.category) : true)
          .toList();
      emit(PetsFetchedState(pets: pets, adoptedPets: _adoptedPets));
    } on Exception catch (e) {
      emit(PetsFetchFailedState(error: e.toString()));
    }
  }
}
