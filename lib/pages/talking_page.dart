import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_role_card.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

class TalkingPage extends StatefulWidget {
  const TalkingPage({super.key});

  @override
  State<TalkingPage> createState() => _TalkingPageState();
}

class _TalkingPageState extends State<TalkingPage> {
  double _start = 6;
  late Timer _timer;
  bool _isRunning = false;
  bool _hasStarted = false;
  bool _hasFinished = false;

  // test
  Player player = Player("محمد امین بهاری");
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
  }

  void startAndStopTimer() {
    _hasStarted = true;
    if (!_isRunning) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start -= 1;
        });
      } else {
        setState(() {
          _hasFinished = true;
          _timer.cancel();
          _isRunning = false;
        });
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      if (_hasFinished) {
        _hasStarted = true;
        _hasFinished = false;
        _start = 6;
        startTimer();
      } else {
        _hasStarted = false;
        _start = 6;
      }
    });
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    player.role =
        Scenario.currentScenario.getRolesBySide(RoleSide.independant)[0];
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
        child: Column(
          children: [
            Text(
              Language.formatTime(_start.toInt()),
              style: const TextStyle(fontSize: 48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!_hasFinished)
                  ElevatedButton(
                    onPressed: startAndStopTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning
                          ? AppColors.redColor
                          : AppColors.darkgreenColor,
                      elevation: 12.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        _isRunning ? 'توقف' : 'شروع',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                if (_hasStarted)
                  ElevatedButton(
                    onPressed: resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkgreenColor,
                      elevation: 12.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'شروع مجدد',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
