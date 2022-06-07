import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/requests.dart';

class AllStacksScreen extends StatefulWidget {
  const AllStacksScreen({Key? key}) : super(key: key);

  @override
  State<AllStacksScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AllStacksScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<MyStack> stacksList = Requests.stackList;

    final Stream<QuerySnapshot> _stream =
        FirebaseFirestore.instance.collection('stacks').snapshots();
    return Scaffold(
      body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(10.0),
                      height: 130,
                      width: 500,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple)),
                      child: SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment(0.85, 0.6),
                            child: SizedBox(
                              height: 22.0,
                              width: 22.0,
                              child: IconButton(
                                alignment: Alignment.topRight,
                                icon: Icon(Icons.add_to_home_screen_outlined,
                                    size: 27, color: Colors.purple[100]),
                                tooltip: 'Go to stack',
                                onPressed: () {
                                  List cards;
                                  if (data['cards'] != null) {
                                    cards = data['cards'];
                                  } else {
                                    cards = [];
                                  }
                                  ;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) => MyStack(
                                                id: data['id'],
                                                cards: cards,
                                                prof: data['prof'],
                                                sub: data['sub'],
                                                reference: document.reference,
                                                rootWidget: "AllStackScreen",
                                              )));
                                },
                              ),
                            ),
                          ),
                          Text("Professor: " + data['prof'],
                              style: TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                          Text("Subject: " + data['sub'],
                              style: TextStyle(fontSize: 24)),
                        ],
                      )));
                }).toList(),
              );
            },
          )

          //  Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Column(
          //         children: stacksList
          //             .map<Widget>((stack) => Container(
          //                 padding: const EdgeInsets.all(5.0),
          //                 margin: const EdgeInsets.all(10.0),
          //                 height: 130,
          //                 width: 500,
          //                 decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
          //                 child: Column(
          //                   children: <Widget>[
          //                     Text("Professor: " + stack.id.split(";")[0], style: TextStyle(fontSize: 24)),
          //                     const SizedBox(height: 8),
          //                     Text("Subject: " + stack.id.split(";")[1], style: TextStyle(fontSize: 24)),
          //                     const SizedBox(height: 8),
          //                     TextButton(
          //                         onPressed: () {
          //                           Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                   builder: (contex) => MyStack(
          //                                         id: stack.id,
          //                                         reference: stack.reference,
          //                                       )));
          //                         },
          //                         child: const Text("Go to stack")),
          //                   ],
          //                 )))
          //             .toList()),
          //   ],
          // ),
          ),
    );
  }
}
