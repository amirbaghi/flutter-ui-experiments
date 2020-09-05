import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodr.',
      theme: ThemeData(
          primaryColor: const Color(0xfff6c90e),
          accentColor: const Color(0xff303841)),
      home: DrawbarFaceliftApp(),
    );
  }
}

class DrawbarFaceliftApp extends StatefulWidget {
  const DrawbarFaceliftApp({Key key}) : super(key: key);

  @override
  _DrawbarFaceliftAppState createState() => _DrawbarFaceliftAppState();
}

class _DrawbarFaceliftAppState extends State<DrawbarFaceliftApp>
    with TickerProviderStateMixin {
  int _hits = 0;
  bool _canBeDragged = false;
  AnimationController _controller;
  AnimationController _colorController;
  Animation _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _colorController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _colorAnimation =
        ColorTween(begin: Color(0xfff6c90e), end: Color(0xff303841))
            .animate(_colorController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() {
      ++_hits;
    });
  }

  void animate() {
    if (_controller.isCompleted) {
      setState(() {
        _controller.reverse();
        _colorController.reverse();
      });
    } else {
      setState(() {
        _controller.forward();
        _colorController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _controller.value += details.primaryDelta / 255.0;
        _colorController.value += details.primaryDelta / 255.0;
      },
      onHorizontalDragEnd: (details) {
        if (_controller.isDismissed || _controller.isCompleted) {
          return;
        } else {
          if (details.velocity.pixelsPerSecond.dx.abs() > 365.0) {
            _controller.fling(velocity: details.velocity.pixelsPerSecond.dx);
            _colorController.fling(
                velocity: details.velocity.pixelsPerSecond.dx);
          } else {
            if (_controller.value < 0.5) {
              setState(() {
                _controller.reverse();
                _colorController.reverse();
              });
            } else {
              setState(() {
                _controller.forward();
                _colorController.forward();
              });
            }
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Material(
            color: Theme.of(context).accentColor,
            child: Stack(children: [
              Transform.translate(
                offset: Offset(300.0 * (_controller.value - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi / 2 * (1 - _controller.value)),
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: SafeArea(
                      right: true,
                      minimum: EdgeInsets.only(right: 95.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 100.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: SizedBox(
                                  width: 200,
                                  child: Transform.scale(
                                      scale: 1.8,
                                      child: Image.asset(
                                          "assets/FavIconAtelier.png"))),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            DrawerOption(
                              icon: Icons.cake,
                              text: "Cake",
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            DrawerOption(
                              icon: Icons.local_pizza,
                              text: "Pizza",
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            DrawerOption(
                                icon: Icons.local_cafe, text: "Coffee"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(300.0 * _controller.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-pi * _controller.value / 2),
                  alignment: Alignment.centerLeft,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 43.0),
                        child: Text("Foodr."),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      actions: [],
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have pressed the button this many times:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "$_hits",
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: _increment,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 330.0 * (_controller.value),
                bottom: MediaQuery.of(context).size.height - 76,
                child: AnimatedBuilder(
                    animation: _colorAnimation,
                    child: IconButton(
                      color: _colorAnimation.value,
                      icon: Icon(Icons.menu),
                      onPressed: animate,
                    ),
                    builder: (context, child) => child),
              ),
            ]),
          );
        },
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  DrawerOption({Key key, this.icon, this.text}) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: FlatButton.icon(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 40.0,
            color: Theme.of(context).accentColor,
          ),
          label: Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 9.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20.0, color: Theme.of(context).accentColor),
            ),
          )),
    );
  }
}
