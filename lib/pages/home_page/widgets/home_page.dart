// ignore_for_file: sort_child_properties_last, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexkanto/consts/consts_app.dart';
import 'package:pokedexkanto/models/pokeapi.dart';
import 'package:pokedexkanto/pages/home_page/widgets/app_bar_home.dart';
import 'package:pokedexkanto/pages/home_page/widgets/poke_detail/poke_detail_page.dart';
import 'package:pokedexkanto/pages/home_page/widgets/poke_item.dart';
import 'package:pokedexkanto/stores/pokeapi_store.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';



class HomePage extends StatefulWidget {
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore? _PokemonStore;

  @override
  void initState() {
    super.initState();
       _PokemonStore = GetIt.instance<PokeApiStore>();
        if (_PokemonStore?.pokeApi == null){
     _PokemonStore?.fetchPokemonList();
    }

  }
  @override
  Widget build(BuildContext context) {
    if (_PokemonStore?.pokeApi == null){
     _PokemonStore?.fetchPokemonList();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
              top: -(240 / 14),
              left: screenWidth - (240 / 1.5),
              child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    ConstsApp.blackpokeball,
                    height: 240,
                    width: 240,
                  ))),
          Container(
              child: Column(children: <Widget>[
            Container(
              height: statusWidth,
            ),
            AppBarHome(),
            Expanded(
              child: Container(
                child: Observer(builder: (BuildContext context) {
                  PokeApi? pokeApi = _PokemonStore?.pokeApi!;
                  return (_PokemonStore!.pokeApi! != null)?
                       AnimationLimiter(
                          child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(9),
                          addAutomaticKeepAlives: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: _PokemonStore?.pokeApi!.pokemon?.length,
                          itemBuilder: ((context, index) {
                            Pokemon? pokemon = _PokemonStore?.getPokemon(index);
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: GestureDetector(
                                  child: PokeItem(
                                    types: pokemon?.type,
                                    index: index,
                                    name: pokemon?.name,
                                    num: pokemon?.num, 
                                  ),
                                  onTap: () {
                                    _PokemonStore?.setPokemonAtual(index: index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          PokeDetailPage(index: index,), 
                                          fullscreenDialog: true,
                                        ));
                                  },
                                ),
                              ),
                            );
                          }),
                        ))
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
