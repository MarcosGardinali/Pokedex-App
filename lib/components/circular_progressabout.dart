import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/pokeapi_store.dart';

class CircularProgressAbout extends StatelessWidget {
  const CircularProgressAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          GetIt.instance<PokeApiStore>().corPokemon))
        );  
  }
}
