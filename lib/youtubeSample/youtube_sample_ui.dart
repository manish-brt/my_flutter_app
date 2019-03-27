import 'package:flutter/material.dart';
import 'dart:math';

class MyYoutube extends StatefulWidget {
  @override
  _MyYoutubeState createState() => _MyYoutubeState();
}

class _MyYoutubeState extends State<MyYoutube> with TickerProviderStateMixin {

  Widget myAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.monetization_on,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '1 Day Show',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Icon(
            Icons.videocam,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  int _selectedIndex = 1;

  Widget myBottomNavBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.blueGrey[100],
        primaryColor: Colors.blueAccent,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(
          caption: new TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      child: BottomNavigationBar(
        onTap: _onNavItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text(
                'Show'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text(
                'Show'),
          ),
        ],
      ),
    );
  }

  void _onNavItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Widget myVideoListView() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, pos) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      'assets/images/flash_img.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Icon(Icons.people, size: 40.0),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text('Name'),
                          ),
                          Text('descriptions'),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      flex: 9,
                    ),
                    Expanded(
                      child: Icon(Icons.more_vert),
                      flex: 1,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  var currentAlignment = Alignment.topCenter;

  var minVideoHeight = 100.0;
  var minVideoWidth = 150.0;

  var maxVideoHeight = 200.0;
  var maxVideoWidth = 250.0;

  var currentVideoHeight = 200.0;
  var currentVideoWidth = 200.0;


  Widget myPicInPic() {
    bool isInSmallMode = false;
    return LayoutBuilder(
      builder: (context, constraints) {
        maxVideoWidth = constraints.biggest.width;
        if (!isInSmallMode) {
          currentVideoWidth = maxVideoWidth;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Align(
                child: Padding(
                  padding: EdgeInsets.all(isInSmallMode ? 8.0 : 0.0),
                  child: GestureDetector(
                    child: Container(
                      width: currentVideoWidth,
                      height: currentVideoHeight,
                      child: Image.asset(
                        'assets/images/dummyVideo.jpg', fit: BoxFit.cover,),
                      color: Colors.blueAccent,
                    ),
                    onVerticalDragEnd: (details) {
                      if (details.velocity.pixelsPerSecond.dy > 0) {
                        setState(() {
                          isInSmallMode = true;
                          alignmentAnimController.forward();
                          videoViewController.forward();
                        });
                      } else if (details.velocity.pixelsPerSecond.dy < 0) {
                        setState(() {
                          alignmentAnimController.reverse();
                          videoViewController.reverse().then((value) {
                            setState(() {
                              isInSmallMode = false;
                            });
                          });
                        });
                      }
                    },
                  ),),
                alignment: currentAlignment,
              ),
              flex: 3,
            ),
            currentAlignment == Alignment.topCenter ?
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(padding: const EdgeInsets.all(8.0),
                          child: Text("Video Recommendation"),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Video Recommendation"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Video Recommendation"),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
              ),
            ) : Container(),
            Row()
          ],
        );
      },
    );
  }

  AnimationController alignmentAnimController;
  Animation alignmentAnim;

  AnimationController videoViewController;
  Animation videoViewAnim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alignmentAnimController =
    AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          currentAlignment = alignmentAnim.value;
        });
      });

    alignmentAnim =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomRight)
            .animate(CurvedAnimation(
            parent: alignmentAnimController, curve: Curves.decelerate));

    videoViewController =
    AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          currentVideoWidth = (maxVideoWidth * videoViewAnim.value) +
              (minVideoWidth * (1.0 - videoViewAnim.value));
          currentVideoHeight = (maxVideoHeight * videoViewAnim.value) +
              (minVideoHeight * (1.0 - videoViewAnim.value));
        });
      });

    videoViewAnim =
        Tween<double>(begin: 1.0, end: 0.0).animate(videoViewController);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),

      body: Stack(
        children: <Widget>[
          Center(
            child: myVideoListView(),
          ),
          myPicInPic(),
        ],
      ),

      bottomNavigationBar: myBottomNavBar(),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}