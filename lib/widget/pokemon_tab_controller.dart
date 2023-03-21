import 'package:flutter/material.dart';
import 'package:pokedex_2/provider/base_stats_provider.dart';
import 'package:pokedex_2/provider/evolution_provider.dart';
import 'package:pokedex_2/provider/pokemon_about_provider.dart';

import 'package:pokedex_2/widget/base_stats.dart';
import 'package:pokedex_2/data/pokemon_data.dart' as data;
import 'package:pokedex_2/widget/evolution.dart';
import 'package:pokedex_2/widget/pokemon_about.dart';
import 'package:provider/provider.dart';

class PokemonTabController extends StatelessWidget {
  final int id;
  final String type;
  final String name;
  final int index;

  const PokemonTabController({
    super.key,
    required this.id,
    required this.type,
    required this.name,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, int> base = data.pokemonData[index]['base'] as Map<String, int>;

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    BaseStatsProvider baseStatsProvider =
        Provider.of<BaseStatsProvider>(context);

    if (!baseStatsProvider.pokeJsonData.containsKey(id - 1) ||
        !baseStatsProvider.pokeJsonData.containsKey(id) ||
        !baseStatsProvider.pokeJsonData.containsKey(id + 1)) {
      baseStatsProvider.getDataBaseStats(id - 1);
      baseStatsProvider.getDataBaseStats(id);
      baseStatsProvider.getDataBaseStats(id + 1);
    }

    PokemonAboutProvider pokemonAboutProvider =
        Provider.of<PokemonAboutProvider>(context);

    if (!pokemonAboutProvider.pokemonAboutJson.containsKey(id - 1) ||
        !pokemonAboutProvider.pokemonAboutJson.containsKey(id) ||
        !pokemonAboutProvider.pokemonAboutJson.containsKey(id + 1)) {
      pokemonAboutProvider.getDataAbout(id - 1);
      pokemonAboutProvider.getDataAbout(id);
      pokemonAboutProvider.getDataAbout(id + 1);
    }

    EvolutionProvider evolutionProvider =
        Provider.of<EvolutionProvider>(context);
    int evolutionId = -1;
    String evolutionLink = '';

    if (pokemonAboutProvider.pokemonAboutJson.containsKey(id)) {
      evolutionLink =
          pokemonAboutProvider.pokemonAboutJson[id].evolutionChain.url;

    }

    if (!evolutionProvider.pokemonEvolution.containsKey(evolutionLink) &&
        evolutionLink != '') {
      evolutionProvider.getEvolution(evolutionLink);
    }

    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Colors.white,
        ),
        child: Column(
          children: [
            TabBar(
              tabs: [
                Container(
                  height: deviceHeight * 0.05,
                  child: const Center(
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: deviceHeight * 0.05,
                  child: const Center(
                    child: Text(
                      "Base stats",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 68, 68, 68),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: deviceHeight * 0.05,
                  child: const Center(
                    child: Text(
                      "Evolution",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 68, 68, 68),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PokemonAbout(
                    id: id,
                  ),
                  BaseStats(
                    id: id,
                  ),
                  Evolution(
                    evolId: evolutionId,
                    evolutionUrl: evolutionLink,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
