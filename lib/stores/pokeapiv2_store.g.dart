// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapiv2_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokeApiV2Store on _PokeApiV2StoreBase, Store {
  late final _$specieAtom =
      Atom(name: '_PokeApiV2StoreBase.specie', context: context);

  @override
  Specie? get specie {
    _$specieAtom.reportRead();
    return super.specie;
  }

  @override
  set specie(Specie? value) {
    _$specieAtom.reportWrite(value, super.specie, () {
      super.specie = value;
    });
  }

  late final _$pokeApiV2Atom =
      Atom(name: '_PokeApiV2StoreBase.pokeApiV2', context: context);

  @override
  PokeApiV2? get pokeApiV2 {
    _$pokeApiV2Atom.reportRead();
    return super.pokeApiV2;
  }

  @override
  set pokeApiV2(PokeApiV2? value) {
    _$pokeApiV2Atom.reportWrite(value, super.pokeApiV2, () {
      super.pokeApiV2 = value;
    });
  }

  late final _$getInfoPokemonAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoPokemon', context: context);

  @override
  Future<void> getInfoPokemon(String? nome) {
    return _$getInfoPokemonAsyncAction.run(() => super.getInfoPokemon(nome));
  }

  late final _$getInfoSpecieAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoSpecie', context: context);

  @override
  Future<void> getInfoSpecie(String numPokemon) {
    return _$getInfoSpecieAsyncAction
        .run(() => super.getInfoSpecie(numPokemon));
  }

  @override
  String toString() {
    return '''
specie: ${specie},
pokeApiV2: ${pokeApiV2}
    ''';
  }
}
