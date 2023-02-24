

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_field, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexkanto/components/circular_progressabout.dart';

import '../../../models/specie.dart';
import '../../../stores/pokeapi_store.dart';
import '../../../stores/pokeapiv2_store.dart';

class AbaSobre extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Observer(
                      builder: (context) {
                        Specie? _specie = _pokeApiV2Store.specie;
                        return _specie != null ? Text(
                          _specie.flavorTextEntries!.where((item) => item.language.name == 'en').first.flavorText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ): CircularProgressAbout();
                      }
                    ),
                  ],
                ),
              ),
    );
    
  }
}