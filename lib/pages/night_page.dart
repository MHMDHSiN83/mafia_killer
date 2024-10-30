import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';

class NightPage extends StatefulWidget {
  const NightPage({super.key});
  static Player? targetPlayer;
  static late int mafiaTeamChoice;

  @override
  State<NightPage> createState() => _NightPageState();
}

class _NightPageState extends State<NightPage> {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicDialogBox() {
    // show a dialog
    // set mafiaTeamChoic value
    // call setState{iterator.moveNext()}
    throw UnimplementedError();
  }

  void confirmAction() {}

  @override
  void initState() {
    iterator = GodfatherScenario.callRolesRegularNight(
            mafiaChoicDialogBox, confirmAction, confirmAction, confirmAction)
        .iterator;
    iterator.moveNext();
    text = iterator.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageFrame(
      pageTitle: "تنظیمات این دست",
      rightButtonText: "بعدی",
      leftButtonText: "قبلی",
      leftButtonOnTap: () => Navigator.pop(context),
      rightButtonOnTap: () =>
          Navigator.pushNamed(context, '/role_selection_page'),
      child: Center(
        child: Column(
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (iterator.moveNext()) {
                      text = iterator.current;
                    }
                  });
                },
                child: const Text("next")),
          ],
        ),
      ),
    ));
  }
}
