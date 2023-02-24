// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
              child: Column(
                children: <Widget>[
                  Container(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[Padding(
                      padding: EdgeInsets.only(top: 45, right: 15.7),
                      child: IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.menu)),
                    )],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Pokedex', style: TextStyle(
                        fontFamily: 'Google', 
                        fontWeight: FontWeight.bold, 
                        fontSize: 28),
                        )
                        ),
                  ],
                )
                ],
              ),
              height: 130,
              // ignore: prefer_const_constructors
              color: (Color.fromARGB(180, 240, 245, 210)),
            );
  }
}