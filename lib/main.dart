import 'package:flutter/material.dart';
import 'package:pokedex_2/provider/base_stats_provider.dart';
import 'package:pokedex_2/provider/evolution_provider.dart';
import 'package:pokedex_2/provider/pokemon_about_provider.dart';
/*------------------------------------------------------------------------------*/
import 'package:pokedex_2/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Multi means you can have more providers if you need
      providers: [
        ChangeNotifierProvider(
          create: (context) => BaseStatsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonAboutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EvolutionProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'PokeDex App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
