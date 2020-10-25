import 'package:rickAndMorty/app/models/character_model.dart';
import 'package:rickAndMorty/network_module/api_path.dart';
import 'package:rickAndMorty/network_module/http_client.dart';

class CharacterRepository {
  Future<List<CharacterModel>> fetchCharacters(int pageKey) async {
    final Map<String, String> params = <String,String> {
        'page':pageKey.toString(),
    };
    final dynamic response = await HTTPClient.instance
        .fetchData(ApiPathHelper.getValue(ApiPath.characters), params: params);
    print('Characters: $response');
    return CharactersResult.fromJson(response).characters;
  }
}
