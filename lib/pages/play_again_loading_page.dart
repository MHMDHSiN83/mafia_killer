import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/databases/player.dart';

class PlayAgainLoadingPage extends StatefulWidget {
  PlayAgainLoadingPage({super.key});
  @override
  State<PlayAgainLoadingPage> createState() => _PlayAgainLoadingPageState();
}

class _PlayAgainLoadingPageState extends State<PlayAgainLoadingPage> {
  void setInitialValues() async {
    await precacheImage(
        AssetImage("lib/images/backgrounds/background-image-edited.png"),
        context);
    await Player.freePlayers();
    Navigator.of(context).pushReplacementNamed('/players_page');
  }

  @override
  void didChangeDependencies() {
    setInitialValues();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(17, 7, 7, 1),
            Color.fromRGBO(40, 7, 7, 1),
          ],
        )),
        child: Center(
          child: SpinKitFadingCircle(
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
