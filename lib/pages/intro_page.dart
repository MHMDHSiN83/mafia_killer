import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/game_settings_page');
            },
            icon: Icon(
              Icons.play_arrow,
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}
