import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

class TalkingPage extends StatefulWidget {
  const TalkingPage({super.key});

  @override
  State<TalkingPage> createState() => _TalkingPageState();
}

class _TalkingPageState extends State<TalkingPage> {
  int _start = 60; // Start timer at 10 minutes (600 seconds)
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

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
        child: Text(
          formatTime(_start),
          style: const TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
