// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexkanto/pages/home_page/widgets/home_page.dart';

import 'package:pokedexkanto/stores/pokeapi_store.dart';
import 'package:pokedexkanto/stores/pokeapiv2_store.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeApiStore>(PokeApiStore());
  getIt.registerSingleton<PokeApiV2Store>(PokeApiV2Store());

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex Kanto',
      theme: ThemeData(
        fontFamily: 'pokedex',
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
