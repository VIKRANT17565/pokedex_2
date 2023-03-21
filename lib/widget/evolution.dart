import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_2/model/pokemon_evolution.dart';
import 'package:pokedex_2/provider/evolution_provider.dart';
import 'package:pokedex_2/provider/pokemon_about_provider.dart';
import 'package:pokedex_2/widget/card_pokemon.dart';
import 'package:provider/provider.dart';

class Evolution extends StatelessWidget {
  final int evolId;
  final String evolutionUrl;

  const Evolution({
    super.key,
    required this.evolId,
    required this.evolutionUrl,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    // PokemonAboutProvider pokemonAboutProvider =
    //     Provider.of<PokemonAboutProvider>(context);

    // String link = pokemonAboutProvider.pokemonAboutJson[id].evolutionChain.url;

    return Consumer<EvolutionProvider>(
      builder: (context, snapShot, child) {
        if (snapShot.pokemonEvolution.containsKey(evolutionUrl)) {
          PokemonEvolution pokemonEvolution =
              snapShot.pokemonEvolution[evolutionUrl];
          // print('evol id : ${pokemonEvolution.id}');

          if (pokemonEvolution.chain != null) {
            Chain chain = pokemonEvolution.chain as Chain;

            Chain tempMain = chain;

            List<int> evolution = [];

            // String url = chain.species?.url as String;
            // List urlToList = url.split('/');
            // evolution.add(int.parse(urlToList[urlToList.length - 2]));
            // chain = chain.evolvesTo![0];

            // print(evolution);

            while (chain.evolvesTo?.length != 0) {
              String url = chain.species?.url as String;
              List urlToList = url.split('/');
              evolution.add(int.parse(urlToList[urlToList.length - 2]));
              chain = chain.evolvesTo![0];
              // print(int.parse(urlToList[urlToList.length - 2]));
            }

            // int? x = chain.evolvesTo?.length;
            // int currInd = 0;

            // print(tempMain.evolvesTo?.length);

            // if (tempMain.evolvesTo!.length >= 1) {
            //   // evolution = [];
            //   String url = chain.species?.url as String;
            //   List urlToList = url.split('/');
            //   evolution.add(int.parse(urlToList[urlToList.length - 2]));

            //   Chain temp;

            //   List _evolvesTo = chain.evolvesTo!;
            //   for (var i = 1; i < tempMain.evolvesTo!.length; i++) {
            //     temp = tempMain.evolvesTo![i];
            //     print(evolution);

            //     String url = temp.species?.url as String;
            //     List urlToList = url.split('/');
            //     evolution.add(int.parse(urlToList[urlToList.length - 2]));
            //   }
            // }


            String pokemonImageUrl =
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[0]}.png';

            String url = chain.species?.url as String;
            List urlToList = url.split('/');
            evolution.add(int.parse(urlToList[urlToList.length - 2]));

            double evolImageHeight = 80;

            print(evolutionUrl);

            // print(evolution);
            if (evolution.length == 3) {
              return Container(
                padding: const EdgeInsets.all(17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[0]}.png',
                          ),
                        ),
                        Center(
                          child: Container(
                            // color: Colors.red,
                            child: const Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[1]}.png',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[1]}.png',
                          ),
                        ),
                        Center(
                          child: Container(
                            // color: Colors.red,
                            child: const Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[2]}.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (evolution.length == 2) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[0]}.png',
                          ),
                        ),
                        Center(
                          child: Container(
                            // color: Colors.red,
                            child: const Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          height: evolImageHeight,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${evolution[1]}.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
