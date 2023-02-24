// ignore_for_file: prefer_const_constructors, sort_child_properties_last, duplicate_ignore, prefer_interpolation_to_compose_strings, unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedexkanto/consts/consts_api.dart';

import '../../../consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  const PokeItem(
      {Key? key,
      required this.name,
      required this.index,
      //required this.color,
      required this.types,
      this.num})
      : super(key: key);
  final String? name;
  final int index;
  // final Color color;
  final String? num;
  final List<String>? types;

  Widget setTipos() {
    List<Widget> lista = [];
    types?.forEach((nome) {
      lista.add(
        Column(
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            //alignment: Alignment.bottomRight,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name!,
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.5, top: 35),
                child: setTipos(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name!,
                  child: Opacity(
                    child: Image.asset(
                      ConstsApp.whitepokeball,
                      height: 100,
                      width: 100,
                    ),
                    opacity: 0.2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name!,
                  child: CachedNetworkImage(
                    height: 90,
                    width: 90,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/fanzeyi/Pokemon.json/master/images/$num.png',
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ConstsApp.getColorType(type: types![0])!.withOpacity(0.7),
              ConstsApp.getColorType(type: types![0])!
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
      ),
    );
  }
}
