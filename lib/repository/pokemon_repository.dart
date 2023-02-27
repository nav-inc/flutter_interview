import 'package:interview_project/models/pokemon_list_response.dart';
import 'package:interview_project/network/api_service.dart';

class PokemonRepository {
  PokemonRepository({required this.api});
  ApiService api;

  Future<PokemonListResponse?> getPokemon() async {
    try {
      final response = await api.get<void>('${api.baseAPI}/pokemon');
      final pokemonResponse =
          PokemonListResponse.fromJson(response.data as Map<String, dynamic>);
      return pokemonResponse;
    } catch (e) {
      return null;
    }
  }
}
