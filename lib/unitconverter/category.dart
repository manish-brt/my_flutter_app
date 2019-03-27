import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_app/unitconverter/unit.dart';

class Category{
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  const Category({
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null);
}
