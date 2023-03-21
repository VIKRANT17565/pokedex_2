import 'package:flutter/material.dart';

import 'package:pokedex_2/data/pokemon_data.dart' as data;
import 'package:pokedex_2/screen/pokemon_details_screen.dart';
import 'package:pokedex_2/widget/card_pokemon.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pokemonDataTemp = data.pokemonData;
  List<Map<String, dynamic>> pokemonData = [];

  bool showFullList = true;

  bool showSearchInput = false;
  final searchTextController = TextEditingController();

  void updatePokemonList(String x) {
    pokemonData.clear();

    for (var i = 0; i < pokemonDataTemp.length; i++) {
      String name = pokemonDataTemp[i]['name']['english'];
      name = name.toLowerCase();
      x = x.trim();
      x = x.toLowerCase();

      if (name.contains(x)) {
        setState(() {
          pokemonData.add(pokemonDataTemp[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    showFullList ? pokemonData = pokemonDataTemp.map((e) => e).toList() : () {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          showSearchInput
              ? Container(
                  width: 210,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 9, 35, 56),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchTextController,
                    onChanged: (value) {
                      setState(() {
                        updatePokemonList(value);
                      });
                      // print('************************* : $value');
                    },
                    autofocus: true,
                  ),
                )
              : Container(),
          Container(
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 27,
              ),
              onPressed: () {
                setState(() {
                  if (!showSearchInput) {}
                  showSearchInput = !showSearchInput;
                  showFullList = !showFullList;
                  // else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         content: Text(searchTextController.text),
                  //       );
                  //     },
                  //   );
                  // }
                });
              },
            ),
          ),
        ],
      ),
      body: pokemonData.length != 0
          ? GridView.builder(
              itemCount: pokemonData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                // print('index: $index');
                String name = pokemonData[index]['name']['english'];
                int id = pokemonData[index]['id'];
                List<String> type = pokemonData[index]['type'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailsScreen(
                          id: id,
                          type: type,
                          name: name,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: CardPokemon(
                      name: name,
                      id: id,
                      type: type,
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "Data not found!",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
    );
  }
}
