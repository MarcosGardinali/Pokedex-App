// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, import_of_legacy_library_into_null_safe, unused_field, non_constant_identifier_names, unused_import, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexkanto/pages/about_page/widgets/aba_sobre.dart';
import 'package:pokedexkanto/stores/pokeapi_store.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../models/specie.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;
  PokeApiStore? _PokemonStore;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _PokemonStore = GetIt.instance<PokeApiStore>();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Observer(builder: (context) {
            return TabBar(
              onTap: (index) {
                  _pageController?.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                
              },
              controller: _tabController,
              indicatorColor: _PokemonStore?.corPokemon,
              tabs: [
                Tab(
                  text: "Sobre",
                ),
                Tab(
                  text: "Evolução",
                ),
                Tab(
                  text: "Status",
                ),
              ],
              labelColor: _PokemonStore?.corPokemon,
            );
          }),
        ),
      )),
      body: PageView(
        onPageChanged: (index) {
            _tabController?.animateTo(index,
                duration: Duration(milliseconds: 300));
          
        },
        controller: _pageController,
        children: [
          AbaSobre(),
          Container(color: Colors.blue),
          Container(color: Colors.red),
        ],
      ),
    );
  }
}
