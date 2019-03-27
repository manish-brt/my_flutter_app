import 'package:flutter/material.dart';
import 'package:my_flutter_app/unitconverter/category.dart';
import 'package:my_flutter_app/unitconverter/unit.dart';
import 'package:my_flutter_app/unitconverter/category_tile.dart';
import 'package:my_flutter_app/unitconverter/unit_converter.dart';
import 'package:my_flutter_app/unitconverter/backdrop.dart';
import 'dart:convert';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryStateRoute createState() => _CategoryStateRoute();
}

class _CategoryStateRoute extends State<CategoryRoute> {
  final _categories = <Category>[];

  Category _defaultCategory;
  Category _currentCategory;

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _icons = <IconData>[
    Icons.timeline,
    Icons.format_shapes,
    Icons.panorama_vertical,
    Icons.local_airport,
    Icons.timer,
    Icons.sd_storage,
    Icons.wb_sunny,
    Icons.attach_money,
  ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  @override
  void initState() {
    super.initState();
    if (_categories.isEmpty) {
      _retrieveLocalCategories();
    }

//    for (var i = 0; i < _categoryNames.length; i++) {
//      var category = Category(
//        name: _categoryNames[i],
//        color: _baseColors[i],
//        iconLocation: Icons.cake,
//        units: _retrieveUnitList(_categoryNames[i]),
//      );
//      if (i == 0) {
//        _defaultCategory = category;
//      }
//      _categories.add(category);
//    }
  }

  Future<Null> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_unit.json');

    final data = JsonDecoder().convert(await json);

    if (data is! Map) {
      throw ('Data is not Structured as Map');
    }

    var categoryIndex = 0;

    for (var key in data.keys) {

      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();
      var category = Category(
        name: key,
        color: _baseColors[categoryIndex],
        iconLocation: _icons[categoryIndex],
        units: units,
      );

      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex += 1;
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryWidget(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return CategoryTile(
            category: _categories[index],
            onTap: _onCategoryTap,
          );
        },
        itemCount: _categories.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 5,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  List<Unit> _retrieveUnitList(String catName) {
    return List.generate(5, (int i) {
      i += 1;
      return Unit(
        name: '$catName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    assert(debugCheckHasMediaQuery(context));
    final myListView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidget(MediaQuery.of(context).orientation),
    );


    Future<bool> _onBackPressed(){
      return showDialog(context: context,builder: (context) => AlertDialog(
        title: Text('Are You Sure You Want To Exit ?',style: new TextStyle(
          fontSize: 16.0, color: Colors.black54
        ),),
        actions: [
          FlatButton(
            child: Text('No'),
            onPressed: ()=> Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: ()=> Navigator.pop(context, true),
          ),
        ],
      ),);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Backdrop(
        currentCategory:
            _currentCategory == null ? _defaultCategory : _currentCategory,
        frontPanel: _currentCategory == null
            ? UnitConverter(
                category: _defaultCategory,
              )
            : UnitConverter(
                category: _currentCategory,
              ),
        backPanel: myListView,
        backTitle: Text('Select a Category'),
        frontTitle: Text('Unit Converter'),
      ),
    );
  }
}
