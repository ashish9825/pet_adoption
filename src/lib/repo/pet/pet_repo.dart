import '../../model/pet.dart';

abstract class PetRepo {
  Future<List<Pet>> fetchPets();
  Future<List<Pet>> fetchAdoptedPets();
  Future<Pet> adoptPet(Pet pet);
}
