import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/home/view/ccard_screen.dart';
import 'package:flutter_firebase_login/home/view/stack_page.dart';

class Requests {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference stacks =
      FirebaseFirestore.instance.collection('stacks');
  static List<MyStack> stackList = [];

  // Requests() {
  //   setStackList();
  // }

  static void deleteCard(int index, String stackId) async {
    print("delete card from database");
    var cards = [];

    try {
      await FirebaseFirestore.instance
          .collection('stacks')
          .doc(stackId)
          .get()
          .then((value) => value.data()!['cards'])
          .then((value) {
        cards = value;
      });
    } catch (e) {
      cards = [];
    }

    cards.removeAt(index);

    FirebaseFirestore.instance
        .collection('stacks')
        .doc(stackId)
        .update({'cards': cards});
  }

  // static void setStackList() async {
  //   QuerySnapshot snap = await stacks.get();
  //   var stackListDoc = snap.docs;

  //   for (var item in stackListDoc) {
  //     stackList.add(MyStack(id: item.id, reference: item.reference));
  //   }
  // }

  void saveCard(MyCard card, String stackId) async {
    print("saving card in database");

    var cards = [];

    try {
      await FirebaseFirestore.instance
          .collection('stacks')
          .doc(stackId)
          .get()
          .then((value) => value.data()!['cards'])
          .then((value) {
        cards = value;
      });
    } catch (e) {
      cards = [];
    }

    cards.add({'question': card.question, 'answer': card.answer});

    FirebaseFirestore.instance
        .collection('stacks')
        .doc(stackId)
        .update({'cards': cards});
  }

  MyStack saveStack(String id, String prof, String sub, String rootWidget) {
    //TODO check whether stack is already created
    DocumentReference docReference = stacks.doc(id);

    docReference
        .set({'id': id, 'prof': prof, 'sub': sub})
        .then((value) => print("Stack Added"))
        .catchError((error) => print("Failed to add stack: $error"));

    return MyStack(
      id: id,
      cards: [],
      prof: prof,
      sub: sub,
      reference: docReference,
      rootWidget: rootWidget,
    );
  }
}

class MyStack extends StatelessWidget {
  MyStack({
    required this.id,
    required this.reference,
    required this.cards,
    required this.sub,
    required this.prof,
    required this.rootWidget,
  }) : super();
  String id;
  DocumentReference reference;
  List cards;
  String prof;
  String sub;
  String rootWidget;
  @override
  Widget build(BuildContext context) {
    return StackPage(
      stackId: this.id,
      cards: this.cards,
      profName: this.prof,
      subjectName: this.sub,
      stackRef: reference,
      rootWidget: rootWidget,
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard(
      {required this.question,
      required this.answer,
      required this.stack,
      required this.index})
      : super();
  String question;
  String answer;
  int index;
  DocumentReference stack;
  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment(1.85, 0.6),
                      child: IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.delete_forever_rounded,
                            size: 32, color: Colors.purple[100]),
                        tooltip: 'Delete card',
                        onPressed: () {
                          Requests.deleteCard(this.index, stack.id);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Align(
                      alignment: Alignment(2.85, 0.6),
                      child: IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.edit,
                            size: 32, color: Colors.purple[100]),
                        tooltip: 'Edit card',
                        onPressed: () {
                          // TODO here func to edit the current card
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Align(
                      alignment: Alignment(2.85, 0.6),
                      child: IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.add_to_photos_rounded,
                            size: 32, color: Colors.purple[100]),
                        tooltip: 'Create new card',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => CreateCardScreen(
                                        stack: this.stack,
                                        stackId: stack.id,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
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
                          border: Border.all(color: Colors.purple)),
                      child: Column(
                        children: <Widget>[
                          Text(this.answer, style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ],
            )));
  }
}
