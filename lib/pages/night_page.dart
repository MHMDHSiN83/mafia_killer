import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';

class NightPage extends StatefulWidget {
  const NightPage({super.key});

  @override
  State<NightPage> createState() => _NightPageState();
}

class _NightPageState extends State<NightPage> {
  final iterator = GodfatherScenario.callRolesRegularNight().iterator;
  late String text;

  @override
  void initState() {
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
