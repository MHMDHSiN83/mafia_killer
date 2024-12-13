import 'package:flutter/material.dart';
import 'package:mafia_killer/pages/intro_page.dart';
import 'package:mafia_killer/pages/players_page.dart';

class StackNavigator extends StatefulWidget {
  @override
  _StackNavigatorState createState() => _StackNavigatorState();
}

class _StackNavigatorState extends State<StackNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Page 1")),
    Center(child: Text("Page 2")),
    Center(child: PlayersPage()),

  ];

  void _goToNextPage() {
    setState(() {
      if (_currentIndex < _pages.length - 1) _currentIndex++;
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentIndex > 0) _currentIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page $_currentIndex")),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _goToPreviousPage,
            child: Icon(Icons.arrow_back),
            heroTag: 'previousPageButton', // Unique heroTag
          ),
          FloatingActionButton(
            onPressed: _goToNextPage,
            child: Icon(Icons.arrow_forward),
            heroTag: 'nextPageButton', // Unique heroTag
          ),
        ],
      ),
    );
  }
}
