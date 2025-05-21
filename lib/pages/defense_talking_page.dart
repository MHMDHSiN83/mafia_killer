import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class DefenseTalkingPage extends StatefulWidget {
  const DefenseTalkingPage({super.key});

  @override
  State<DefenseTalkingPage> createState() => _DefenseTalkingPageState();
}

class _DefenseTalkingPageState extends State<DefenseTalkingPage> {
  late double _start;
  int cnt = 0;
  late Timer _timer;
  bool _isRunning = false;
  bool _hasStarted = false;
  bool _hasFinished = false;

  late TalkingPageScreenArguments args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments
        as TalkingPageScreenArguments;
    _start = args.seconds.toDouble();

    super.didChangeDependencies();
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
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_start > 0) {
        setState(() {
          _start -= 0.1;
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
        _start = args.seconds.toDouble();
        startTimer();
      } else {
        _hasStarted = false;
        _start = args.seconds.toDouble();
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: 'روز ${GameStateManager.getCurrentStateNumber()}',
        leftButtonText:
            'شب ${GameStateManager.getPreviousState()}',
        rightButtonText: 'رای گیری',
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          AudioManager.playNextPageEffect();
          Navigator.pushNamed(context, args.nextPagePath);
        },
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(fit: StackFit.expand, children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child: Text(
                          Language.toPersian(
                              Language.formatTime(_start.toInt())),
                          style: const TextStyle(fontSize: 60),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.75,
                        heightFactor: 0.75,
                        child: CircularProgressIndicator(
                          value: _start / args.seconds,
                          valueColor: const AlwaysStoppedAnimation(
                              AppColors.greenColor),
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          strokeWidth: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    'lib/images/backgrounds/alarm-clock.png',
                    scale: 0.5,
                    fit: BoxFit.fitWidth,
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 20,
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
