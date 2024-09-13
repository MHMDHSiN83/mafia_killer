import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/models/isar_service.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        pageTitle: " نفش‌های بازی",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () => Navigator.pushNamed(context, '/loading_page'),
        child: const Column(
          children: [
            Expanded(
              flex: 1,
              child: Text("data"),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // Expanded(
                  // flex: 1,
                  // child: ListView.builder(itemBuilder: itemBuilder),
                  // ),
                  // Expanded(flex: 1, child: ListView.builder(itemBuilder: ,),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
