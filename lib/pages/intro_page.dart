import 'package:flutter/material.dart';
import 'package:mafia_killer/models/isar_service.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    IsarService();
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/players_page');
            },
            icon: const Icon(
              Icons.play_arrow,
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}
