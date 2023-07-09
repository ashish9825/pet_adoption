import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption/bloc/fetch/pets_fetch_bloc.dart';
import 'package:pet_adoption/repo/pet/pet_repo.dart';

import '../../model/pet.dart';

part 'pet_adopt_state.dart';

// Cubit to handle the pet adoption operation.
class PetAdoptCubit extends Cubit<PetAdoptState> {
  final PetRepo petRepo;
  final PetsFetchBloc petsFetchBloc;
  PetAdoptCubit({required this.petRepo, required this.petsFetchBloc})
      : super(const PetAdoptInitState());

  void adoptPet(Pet pet) async {
    try {
      emit(PetAdoptingState(pet: pet));
      var adoptedPet = await petRepo.adoptPet(pet);
      emit(PetAdoptedState(pet: adoptedPet));
      
      // After successful adoption, system notifies the HomePage about the new adoption.
      petsFetchBloc.add(const PetsInitialFetchingEvent());
    } on Exception catch (e) {
      emit(PetAdoptFailedState(error: e.toString()));
    }
  }
}
