import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_login/data/requests.dart';
import 'package:flutter_firebase_login/home/view/stack_page.dart';

class CreateStackScreen extends StatefulWidget {
  final String rootWidget;
  const CreateStackScreen({Key? key, required this.rootWidget})
      : super(key: key);

  @override
  State<CreateStackScreen> createState() => _CreateStackScreenState();
}

class _CreateStackScreenState extends State<CreateStackScreen> {
  TextEditingController profController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();

  void onSave() {
    String profName = profController.text;
    String subjectName = subjectController.text;
    Requests requests = Requests();
    MyStack stack = requests.saveStack(
        UniqueKey().toString(), profName, subjectName, widget.rootWidget);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (contex) => StackPage(
                  profName: profName,
                  subjectName: subjectName,
                  stackRef: stack.reference,
                  stackId: stack.id,
                  cards: [],
                  rootWidget: widget.rootWidget,
                )));
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
                const Text("Create Stack", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 30),
                const SizedBox(height: 20),
                QuestionWidget(questionController: profController),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          controller: subjectController,
                          decoration: InputDecoration(hintText: 'Subject'))
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
          TextField(
              controller: questionController,
              decoration: InputDecoration(hintText: 'Professor'))
        ],
      ),
    );
  }
}
