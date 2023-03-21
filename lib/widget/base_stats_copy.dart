import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pokedex_2/model/pokemon_json_data.dart';
import 'package:pokedex_2/provider/base_stats_provider.dart';
import 'package:provider/provider.dart';

// import 'package:pokedex/data/pokemon_data.dart' as data;

class BaseStatsCopy extends StatelessWidget {
  final int id;

  BaseStatsCopy({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double statsBarWidth = deviceWidth * 0.5;
    double statsBarHeight = deviceHeight * 0.015;

    // return Center(
    //   child: CircularProgressIndicator(),
    // );

    // ignore: non_constant_identifier_names

    return Consumer<BaseStatsProvider>(
      builder: (context, snapShot, child) {
        if (!snapShot.pokeJsonData.containsKey(id)) {
          snapShot.getDataBaseStats(id);
        }

        // List stats = snapShot.getStats(id);

        if (snapShot.pokeJsonData.containsKey(id)) {
          List stats = snapShot.pokeJsonData[id].stats;

          int total = 0;
          for (var i = 0; i < stats.length; i++) {
            total += stats[i]!.baseStat! as int;
          }

          if (stats.isNotEmpty) {
            return Container(
              height: deviceHeight * 0.377,
              padding: const EdgeInsets.all(17),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("HP"),
                      Text("Attack"),
                      Text("Defense"),
                      Text("Sp. Atk"),
                      Text("Sp. Def"),
                      Text("Speed"),
                      Text('Total')
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${stats[0]!.baseStat!}'),
                      Text('${stats[1]!.baseStat!}'),
                      Text('${stats[2]!.baseStat!}'),
                      Text('${stats[3]!.baseStat!}'),
                      Text('${stats[4]!.baseStat!}'),
                      Text('${stats[5]!.baseStat!}'),
                      Text('$total'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[0]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[1]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[2]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[3]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[4]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: stats[5]!.baseStat! / 1,
                      ),
                      BaseStateValueBar(
                        statsBarHeight: statsBarHeight,
                        statsBarWidth: statsBarWidth,
                        data: total / 6,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        } else {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: Colors.white,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class BaseStateValueBar extends StatelessWidget {
  final double statsBarHeight;
  final double statsBarWidth;
  final double data;
  const BaseStateValueBar(
      {super.key,
      required this.statsBarHeight,
      required this.statsBarWidth,
      required this.data});

  @override
  Widget build(BuildContext context) {
    currentProgressColor(double percent) {
//for $percent
      if (percent >= 100) {
        return Colors.green;
      } else if (percent >= 70) {
        return Colors.yellow;
      } else if (percent >= 50) {
        return Colors.orange;
      } else if (percent >= 30) {
        return Colors.deepOrangeAccent;
      }
      return Colors.red;
    }

    double percentage = (data / statsBarWidth) * 100;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: const Color.fromRGBO(230, 230, 230, 1),
          ),
          height: statsBarHeight,
          width: statsBarWidth,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: currentProgressColor(data),
          ),
          height: statsBarHeight,
          width: data,
        )
      ],
    );
  }
}
