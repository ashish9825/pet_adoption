part of 'pets_fetch_bloc.dart';

abstract class PetsFetchState extends Equatable {
  const PetsFetchState();
}

class PetsFetchInitState extends PetsFetchState {
  const PetsFetchInitState();

  @override
  List<Object?> get props => [];
}

class PetsFetchingState extends PetsFetchState {
  const PetsFetchingState();

  @override
  List<Object?> get props => [];
}

class PetsFetchedState extends PetsFetchState {
  final List<Pet> pets;
  final List<Pet> adoptedPets;
  const PetsFetchedState({required this.pets, required this.adoptedPets});

  @override
  List<Object?> get props => [pets];
}

class PetsFetchFailedState extends PetsFetchState {
  final String error;
  const PetsFetchFailedState({required this.error});

  @override
  List<Object?> get props => [error];
}
