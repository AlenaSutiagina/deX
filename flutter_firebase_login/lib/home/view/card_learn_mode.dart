import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCardLearnMode extends StatefulWidget {
  MyCardLearnMode(
      {required this.question, required this.answer, required this.stack})
      : super();
  String question;
  String answer;
  DocumentReference stack;
  @override
  State<MyCardLearnMode> createState() =>
      _MyCardLearnModeState(question: question, answer: answer, stack: stack);
}

class _MyCardLearnModeState extends State<MyCardLearnMode> {
  int _selectedIndex = 0;
  String question;
  String answer;
  DocumentReference stack;
  _MyCardLearnModeState(
      {required this.question, required this.answer, required this.stack})
      : super();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _answers = <Widget>[
      ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Text(this.answer, style: TextStyle(fontSize: 24))),
      Text(this.answer, style: TextStyle(fontSize: 24))
    ];

    List<Widget> _buttons = <Widget>[
      Align(
        child: IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.remove_red_eye_outlined,
              size: 32, color: Colors.purple[100]),
          tooltip: 'Show answer',
          onPressed: () => {_onItemTapped(1)},
        ),
      ),
      ButtonsRow(),
    ];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE1BEE7)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("deX",
              style: TextStyle(fontSize: 28, color: Color(0xFFE1BEE7))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Align(
            alignment: const Alignment(0, -0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //  mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(10.0),
                      height: 130,
                      width: 500,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple)),
                      child: Column(
                        children: <Widget>[
                          Text(this.question, style: TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(10.0),
                      height: 230,
                      width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                      ),
                      child: Column(
                        children: <Widget>[_answers.elementAt(_selectedIndex)],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buttons.elementAt(_selectedIndex)])
              ],
            )));
  }
}

class ButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          child: IconButton(
            alignment: Alignment.bottomLeft,
            icon:
                Icon(Icons.arrow_back_ios, size: 32, color: Colors.purple[100]),
            tooltip: 'Previous card',
            onPressed: () {
              // TODO here func to go to the previous card
            },
          ),
        ),
        SizedBox(width: 20),
        Align(
          child: IconButton(
            alignment: Alignment.bottomCenter,
            icon: Icon(Icons.star_border, size: 32, color: Colors.purple[100]),
            tooltip: 'Add to favourites',
            onPressed: () {
              // TODO here func to favourite the current card
            },
          ),
        ),
        SizedBox(width: 20),
        Align(
          child: IconButton(
            alignment: Alignment.bottomRight,
            icon: Icon(Icons.arrow_forward_ios,
                size: 32, color: Colors.purple[100]),
            tooltip: 'Next card',
            onPressed: () {
              // TODO here func to go to the next card
            },
          ),
        ),
      ],
    );
  }
}
