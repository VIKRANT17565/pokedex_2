import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_2/model/pokemon_evolution.dart';

class EvolutionProvider with ChangeNotifier {
  Map<String, dynamic> pokemonEvolution = {};

  Future<void> getEvolution(String evolutionUrl) async {
    // var url = Uri.parse('https://pokeapi.co/api/v2/evolution-chain/$evolID');

    print('Url : $evolutionUrl');
    
    var url = Uri.parse('$evolutionUrl');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body.toString());

      // return PokemonJsonData.fromJson(jsonData1);
      if (!pokemonEvolution.containsKey(evolutionUrl)) {
        pokemonEvolution.addAll({evolutionUrl: PokemonEvolution.fromJson(jsonData)});
      }
    }
    notifyListeners();
  }
}
