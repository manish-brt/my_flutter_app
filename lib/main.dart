import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/paint/MyPaint.dart';
import 'package:my_flutter_app/randomwords/random_words.dart';
import 'package:my_flutter_app/unitconverter/category_route.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/friendly_chat_screen.dart';
import 'package:my_flutter_app/pokemon/poke_app.dart';
import 'package:my_flutter_app/widgets/my_fancy_btn.dart';
import 'package:my_flutter_app/widgets/myLoader.dart';
import 'package:my_flutter_app/widgets/wave_slider.dart';
import 'package:my_flutter_app/youtubeSample/youtube_sample_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Friendly Chat",
      home: new ChatScreen(),
    );
  }
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Poke App",
      home: new PokeApp(),
    );
  }
}

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartUp Name Generatorr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Loader',
      debugShowCheckedModeBanner: false,
      home: Loader(),
    );
  }
}

class MyYoutubeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Youtube',
      debugShowCheckedModeBanner: false,
      home: MyYoutube(),
    );
  }
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.grey[600],
            ),
        primaryColor: Colors.grey,
        textSelectionHandleColor: Colors.green[500],
      ),
      title: 'Unit Converter App',
      home: CategoryRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pushed',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.title,
            ),
            Text('Times'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Manish Agrawal',
                style: TextStyle(
                    fontSize: 24.0, color: Colors.white, wordSpacing: 5),
              ),
              decoration: BoxDecoration(color: Colors.blue[400]),
            ),
            ListTile(
              title: Text('Pokemon',
                  style: TextStyle(letterSpacing: 1, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PokeApp()));
              },
            ),
            ListTile(
              title: Text('Friendly Chat',
                  style: TextStyle(letterSpacing: 1, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
            ListTile(
              title: Text('Unit Converter',
                  style: TextStyle(letterSpacing: 1, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UnitConverterApp()));
              },
            ),
            ListTile(
              title: Text('Startup Name Generator',
                  style: TextStyle(letterSpacing: 1, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomWordsApp()));
              },
            ),
            ListTile(
              title: Text(
                'Date Picker',
                style: TextStyle(letterSpacing: 1, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2014),
                    lastDate: DateTime(2030));
              },
            ),
            ListTile(
              title: Text('Time Picker',
                  style: TextStyle(letterSpacing: 2, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                showTimePicker(context: context, initialTime: TimeOfDay.now());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FancyButton(
        onPressed: _incrementCounter,
      ),
    );
  }
}

enum ScoreWidgetStatus { HIDDEN, BECOMING_VISIBLE, VISIBLE, BECOMING_INVISIBLE }

