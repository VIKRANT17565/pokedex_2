import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:pokedex_2/model/pokemon_about_json.dart' as about;
import 'package:http/http.dart' as http;

class PokemonAboutProvider with ChangeNotifier {
  Map<int, dynamic> pokemonAboutJson = {};

  Future<void> getDataAbout(id) async {
    String aboutUrl = 'https://pokeapi.co/api/v2/pokemon-species/$id';
    var url2 = Uri.parse(aboutUrl);

    var response2 = await http.get(url2);

    if (response2.statusCode == 200) {
      Map<String, dynamic> jsonData2 = jsonDecode(response2.body.toString());

      pokemonAboutJson.addAll({id: about.PokemonAboutJson.fromJson(jsonData2)});
    }

    notifyListeners();
  }
}
