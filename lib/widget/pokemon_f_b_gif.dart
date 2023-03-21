import 'package:flutter/material.dart';

class PokemonFBGif extends StatelessWidget {
  final int id;

  const PokemonFBGif({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double pokeGifHeight = 67;

    double pokeballSize = 57;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  height: pokeGifHeight,
                  child: Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/${id}.gif',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png",
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: pokeballSize,
                            width: pokeballSize,
                            child: Image.asset(
                                "assets/images/pokeball_894x894.png"),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Front animated\n",
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: pokeGifHeight,
                  child: Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/${id}.gif',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${id}.png",
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: pokeballSize,
                            width: pokeballSize,
                            child: Image.asset(
                                "assets/images/pokeball_894x894.png"),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Back animated\n",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  height: pokeGifHeight,
                  child: Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/shiny/${id}.gif',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/${id}.png",
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: pokeballSize,
                            width: pokeballSize,
                            child: Image.asset(
                                "assets/images/pokeball_894x894.png"),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Front animated\nshiny",
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: pokeGifHeight,
                  child: Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/shiny/${id}.gif',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/${id}.png",
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: pokeballSize,
                            width: pokeballSize,
                            child: Image.asset(
                                "assets/images/pokeball_894x894.png"),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Back animated\nshiny",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
