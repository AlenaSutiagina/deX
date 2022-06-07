import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/requests.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({Key? key, required this.stack, required this.stackId})
      : super(key: key);
  final DocumentReference stack;
  final String stackId;

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  TextEditingController questionController = new TextEditingController();
  TextEditingController answerController = new TextEditingController();

  void onSave() {
    print("Creating new card. Question: " +
        questionController.text +
        "; Answer: " +
        answerController.text);
    String question = questionController.text;
    String answer = answerController.text;
    Requests requests = Requests();
    requests.saveCard(
        MyCard(
          question: question,
          answer: answer,
          stack: widget.stack,
          index: 0,
        ),
        widget.stackId);
    Navigator.pop(context);
  }

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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const Text("Create Card", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 30),
                QuestionWidget(questionController: questionController),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Answer:", style: TextStyle(fontSize: 17)),
                      TextField(
                          controller: answerController,
                          maxLines: 5,
                          decoration: InputDecoration(
                              focusColor: Colors.purple[100],
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: 'Enter the answer'))
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                        primary: Colors.purple[100]),
                    onPressed: () {
                      onSave();
                    },
                    child: const Text("Save")),
              ],
            )
          ],
        ));
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.questionController,
  }) : super(key: key);

  final TextEditingController questionController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question:", style: TextStyle(fontSize: 17)),
          TextField(
              controller: questionController,
              maxLines: 3,
              decoration: InputDecoration(
                  focusColor: Colors.purple[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter the question'))
        ],
      ),
    );
  }
}
