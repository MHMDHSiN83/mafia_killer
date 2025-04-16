import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:mafia_killer/utils/app_info.dart';
import 'package:mafia_killer/utils/update_checker.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void setInitialValues() async {
    await AppInfo.loadAppInfo();
    await UpdateChecker.checkUpdate(context);
    await precacheImage(
        AssetImage("lib/images/backgrounds/background-image-edited.png"),
        context);
    await Database.setInitialValues();
    Navigator.of(context).pushReplacementNamed('/intro_page');
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
