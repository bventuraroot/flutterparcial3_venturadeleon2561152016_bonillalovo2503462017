import 'package:flutter/material.dart';
//import 'package:flutter_parcial3venturadeleon_bonillalovo/paginas/colores.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarvelHome extends StatefulWidget {
  const MarvelHome({super.key});

  @override
  State<MarvelHome> createState() => _MarvelHomeState();
}

class _MarvelHomeState extends State<MarvelHome> {
  List listmarvel = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 251),
      body: Stack(
        children: [
          Positioned(
            bottom: -5,
            right: -5,
            child: Image.asset("assets/img/marvel.png",
                width: 200, fit: BoxFit.fitWidth),
          ),
          Positioned(
              top: 50,
              left: 20,
              child: Column(
                children: [
                  Text(
                    "Parcial N3 Brian Ventura y Jose Bonilla",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Container(
                    child: DecoratedIcon(
                      icon: Icon(FontAwesomeIcons.cartFlatbedSuitcase,
                          color: Color.fromARGB(255, 231, 39, 5)),
                      decoration: IconDecoration(
                        shadows: [Shadow(blurRadius: 5, offset: Offset(0, 0))],
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
              top: 150,
              bottom: 0,
              width: ancho,
              child: Column(
                children: [
                  listmarvel.length != null
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.4),
                              itemCount: listmarvel.length,
                              itemBuilder: (context, index) {
                                var stories = listmarvel[index]['format'];
                                return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: 10,
                                            //right: 2,
                                            child: Image.asset(
                                              "assets/img/marvel.png",
                                              height: 40,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Positioned(
                                              top: 10,
                                              left: 20,
                                              child: Text(
                                                listmarvel[index]['title'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )),
                                          Positioned(
                                              top: 45,
                                              left: 20,
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                          top: 4,
                                                          bottom: 4),
                                                  child: Text(
                                                      stories.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10)),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black26),
                                              )),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: CachedNetworkImage(
                                              imageUrl: listmarvel[index]
                                                      ['thumbnail']['path'] +
                                                  '.jpg',
                                              height: 105,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                );
                              }))
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      datosMarvel();
    }
  }

  void datosMarvel() {
    var url = Uri.parse(
        'http://gateway.marvel.com/v1/public/comics?apikey=7f9948998b2ccc1bf464a45338a1875c&ts=1&hash=4f32949d2756bca2ca0360d001457a7e');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        listmarvel = decodejsonData['data']['results'];
        setState(() {});
        print(decodejsonData);
      }
    });
  }
}
