import 'package:flutter/material.dart';
import 'package:rickAndMorty/app/models/character_model.dart';
import 'package:rickAndMorty/app/repository/charaters_repository.dart';
import 'package:rickAndMorty/network_module/api_response.dart';

class CharactersProvider extends ChangeNotifier {
  CharactersProvider() {
    _characterRepository = CharacterRepository();
  }

  CharacterRepository _characterRepository;
  ApiResponse<List<CharacterModel>> _charactersResponse;
  ApiResponse<List<CharacterModel>> get charactersResponse => _charactersResponse;
  List<CharacterModel> _characterResult = <CharacterModel>[];
  List<CharacterModel> get characterResult => _characterResult;

  Future<String> fetchCharacters(int pageKey) async {
    try {
      _characterResult = await _characterRepository.fetchCharacters(pageKey);
      _charactersResponse =
          ApiResponse<List<CharacterModel>>.completed(_characterResult);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
