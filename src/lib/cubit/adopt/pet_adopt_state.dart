part of 'pet_adopt_cubit.dart';

abstract class PetAdoptState extends Equatable {
  const PetAdoptState();
}

class PetAdoptInitState extends PetAdoptState {
  const PetAdoptInitState();

  @override
  List<Object?> get props => [];
}

class PetAdoptingState extends PetAdoptState {
  final Pet pet;
  const PetAdoptingState({required this.pet});

  @override
  List<Object?> get props => [pet];
}

class PetAdoptedState extends PetAdoptState {
  final Pet pet;
  const PetAdoptedState({required this.pet});

  @override
  List<Object?> get props => [pet];
}

class PetAdoptFailedState extends PetAdoptState {
  final String error;
  const PetAdoptFailedState({required this.error});

  @override
  List<Object?> get props => [error];
}
