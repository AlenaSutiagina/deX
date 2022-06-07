import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/home/home.dart';

import 'cstack_screen.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SecondPage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: const Alignment(0, -0.9),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment(0.85, 0.6),
                child: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(Icons.create_new_folder_sharp,
                      size: 42, color: Colors.purple[100]),
                  tooltip: 'Create stack',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => CreateStackScreen(
                                  rootWidget: "SecondScreen",
                                )));
                  },
                ),
              ),
              //  Avatar(photo: user.photo),
              const SizedBox(height: 12),
              Text("Hello, ", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Text(user.email ?? '', style: textTheme.headline6),
              const SizedBox(height: 40),
              Text(
                  "Welcome to the deX-cards app, your best studying assistant.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                  "To create new stack of index cards, press the create stack button on the top of the page.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text("You also can create new stack on the \"All stacks\" tab.",
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                  "For stacks searching you can use the \"Search\" tab (not yet avaliable).",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                  "You can also save cards and stacks in favourites and then find them on the \"Favourites\" tab (not yet avaliable).",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text("Enjoy your time with deX and good luck with exams!",
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              //   Text(user.name ?? '', style: textTheme.headline5),
            ],
          ),
        ),
      ),
    );
  }
}