class _MyHomePageState2 extends State<MyHomePage>
    with TickerProviderStateMixin {
  int _counter = 0;
  double _sparklesAngle = 0.0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  final duration = new Duration(milliseconds: 400);
  final oneSecond = new Duration(seconds: 1);
  Random random;
  Timer holdTimer, scoreOutETA;
  AnimationController scoreInAnimationController,
      scoreOutAnimationController,
      scoreSizeAnimationController,
      sparklesAnimationController;
  Animation scoreOutPositionAnimation, sparklesAnimation;

  initState() {
    super.initState();
    random = new Random();
    scoreInAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener(() {
      setState(() {}); // Calls render function
    });

    scoreOutAnimationController =
        new AnimationController(vsync: this, duration: duration);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
        new CurvedAnimation(
            parent: scoreOutAnimationController, curve: Curves.easeOut));
    scoreOutPositionAnimation.addListener(() {
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener(() {
      setState(() {});
    });

    sparklesAnimationController =
        new AnimationController(vsync: this, duration: duration);
    sparklesAnimation = new CurvedAnimation(
        parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener(() {
      setState(() {});
    });
  }

  dispose() {
    super.dispose();
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sparklesAngle = random.nextDouble() * (2 * pi);
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (scoreOutETA != null) {
      scoreOutETA.cancel(); // We do not want the score to vanish!
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap
    holdTimer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    // User removed his finger from button.
    scoreOutETA = new Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 3;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }

    var stackChildren = <Widget>[];

    var firstAngle = _sparklesAngle;
    var sparkleRadius = (sparklesAnimationController.value * 50);
    var sparklesOpacity = (1 - sparklesAnimation.value);

    for (int i = 0; i < 5; ++i) {
      var currentAngle = (firstAngle + ((2 * pi) / 5) * (i));
      var sparklesWidget = new Positioned(
        child: new Transform.rotate(
            angle: currentAngle - pi / 2,
            child: new Opacity(
                opacity: sparklesOpacity,
                child: new Image.asset(
                  "assets/icons/sparkles.png",
                  width: 14.0,
                  height: 14.0,
                ))),
        left: (sparkleRadius * cos(currentAngle)) + 20,
        top: (sparkleRadius * sin(currentAngle)) + 20,
      );
      stackChildren.add(sparklesWidget);
    }

    stackChildren.add(new Opacity(
        opacity: scoreOpacity,
        child: new Container(
            height: 50.0 + extraSize,
            width: 50.0 + extraSize,
            decoration: new ShapeDecoration(
              shape: new CircleBorder(side: BorderSide.none),
              color: Colors.pink,
            ),
            child: new Center(
                child: new Text(
              "+" + _counter.toString(),
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            )))));

    var widget = new Positioned(
        child: new Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: stackChildren,
        ),
        bottom: scorePosition);
    return widget;
  }

  Widget getClapButton() {
    // Using custom gesture detector because we want to keep increasing the claps
    // when user holds the button.

    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE ||
        _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = scoreSizeAnimationController.value * 3;
    }
    return new GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: new Container(
          height: 60.0 + extraSize,
          width: 60.0 + extraSize,
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.pink, width: 1.0),
              borderRadius: new BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [new BoxShadow(color: Colors.pink, blurRadius: 8.0)]),
          child: new ImageIcon(new AssetImage("assets/icons/clap.png"),
              color: Colors.pink, size: 40.0),
        ));
  }

  int sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Appp'),
      ),
      body: new Center(
        child: new Stack(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Loader(),
            ),
//            SizedBox(
//              height: 40,
//            ),
            Align(
              alignment: Alignment.center,
              child: new Text(
                '$_counter',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),

            Align(
              alignment: Alignment(0, -0.8),
              child: Column(
                children: <Widget>[
                  WaveSlider(
                    width: 350,
                    height: 50,
                    color: Colors.black,
                    onChanged: (double val) {
                      setState(
                        () {
                          sliderVal = (val * 100).round();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    sliderVal.toString(),
                    style: TextStyle(fontSize: 26, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Manish Agrawal',
                style: TextStyle(
                    fontSize: 24.0, color: Colors.white, wordSpacing: 5),
              ),
              decoration: BoxDecoration(color: Colors.blue[400]),
            ),
            ListTile(
              title: Text('Paint',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPaint()));
              },
            ),
            ListTile(
              title: Text('Pokemon',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PokeApp()));
              },
            ),
            ListTile(
              title: Text('Friendly Chat',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
            ListTile(
              title: Text('Unit Converter',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UnitConverterApp()));
              },
            ),
            ListTile(
              title: Text('Startup Name Generator',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomWordsApp()));
              },
            ),
            ListTile(
              title: Text('Youtube Sample',
                  style: TextStyle(letterSpacing: 1, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyYoutubeApp()));
              },
            ),
            ListTile(
              title: Text(
                'Date Picker',
                style: TextStyle(letterSpacing: 1, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2014),
                    lastDate: DateTime(2030));
              },
            ),
            ListTile(
              title: Text('Time Picker',
                  style: TextStyle(letterSpacing: 2, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                showTimePicker(context: context, initialTime: TimeOfDay.now());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new Padding(
          padding: new EdgeInsets.only(right: 20.0),
          child: new Stack(
            alignment: FractionalOffset.center,
            overflow: Overflow.visible,
            children: <Widget>[
              getScoreButton(),
              getClapButton(),
            ],
          )),
    );
  }
}
