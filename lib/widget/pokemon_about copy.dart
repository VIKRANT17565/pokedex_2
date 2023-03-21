import 'package:flutter/material.dart';
import 'package:pokedex_2/widget/pokemon_f_b_gif.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_2/model/pokemon_about_json.dart' as about;
import 'package:pokedex_2/provider/pokemon_about_provider.dart';

// import 'package:pokedex/data/pokemon_data.dart' as data;

class PokemonAboutCopy extends StatelessWidget {
  final int id;

  PokemonAboutCopy({
    super.key,
    required this.id,
  });

  late about.PokemonAboutJson pokemonAboutJson;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double pokeGifHeight = 57;

    return Consumer<PokemonAboutProvider>(
      builder: (context, snapShot, child) {
        if (!snapShot.pokemonAboutJson.containsKey(id)) {
          snapShot.getDataAbout(id);
        }

        if (snapShot.pokemonAboutJson.containsKey(id)) {
          about.PokemonAboutJson snapshot = snapShot.pokemonAboutJson[this.id];
          int flavorTextEntriesCount = snapshot.flavorTextEntries!.length;
          String aboutPokemonText1 = '';
          String aboutPokemonText2 = '';

          int id = snapshot.id!;

          List<String> version = [];
          List<about.FlavorTextEntry?>? flavorTextEntries =
              snapshot.flavorTextEntries!;
          // print('--------------------${snapshot.data!.id}');

          if (0 <= id && id < 387) {
            // print("--------------------$id");
            version = ['firered', 'leafgreen'];
          } else if (387 <= id && id < 494) {
            // print(id);
            version = ['pearl', 'heartgold'];
          } else if (494 <= id && id < 650) {
            // print(id);
            version = ['white', 'black'];
          } else if (650 <= id && id < 722) {
            // print(id);
            version = ['x', 'y'];
          } else if (722 <= id && id < 808) {
            // print(id);
            version = ['ultra-moon', 'ultra-sun'];
          } else if (808 <= id && id < 1000) {
            // print(id);
            version = ['shield', 'sword'];
          }

          for (var i = 0; i < flavorTextEntriesCount; i++) {
            if (flavorTextEntries[i]!.language!.name == 'en' &&
                flavorTextEntries[i]!.version!.name == version[0]) {
              aboutPokemonText1 = flavorTextEntries[i]!.flavorText as String;
              // print(aboutPokemonText1);
            }
            if (flavorTextEntries[i]!.language!.name == 'en' &&
                flavorTextEntries[i]!.version!.name == version[1]) {
              aboutPokemonText2 = flavorTextEntries[i]!.flavorText as String;
            }

            if (aboutPokemonText1 != '' && aboutPokemonText2 != '') {
              break;
            }
          }

          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: deviceWidth,
                // color: Colors.red,
                // alignment: Alignment.center,
                // width: deviceWidth,
                // margin: const EdgeInsets.all(25),
                margin: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: aboutPokemonText1 != aboutPokemonText2
                          ? [
                              Text(
                                aboutPokemonText1,
                                style: const TextStyle(
                                    fontSize: 15, wordSpacing: 7),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                aboutPokemonText2,
                                style: const TextStyle(
                                    fontSize: 15, wordSpacing: 7),
                              ),
                            ]
                          : [
                              Text(
                                aboutPokemonText1,
                                style: const TextStyle(
                                    fontSize: 15, wordSpacing: 7),
                              ),
                            ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PokemonFBGif(id: id),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 237, 237, 237),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
