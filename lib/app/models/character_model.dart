import 'character_location_model.dart';
import 'character_origin_model.dart';

class CharactersResult {
  CharactersResult({this.characters});

  CharactersResult.fromJson(dynamic json) {
    if (json['results'] != null) {
      final List<dynamic> charactersData = json['results'] as List<dynamic>;
      characters = charactersData
          .map((dynamic element) => CharacterModel.fromJson(element))
          .toList();
    }
    next = json['next'] as String ?? '';
  }

  List<CharacterModel> characters = <CharacterModel>[];
  String next;
}

class CharacterModel {
  CharacterModel({
    this.characterID,
    this.image,
    this.origin,
    this.name,
    this.location,
    this.type,
    this.status,
    this.gender,
    this.species,
  });

  CharacterModel.fromJson(dynamic json) {
    characterID = json['id'] as int ?? 0;
    name = json['name'] as String ?? '';
    status = json['status'] as String ?? '';
    species = json['species'] as String ?? '';
    type = json['type'] as String ?? '';
    gender = json['gender'] as String ?? '';
    origin = Origin.fromJson(json['origin']);
    location = Location.fromJson(json['location']);
    image = json['image'] as String ?? '';
  }

  int characterID;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Origin origin;
  Location location;
  String image;
}
