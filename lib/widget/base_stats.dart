import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_2/provider/base_stats_provider.dart';

class BaseStats extends StatelessWidget {
  final int id;

  const BaseStats({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double statsBarWidth = deviceWidth * 0.5;
    double statsBarHeight = deviceHeight * 0.015;

    return Consumer<BaseStatsProvider>(
      builder: (context, snapShot, child) {
        // if (!snapShot.pokeJsonData.containsKey(id - 1) ||
        //     !snapShot.pokeJsonData.containsKey(id) ||
        //     !snapShot.pokeJsonData.containsKey(id + 1)) {
        //   snapShot.getDataBaseStats(id - 1);
        //   snapShot.getDataBaseStats(id);
        //   snapShot.getDataBaseStats(id + 1);
        // }

        if (snapShot.pokeJsonData.containsKey(id)) {
          List stats = snapShot.pokeJsonData[id].stats;

          double pokeHeight = snapShot.pokeJsonData[id].height / 10;
          double pokeWeight = snapShot.pokeJsonData[id].weight / 10;

          int total = 0;
          for (var i = 0; i < stats.length; i++) {
            total += stats[i]!.baseStat! as int;
          }

          if (stats.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                  ),

                  Container(
                    padding: EdgeInsets.all(25),
                    // width: deviceWidth*0.87,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          
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
                              children: [
                                Text(
                                  "$pokeHeight m",
                                  style:const TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  "$pokeWeight kgs",
                                  style: const TextStyle(
                                    color: Color.fromARGB(147, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
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
