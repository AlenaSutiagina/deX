import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/home/view/second_page.dart';
import 'package:flutter_firebase_login/home/view/favourites_screen.dart';
import 'package:flutter_firebase_login/home/view/all_stacks_screen.dart';

import 'search_screen.dart';

class HomePage extends StatefulWidget {
  final int index;
  const HomePage({Key? key, required this.index}) : super(key: key);

  static Page page() => const MaterialPage<void>(
          child: HomePage(
        index: 0,
      ));

  @override
  State<HomePage> createState() => _HomepageState(index);
}

class _HomepageState extends State<HomePage> {
  int selectedIndex;

  _HomepageState(this.selectedIndex) {}

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    SecondPage(),
    SearchScreen(),
    FavouritesScreen(),
    AllStacksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("deX",
              style: TextStyle(fontSize: 28, color: Color(0xFFE1BEE7))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              color: Color(0xFFE1BEE7),
              onPressed: () =>
                  context.read<AppBloc>().add(AppLogoutRequested()),
            )
          ],
        ),
        body: Center(
          child: _pages.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day_rounded),
              label: 'All stacks',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.purple[200],
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          elevation: 0.0,
        ));
  }
}
