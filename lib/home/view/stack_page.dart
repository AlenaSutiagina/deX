import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/requests.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:flutter_firebase_login/home/view/ccard_screen.dart';

class StackPage extends StatefulWidget {
  final String profName;
  final String subjectName;
  final DocumentReference stackRef;
  final String stackId;
  final List cards;
  final String rootWidget;

  const StackPage(
      {Key? key,
      required this.profName,
      required this.subjectName,
      required this.stackRef,
      required this.stackId,
      required this.cards,
      required this.rootWidget})
      : super(key: key);

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    List<String> cardList = [];
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE1BEE7)),
            onPressed: () {
              if (widget.rootWidget == "SecondScreen") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => HomePage(
                              index: 0,
                            )));
              } else if (widget.rootWidget == "AllStackScreen") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => HomePage(
                              index: 3,
                            )));
              }
            },
          ),
          title: const Text("deX",
              style: TextStyle(fontSize: 28, color: Color(0xFFE1BEE7))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0),
      body: Align(
        alignment: const Alignment(0, -0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 12),
            Text(widget.subjectName + ", " + widget.profName,
                style: TextStyle(fontSize: 24)),
            //  const SizedBox(height: 5),
            Align(
              alignment: Alignment(0.85, 0.6),
              child: IconButton(
                alignment: Alignment.topRight,
                icon: Icon(Icons.add_to_photos_rounded,
                    size: 32, color: Colors.purple[100]),
                tooltip: 'Create card',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => CreateCardScreen(
                                stack: widget.stackRef,
                                stackId: widget.stackId,
                              )));
                },
              ),
            ),
            const SizedBox(height: 12),
            widget.cards.length != 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: widget.cards.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.all(10.0),
                            height: 130,
                            width: 500,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.purple)),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment(0.85, 0.6),
                                  child: SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child: IconButton(
                                      alignment: Alignment.topRight,
                                      icon: Icon(Icons.add_to_home_screen,
                                          size: 27, color: Colors.purple[100]),
                                      tooltip: 'Go to card',
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CardPage(
                                                    list: widget.cards,
                                                    index: index,
                                                    stackRef:
                                                        widget.stackRef)));
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Text(widget.cards[index]['question'],
                                    style: TextStyle(fontSize: 24)),
                                const SizedBox(height: 8),
                              ],
                            ));
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class CardPage extends StatefulWidget {
  CardPage(
      {Key? key,
      required this.list,
      required this.index,
      required this.stackRef});
  final DocumentReference stackRef;
  final List list;
  int index;
  @override
  State<StatefulWidget> createState() => CardPageState();
}

class CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCard(
        answer: widget.list[widget.index]['answer'],
        stack: widget.stackRef,
        question: widget.list[widget.index]['question'],
        index: widget.index, // add the method to open the card
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.index > 0) widget.index -= 1;
                  });
                },
                icon: Icon(Icons.arrow_back_ios,
                    size: 32, color: Colors.purple[100])),
            IconButton(
                onPressed: () {
                  //TODO add logic
                },
                icon: Icon(Icons.star_border,
                    size: 32, color: Colors.purple[100])),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.index < widget.list.length - 1)
                      widget.index += 1;
                  });
                },
                icon: Icon(Icons.arrow_forward_ios,
                    size: 32, color: Colors.purple[100]))
          ],
        ),
      ),
    );
  }
}
