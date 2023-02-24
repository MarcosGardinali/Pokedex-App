// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings, avoid_print, avoid_returning_null_for_void, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedexkanto/models/specie.dart';
import 'package:http/http.dart' as http;
import '../consts/consts_api.dart';
import '../models/pokeapi.dart';
import '../models/pokeapiv2,.dart';
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {

  @observable
  Specie? specie;

  @observable
  PokeApiV2? pokeApiV2;

  @action
  Future<void> getInfoPokemon(String? nome) async {
     try {
      final response = await http.get(Uri.parse(Apiconsts.pokeapiv2URL+nome!.toLowerCase()));
      var decodeJson = jsonDecode(response.body);
      pokeApiV2 =  PokeApiV2?.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }


  @action
   Future<void> getInfoSpecie(String numPokemon) async {
     try {
      final response = await http.get(Uri.parse(Apiconsts.pokeapiv2EspeciesURL+numPokemon));
      var decodeJson = jsonDecode(response.body);
      var _specie = Specie.fromJson(decodeJson);
      specie = _specie;
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  
}