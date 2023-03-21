import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'package:pokedex_2/data/pokemon_data.dart' as data;
import 'package:pokedex_2/data/pokemon_data.dart';
import 'package:pokedex_2/widget/pokemon_tab_controller.dart';

class PokemonDetailsScreen extends StatefulWidget {
  int id;
  List<String> type;
  String name;
  int index;

  PokemonDetailsScreen(
      {super.key,
      required this.id,
      required this.type,
      required this.name,
      required this.index});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> base =
        data.pokemonData[widget.index]['base'] as Map<String, int>;

    // Color typeBGColor = data.colorCode[widget.type[0]];

    String imageUrlGenerate(int pokemonId) {
      return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemonId}.png';
    }

    String pokemonImageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.id}.png';

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    Widget _buildListItem(BuildContext context, int id) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          // color: Colors.red,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, deviceHeight * 0.01, deviceWidth * 0.03, 0),
              child: Text(
                '#${(id + 1).toString().padLeft(3, '0')}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(135, 0, 0, 0),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(17),
              height: deviceHeight * 0.3,
              width: deviceWidth * 0.95,
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) {
                  return Container(
                    // child: CircularProgressIndicator(),
                  );
                },
                imageUrl: imageUrlGenerate(
                  data.pokemonData[id]['id'] as int,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Container(
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              height: deviceHeight * 0.35,
              width: deviceWidth * 0.95,
              child: ScrollSnapList(
                initialIndex: widget.id * 1.0 - 1,
                itemBuilder: _buildListItem,
                itemCount: data.pokemonData.length,
                itemSize: (deviceWidth * 0.95),
                dynamicItemSize: true,
                scrollPhysics: const PageScrollPhysics(),
                updateOnScroll: true,
                onItemFocus: (id) {
                  print(id);
                  setState(() {
                    widget.id = id + 1;
                    Map<String, String> names = data.pokemonData[widget.id - 1]
                        ['name'] as Map<String, String>;
                    widget.name = names['english']!;

                    widget.type =
                        data.pokemonData[widget.id - 1]['type'] as List<String>;
                    widget.index = id;
                  });
                },
              ),
            ),
            Container(
              height: deviceHeight * 0.06,
              width: double.infinity,
              child: Center(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.type.length < 2
                    ? [
                        Container(
                          height: deviceHeight * 0.037,
                          width: deviceWidth * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: colorCode[widget.type[0]],
                          ),
                          child: Center(
                            child: Text(
                              widget.type[0],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]
                    : [
                        Container(
                          height: deviceHeight * 0.037,
                          width: deviceWidth * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: colorCode[widget.type[0]],
                          ),
                          child: Center(
                            child: Text(
                              widget.type[0],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: deviceHeight * 0.037,
                          width: deviceWidth * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: colorCode[widget.type[1]],
                          ),
                          child: Center(
                            child: Text(
                              widget.type[1],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
            ),

            Container(
              height: deviceHeight * 0.43,
              // color: Colors.red,
              child: PokemonTabController(
                id: widget.id,
                type: widget.type[0],
                name: widget.name,
                index: widget.index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
