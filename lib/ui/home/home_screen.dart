import 'package:flutter/material.dart';
import 'package:flutter_interview/models/pokemon_list_response.dart';
import 'package:flutter_interview/network/api_service.dart';
import 'package:flutter_interview/repository/pokemon_repistory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PokemonListResponse? pokemonResponse;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    final api = ApiService();
    pokemonResponse = (await PokemonRepository(api: api).getPokemon())!;
    setState(() {
      ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokemon List")),
      body: ListView.builder(
          itemCount: pokemonResponse?.results?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final pokemon = pokemonResponse?.results?[index];
            final name = pokemon?.name?.toUpperCase() ?? "";
            return ListTile(
                leading: null,
                trailing: const Icon(Icons.arrow_right_sharp),
                title: Text(name));
          }),
    );
  }
}
