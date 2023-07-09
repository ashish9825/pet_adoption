import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/bloc/fetch/pets_fetch_bloc.dart';
import 'package:pet_adoption/cubit/adopt/pet_adopt_cubit.dart';
import 'package:pet_adoption/model/pet.dart';
import 'package:pet_adoption/repo/pet/pret_app_repo.dart';

// Test to verify the code written in PetAdoptCubit is working correctly or not.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PetsFetchBloc Test', () {
    late PetsFetchBloc petsFetchBloc;
    late PetAdoptCubit petAdoptCubit;
    PetAppRepo petAppRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      petAppRepo = PetAppRepo();
      petsFetchBloc = PetsFetchBloc(petRepo: petAppRepo);
      petAdoptCubit =
          PetAdoptCubit(petRepo: petAppRepo, petsFetchBloc: petsFetchBloc);
    });

    var petJson = {
      "id": 1,
      "image":
          "https://firebasestorage.googleapis.com/v0/b/roomies-4fd5c.appspot.com/o/Angora%20Rabbit.jpg?alt=media&token=e6b856e8-eecb-4258-a6bb-b27c9f632a3b",
      "name": "Boots",
      "gender": "Male",
      "category": "Rabbit",
      "breed": "Angora Rabbit",
      "price": 5000,
      "currency": "INR",
      "age_in_years": 4,
      "owner": "Ajit Srivastava"
    };
    var petToBeAdopted = Pet.fromJson(petJson);
    petJson['adopted_at'] = DateTime.now().toIso8601String();
    var adoptedPet = Pet.fromJson(petJson);

    blocTest<PetAdoptCubit, PetAdoptState>(
        'emits [PetsAdoptingState, PetAdoptedState]',
        build: () => petAdoptCubit,
        act: (cubit) => cubit.adoptPet(petToBeAdopted),
        expect: () => [
              PetAdoptingState(pet: petToBeAdopted),
              PetAdoptedState(pet: adoptedPet)
            ]);

    tearDown(() {
      petAdoptCubit.close();
    });
  });
}
