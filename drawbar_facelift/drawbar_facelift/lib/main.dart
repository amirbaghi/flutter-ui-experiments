import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawbar Facelift App',
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
    with SingleTickerProviderStateMixin {
  int _hits = 0;
  bool _canBeDragged = false;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() {
      ++_hits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _controller.value += details.primaryDelta / 255.0;
      },
      onHorizontalDragEnd: (details) {
        if (_controller.isDismissed || _controller.isCompleted) {
          return;
        } else {
          if (details.velocity.pixelsPerSecond.dx > 365.0) {
            _controller.fling(velocity: details.velocity.pixelsPerSecond.dx);
          } else {
            if (_controller.value < 0.5) {
              setState(() {
                _controller.reverse();
              });
            } else {
              setState(() {
                _controller.forward();
              });
            }
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          double slide = 255.0 * _controller.value;
          double scale = 1 - (0.3 * _controller.value);
          return Stack(children: [
            Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              body: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/FavIconAtelier.png'),
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
                    DrawerOption(icon: Icons.local_cafe, text: "Coffee"),
                  ],
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Drawbar Facelift App"),
                  backgroundColor: Theme.of(context).primaryColor,
                  actions: [
                    // IconButton(icon: Icon(Icons.menu), onPressed: null),
                  ],
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
                  child: Icon(Icons.add),
                ),
                drawer: Container(),
              ),
            ),
          ]);
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
            color: Theme.of(context).primaryColor,
          ),
          label: Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 9.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20.0, color: Theme.of(context).primaryColor),
            ),
          )),
    );
  }
}
