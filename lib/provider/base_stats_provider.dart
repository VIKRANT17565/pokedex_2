import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_2/model/pokemon_json_data.dart';
import 'package:http/http.dart' as http;

class BaseStatsProvider with ChangeNotifier {
  Map<int, dynamic> pokeJsonData = {};

  Future<void> getDataBaseStats(id) async {
    var url1 = Uri.parse('https://pokeapi.co/api/v2/pokemon/${id}');

    var response1 = await http.get(url1);

    if (response1.statusCode == 200) {
      Map<String, dynamic> jsonData1 = jsonDecode(response1.body.toString());

      // return PokemonJsonData.fromJson(jsonData1);
      if (!pokeJsonData.containsKey(id)) {
        pokeJsonData.addAll({id: PokemonJsonData.fromJson(jsonData1)});
      }
    }

    // return pokeJsonData;
    // print("*******************output*******************");
    // print(pokeJsonData[id].);
    notifyListeners();
  }

}
