import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Fading Survey Page',
      theme: ThemeData(
        primaryColor: const Color(0xfff6c90e),
        accentColor: const Color(0xff303841),
      ),
      home: AnimatedFadingSurveyPage(),
    );
  }
}

class AnimatedFadingSurveyPage extends StatefulWidget {
  AnimatedFadingSurveyPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFadingSurveyPage();
}

class _AnimatedFadingSurveyPage extends State<AnimatedFadingSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFEF5734),
        Color(0xFFFFCC2F),
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  size: 30,
                ),
                onPressed: () {},
              ),
              bottom: MediaQuery.of(context).size.height - 74,
              right: MediaQuery.of(context).size.width - 58,
            ),
            Positioned(
              child: Icon(
                Icons.local_pizza,
                size: 67,
              ),
              bottom: MediaQuery.of(context).size.height - 135,
              right: MediaQuery.of(context).size.width - 140,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height - 660,
              right: MediaQuery.of(context).size.width - 107.2,
              child: Container(
                height: 530,
                width: 1,
                color: Colors.black.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
