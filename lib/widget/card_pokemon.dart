import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:pokedex_2/data/pokemon_data.dart' as data;

class CardPokemon extends StatelessWidget {
  final String name;
  final int id;
  final List<String> type;
  const CardPokemon(
      {super.key, required this.name, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    final String pokemonImageUrl_2 =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    Map<String, dynamic> colorCode = data.colorCode;
    Color typeWidgetColor = Color.fromARGB(96, 255, 255, 255);

    double currentHeightOfCardWidget = (MediaQuery.of(context).size.width) / 3;
    double currentWidthOfCardWidget = (MediaQuery.of(context).size.width) / 2;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: colorCode[type[0]],
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: currentHeightOfCardWidget * 0.12,
              width: double.infinity,
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.fromLTRB(0, 1, 12, 0),
              child: Text(
                '#${id.toString().padLeft(3, '0')}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(237, 255, 255, 255),
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: currentHeightOfCardWidget * 0.5,
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: type.length < 2
                          ? [
                              Container(
                                height: currentHeightOfCardWidget * 0.2,
                                width: currentWidthOfCardWidget * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: typeWidgetColor,
                                ),
                                child: Center(
                                  child: Text(type[0]),
                                ),
                              ),
                            ]
                          : [
                              Container(
                                height: currentHeightOfCardWidget * 0.2,
                                width: currentWidthOfCardWidget * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: typeWidgetColor,
                                ),
                                child: Center(
                                  child: Text(type[0]),
                                ),
                              ),
                              Container(
                                height: currentHeightOfCardWidget * 0.2,
                                width: currentWidthOfCardWidget * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: typeWidgetColor,
                                ),
                                child: Center(
                                  child: Text(type[1]),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                Container(
                  height: currentHeightOfCardWidget * 0.55,
                  width: currentWidthOfCardWidget * 0.4,
                  // decoration: BoxDecoration(
                  //   color: Colors.red,
                  //   image: DecorationImage(
                  //     fit: BoxFit.contain,
                  //     image: NetworkImage(
                  //       pokemonImageUrl_2,
                  //     ),
                  //   ),
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: pokemonImageUrl_2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
