import '../../model/pet.dart';
import 'pet_storage_repo.dart';
import 'pet_repo.dart';

class PetAppRepo implements PetRepo {
  final _petStorageRepo = PetStorageRepo();

  @override
  Future<List<Pet>> fetchPets() {
    return _petStorageRepo.fetchPets();
  }

  @override
  Future<List<Pet>> fetchAdoptedPets() {
    return _petStorageRepo.fetchAdoptedPets();
  }

  @override
  Future<Pet> adoptPet(Pet pet) {
    return _petStorageRepo.adoptPet(pet);
  }
}
