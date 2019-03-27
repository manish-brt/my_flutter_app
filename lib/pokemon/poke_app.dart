import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/pokemon/pokemondetails.dart';
import 'dart:convert';
import 'package:my_flutter_app/pokemon/pokemonlist.dart';

class PokeApp extends StatefulWidget {
  const PokeApp();

  @override
  PokeAppState createState() {
    return new PokeAppState();
  }
}

class PokeAppState extends State<PokeApp> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokemonHub pokemonHub;

  void fetchPokemons() async {
    var response = await http.get(url);
    var decodedJSON = jsonDecode(response.body);

    pokemonHub = PokemonHub.fromJson(decodedJSON);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Poke App'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Center(
          child: pokemonHub == null
              ? CircularProgressIndicator()
              : GridView.count(
                  crossAxisCount: 2,
                  children: pokemonHub.pokemon
                      .map(
                        (poke) => Padding(
                              padding: EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PokemonDetails(pokemon: poke)),
                                  );
                                },
                                child: Hero(
                                  tag: poke.img,
                                  child: Card(
                                    elevation: 3.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 100.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(poke.img),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          poke.name,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      )
                      .toList(),
                ),
        ));
  }
}
