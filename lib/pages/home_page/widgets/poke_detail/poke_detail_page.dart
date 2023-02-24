// ignore_for_file: unused_local_variable, unnecessary_this, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unused_import, sort_child_properties_last, prefer_interpolation_to_compose_strings, unused_field, unrelated_type_equality_checks, avoid_function_literals_in_foreach_calls

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexkanto/consts/consts_api.dart';
import 'package:pokedexkanto/pages/home_page/widgets/poke_item.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../consts/consts_app.dart';
import '../../../../models/pokeapi.dart';
import '../../../../stores/pokeapi_store.dart';
import '../../../../stores/pokeapiv2_store.dart';
import '../../../about_page/about_page.dart';

class PokeDetailPage extends StatefulWidget {
  PokeDetailPage({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<PokeDetailPage> createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController? _pageController;
  Pokemon? _pokemon;
  PokeApiStore? _PokemonStore;
  double? _progress;
  double? _multiple;
  double? _opacity;
  double? _opacityTitleAppBar;
  PokeApiV2Store? _pokeApiV2Store;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.54);
    _PokemonStore = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _pokeApiV2Store?.getInfoPokemon(_PokemonStore!.pokemonAtual!.name);
    _pokeApiV2Store?.getInfoSpecie(_PokemonStore!.pokemonAtual!.id.toString());

    _pokemon = _PokemonStore!.pokemonAtual!;
    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);
    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower).clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Observer(builder: (context) {
          return AnimatedContainer(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              _PokemonStore?.corPokemon,
              _PokemonStore?.corPokemon.withOpacity(0.7)
            ])),
            child: Stack(
              children: [
                AppBar(
                  title: Opacity(
                    opacity: _opacityTitleAppBar!,
                  ),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  actions: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          child: Opacity(
                            child: Image.asset(
                              ConstsApp.whitepokeball,
                              height: 50,
                              width: 50,
                            ),
                            opacity: 0.2,
                          ),
                          angle: 1.0,
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.082 -
                      _progress! * (MediaQuery.of(context).size.height * 0.027),
                  left: 18 +
                      _progress! * (MediaQuery.of(context).size.height * 0.027),
                  child: Text(
                    _PokemonStore!.pokemonAtual!.name.toString(),
                    style: TextStyle(
                        fontFamily: 'Google',
                        fontSize: 25 -
                            _progress! *
                                (MediaQuery.of(context).size.height * 0.007),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.11,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setTipos(_PokemonStore!.pokemonAtual!.type),
                          Text(
                            '#' + _PokemonStore!.pokemonAtual!.num.toString(),
                            style: TextStyle(
                                fontFamily: 'Google',
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            duration: Duration(milliseconds: 300),
          );
        }),
        SlidingSheet(
          listener: (state) {
            setState(() {
              _progress = state.progress;
              _multiple = 1 - interval(0.0, 0.88, _progress!);
              _opacity = _multiple;
              _opacityTitleAppBar = interval(0.55, 0.88, _progress!);
            });
          },
          elevation: 0,
          cornerRadius: 40,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.7, 0.88],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          body: Center(
            child: Text('This widget is below the SlidingSheet'),
          ),
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.12,
              child: AboutPage(),
            );
          },
        ),
        Opacity(
          opacity: _opacity!,
          child: Padding(
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1 ? 1000 : 78 - _progress! * 52),
              child: SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _PokemonStore?.setPokemonAtual(index: index);
                    _pokeApiV2Store
                        ?.getInfoPokemon(_PokemonStore!.pokemonAtual!.name);
                    _pokeApiV2Store?.getInfoSpecie(
                        _PokemonStore!.pokemonAtual!.id.toString());
                  },
                  itemCount: _PokemonStore?.pokeApi!.pokemon!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon? _pokeitem = _PokemonStore?.getPokemon(index);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                            child: Image.asset(
                              ConstsApp.whitepokeball,
                              height: 200,
                              width: 200,
                            ),
                            opacity: 0.07),
                        Observer(builder: (context) {
                          return AnimatedPadding(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceInOut,
                            padding: EdgeInsets.all(
                                index == _PokemonStore?.posicaoAtual ? 0 : 60),
                            child: Hero(
                              tag: index == _PokemonStore?.pokemonAtual
                                  ? _pokeitem!.name!
                                  : 'none' + index.toString(),
                              child: CachedNetworkImage(
                                height: 160,
                                width: 160,
                                placeholder: (context, url) => Container(
                                  color: Colors.transparent,
                                ),
                                color: index == _PokemonStore?.posicaoAtual
                                    ? null
                                    : Colors.black.withOpacity(0.5),
                                imageUrl:
                                    'https://raw.githubusercontent.com/fanzeyi/Pokemon.json/master/images/${_pokeitem!.num}.png',
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              )),
        )
      ]),
    );
  }

  Widget setTipos(List<String>? types) {
    List<Widget> lista = [];
    types?.forEach((nome) {
      lista.add(
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
