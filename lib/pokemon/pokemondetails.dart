import 'package:flutter/material.dart';
import 'package:my_flutter_app/pokemon/pokemonlist.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetails({this.pokemon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(pokemon.name),
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              elevation: 8,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height : ${pokemon.height}",
                  ),
                  Text("Weight : ${pokemon.weight}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 10,
                    children: pokemon.type
                        .map((t) => FilterChip(
                              backgroundColor: Colors.amber,
                              label: Text(t),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text(
                    "Weekness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: pokemon.weaknesses
                        .map((w) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(
                                w,
                                style: TextStyle(color: Colors.white),
                              ),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 10,
                      children: pokemon.nextEvolution != null
                          ? pokemon.nextEvolution
                              .map((n) => FilterChip(
                                    backgroundColor: Colors.green,
                                    label: Text(
                                      n.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (b) {},
                                  ))
                              .toList()
                          : List.generate(
                              1,
                              (int i) {
                                return FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    'Unknown',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (i) {},
                                );
                              },
                            )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.img,
                child: Container(
                  height: 180.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(pokemon.img),
                    ),
                  ),
                )),
          )
        ],
      );
}
