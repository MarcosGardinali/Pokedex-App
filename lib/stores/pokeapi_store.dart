// ignore_for_file: unused_catch_stack, library_private_types_in_public_api, avoid_print, prefer_interpolation_to_compose_strings, unused_field

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pokedexkanto/consts/consts_api.dart';
import '../consts/consts_app.dart';
import '../models/pokeapi.dart';
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi? _pokeApi;

   @observable
  Pokemon? _pokemonAtual;

  @observable
  dynamic corPokemon;

  @observable
  int? posicaoAtual;


  @computed
  PokeApi? get pokeApi => _pokeApi;


    @computed
  Pokemon? get pokemonAtual => _pokemonAtual;

  @action
  fetchPokemonList() {
    _pokeApi = null;
    loadPokeApi().then((pokeList) {
      _pokeApi = pokeList;
    });
  }

  
  Pokemon? getPokemon(int index) {
    return _pokeApi?.pokemon?[index];
  }

   @action
  setPokemonAtual({int? index}) {
    _pokemonAtual = _pokeApi?.pokemon?[index!];
    corPokemon = ConstsApp.getColorType(type: _pokemonAtual!.type?[0]);
    posicaoAtual = index;
  }





  @action
  Widget getImage({String? numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/Pokemon.json/master/images/$numero.png',
    );
  }
 

  Future<PokeApi?> loadPokeApi() async {
    try {
      final response = await http.get(Uri.parse(Apiconsts.allPokemonsURL));
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
