import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/pet.dart';
import '../../utils/response_converter.dart';

class PetStorageRepo {
  final Logger log = Logger("PetStorageRepo");

  // This function loads the Json from local json file that contains the pets information.
  Future<List<Pet>> fetchPets() async {
    try {
      var response = await rootBundle.loadString("assets/files/pets.json");

      return ResponseConverter.fromPayload<Pet>(
          jsonDecode(response), true, Pet.fromJson);
    } on Exception catch (e) {
      log.severe(e);
    }
    throw Exception('Unable to fetch the pets');
  }

  // This function fetches the adopted pets list from shared preferences.
  Future<List<Pet>> fetchAdoptedPets() async {
    final sharedPref = await SharedPreferences.getInstance();
    var petsResponse = jsonDecode(sharedPref.getString("adopted_pets") ?? '[]');
    return ResponseConverter.fromRoot<Pet>(petsResponse, true, Pet.fromJson);
  }

  // This function adds the pet to adopted list of pets in shared preferences.
  Future<Pet> adoptPet(Pet pet) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      var adoptedPets =
          (jsonDecode(sharedPref.getString("adopted_pets") ?? '[]')
                  as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList();
      var petJson = pet.toJson();
      petJson['adopted_at'] = DateTime.now().toIso8601String();
      adoptedPets.add(petJson);
      sharedPref.setString("adopted_pets", jsonEncode(adoptedPets));
      return Pet.fromJson(petJson);
    } on Exception catch (e) {
      log.severe(e);
    }
    throw Exception('Unable to adopt the ${pet.name}');
  }
}
