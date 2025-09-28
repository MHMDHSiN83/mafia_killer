import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class TalkingPage extends StatefulWidget {
  const TalkingPage({super.key});

  @override
  State<TalkingPage> createState() => _TalkingPageState();
}

class _TalkingPageState extends State<TalkingPage> {
  double _start = -1;
  int cnt = 0;
  late Timer _timer;
  bool _isRunning = false;
  bool _hasStarted = false;
  bool _hasFinished = false;
  bool _isClockTickingPlaye = false;

  late TalkingPageScreenArguments args;
  bool isChaos = false;

  @override
  void didChangeDependencies() {
    if (_start == -1) {
      args = ModalRoute.of(context)?.settings.arguments
          as TalkingPageScreenArguments;
      if (Player.getAliveInGamePlayers().length == 3) {
        _start = 300.toDouble();
        isChaos = true;
      } else {
        _start = args.seconds.toDouble();
      }
    }
    super.didChangeDependencies();
  }

  String notTalkingPlayersText() {
    String result = "";
    for (Player player in Scenario.currentScenario.silencedPlayerDuringDay) {
      print("hello ${player.name}");
      result += "${player.name} و ";
    }
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 2);
    }
    result += "امروز نمی‌توانند صحبت کنند!";
    return result;
  }

  //  T I M E R
  void startAndStopTimer() {
    AudioManager.playClickEffect();
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
        if (_start < 6 && !_isClockTickingPlaye) {
          AudioManager.playClockTicking();
          _isClockTickingPlaye = true;
        }
        setState(() {
          _start -= 0.1;
        });
      } else {
        setState(() {
          _hasFinished = true;
          _isClockTickingPlaye = false;
          _timer.cancel();
          _isRunning = false;
        });
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    if (_isClockTickingPlaye) {
      AudioManager.stopClockTicking();
      _isClockTickingPlaye = false;
    }
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    AudioManager.playClickEffect();
    stopTimer();
    setState(() {
      if (_hasFinished) {
        _hasStarted = true;
        _hasFinished = false;
        if (isChaos) {
          _start = 300.toDouble();
        } else {
          _start = args.seconds.toDouble();
        }
        startTimer();
      } else {
        _hasStarted = false;
        if (isChaos) {
          _start = 300.toDouble();
        } else {
          _start = args.seconds.toDouble();
        }
        AudioManager.resetClockTicking();
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
        label: args.isDefense ? '/defense_talking_page' : '/talking_page',
        pageTitle: args.isDefense
            ? 'صحبت دفاعیه'
            : 'روز ${GameStateManager.getCurrentStateNumber()}',
        settingsPage: () {
          return settingsPage(context, args.isDefense ? 4 : 2);
        },
        leftButtonText: args.leftButtonText,
        rightButtonText: args.rightButtonText,
        leftButtonOnTap: () {
          if (!args.isDefense) {
            GameStateManager.goToPreviousState();
          }
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          AudioManager.playNextPageEffect();
          if (isChaos) {
            Scenario.currentScenario.defendingPlayers =
                Player.getAliveInGamePlayers();
            Navigator.pushNamed(context, '/defense_voting_page');
          } else {
            Navigator.pushNamed(context, args.nextPagePath);
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 15,
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (Scenario.currentScenario.silencedPlayerDuringDay
                    .where(
                        (player) => player.playerStatus == PlayerStatus.active)
                    .isNotEmpty &&
                !isChaos)
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: CallRole(
                    text: notTalkingPlayersText(),
                    buttonText: "",
                    onPressed: () {},
                  ),
                ),
              ),
            if (isChaos &&
                !Scenario.currentScenario.silencedPlayerDuringDay
                    .where(
                        (player) => player.playerStatus == PlayerStatus.active)
                    .isNotEmpty)
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: CallRole(
                    text:
                        'بازیکنان پنج دقیقه فرصت دارند با هم صحبت کنند و در نهایت دو نفر با هم هم‌پیمان شوند',
                    buttonText: "",
                    onPressed: () {},
                  ),
                ),
              ),
            if (isChaos &&
                Scenario.currentScenario.silencedPlayerDuringDay
                    .where(
                        (player) => player.playerStatus == PlayerStatus.active)
                    .isNotEmpty)
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: CallRole(
                    text:
                        'بازیکنان پنج دقیقه فرصت دارند با هم صحبت کنند و در نهایت دو نفر با هم هم‌پیمان شوند. \n${notTalkingPlayersText()}',
                    buttonText: "",
                    onPressed: () {},
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
