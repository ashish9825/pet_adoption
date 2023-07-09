part of 'pets_fetch_bloc.dart';

abstract class PetsFetchEvent extends Equatable {
  const PetsFetchEvent();
}

class PetsInitialFetchingEvent extends PetsFetchEvent {
  const PetsInitialFetchingEvent();

  @override
  List<Object?> get props => [];
}

class PetsFetchingEvent extends PetsFetchEvent {
  final String? query;
  final String? category;
  const PetsFetchingEvent({this.query, this.category});

  @override
  List<Object?> get props => [query, category];
}
