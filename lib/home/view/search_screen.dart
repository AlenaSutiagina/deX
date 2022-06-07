import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/requests.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SearchScreen> {
  List<MyStack> _stackList = List.empty();
  TextEditingController _controller = TextEditingController();

  void _executeQuery(String text) async {
    List list = List.empty(growable: true);
    await FirebaseFirestore.instance
        .collection('stacks')
        .where("sub", isGreaterThanOrEqualTo: text)
        .where("sub", isLessThanOrEqualTo: text + 'zzz')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((element) {
                list.add(element);
              })
            });
    List<MyStack> listWithStacks = list
        .map((e) => MyStack(
              id: e["id"],
              prof: e["prof"],
              sub: e["sub"],
              cards: e["cards"],
              reference: Requests.stacks.doc(e["id"]),
              rootWidget: "",
            ))
        .toList();

    setState(() {
      _stackList = listWithStacks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: TextField(
              textInputAction: TextInputAction.search,
              onChanged: _executeQuery,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for something',
              )),
        ),
        body: ListView.builder(
          itemCount: _stackList.length,
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(10.0),
                height: 130,
                width: 500,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
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
                                if (_stackList[index].cards != null) {
                                  cards = _stackList[index].cards;
                                } else {
                                  cards = [];
                                }
                                ;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => MyStack(
                                              id: _stackList[index].id,
                                              cards: cards,
                                              prof: _stackList[index].prof,
                                              sub: _stackList[index].sub,
                                              reference:
                                                  _stackList[index].reference,
                                              rootWidget: "SearchScreen",
                                            )));
                              },
                            ))),
                    Text("Professor: " + _stackList[index].prof,
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 8),
                    Text("Subject: " + _stackList[index].sub,
                        style: TextStyle(fontSize: 24)),
                  ],
                ));
          },
        ));
  }
}
