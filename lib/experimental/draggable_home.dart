import 'dart:convert';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_2/data/pokemon_data.dart' as data;
// import 'package:http/http.dart' as http;
import 'package:pokedex_2/screen/pokemon_details_screen.dart';
/*------------------------------------------------------------------------------*/
import 'package:pokedex_2/widget/card_pokemon.dart';
import 'package:pokedex_2/widget/pokemon_tab_controller.dart';

class MyDraggableHome extends StatelessWidget {
  MyDraggableHome({super.key});

  List<Map<String, dynamic>> pokemonData = data.pokemonData;

  Color colr = Color.fromARGB(255, 205, 255, 180);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      curvedBodyRadius: 0,
      title: Container(
        width: double.infinity,
        child: const Text(
          'Pokedex',
          style: TextStyle(fontSize: 17, color: Color.fromARGB(139, 0, 0, 0)),
        ),
      ),
      headerWidget: headerWidget(context, colr),
      headerExpandedHeight: 0.3,
      backgroundColor: colr,
      appBarColor: colr,
      body: [
        GridView.builder(
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.pokemonData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
          ),
        )
      ],
    );
  }

  Widget headerWidget(BuildContext context, Color colr) {
    return Container(
      color: colr,
      child: Center(
        child: Text(
          "Pokemons",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}











/*

 */