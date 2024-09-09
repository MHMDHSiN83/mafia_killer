import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/components/row_dropdownbox.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:mafia_killer/models/global.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:provider/provider.dart';

class GameSettingsPage extends StatefulWidget {
  GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  Map<String, dynamic> newGameSettings = {};
  GameSettings? gameSettings;

  @override
  void initState() {
    super.initState();
  }

  void _onItemSelected(String? selectedItem, String varName) {
    setState(() {
      newGameSettings[varName] = selectedItem!;
    });
  }

  void _increaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = newGameSettings[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes >= 9 && seconds >= 50) {
          return;
        }
        if (seconds >= 50) {
          newGameSettings[varName] = '0${minutes + 1}:00';
        } else {
          newGameSettings[varName] = '0$minutes:${seconds + 10}';
        }
      } else {
        if (newGameSettings[varName] == '9') {
          return;
        }
        newGameSettings[varName] =
            (int.parse(newGameSettings[varName]!) + 1).toString();
      }
    });
  }

  void _decreaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = newGameSettings[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes <= 0 && seconds <= 10) {
          return;
        }
        if (seconds <= 0) {
          newGameSettings[varName] = '0${minutes - 1}:50';
        } else if (seconds <= 10) {
          newGameSettings[varName] = '0$minutes:${seconds - 10}0';
        } else {
          newGameSettings[varName] = '0$minutes:${seconds - 10}';
        }
      } else {
        if (newGameSettings[varName] == '1') {
          return;
        }
        newGameSettings[varName] =
            (int.parse(newGameSettings[varName]!) - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments! as Map;
    gameSettings = data['gameSettings'];
    newGameSettings = data['newGameSettings'];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // Color.fromRGBO(17, 7, 7, 1),
            // Color.fromRGBO(40, 7, 7, 1),
            Color(0xFF111111),
            Color(0xFF3F0000)
          ],
        )),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 18,
              child: PageFrame(
                pageTitle: "تنظیمات این دست",
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  children: [
                    RowDropdownBox(
                      title: 'سناریو بازی',
                      options: Scenario.getScenarioNames(),
                      onSelect: _onItemSelected,
                      selectedItem: newGameSettings['scenario'],
                      varName: 'scenario',
                    ),
                    const MyDivider(),
                    RowCounterBox(
                      title: 'فرصت صحبت در روز معارفه',
                      increaseNumber: _increaseNumber,
                      decreaseNumber: _decreaseNumber,
                      number: newGameSettings['introTime'],
                      isTimer: true,
                      varName: 'introTime',
                    ),
                    const MyDivider(),
                    RowCounterBox(
                      title: 'فرصت صحبت کردن در روز',
                      increaseNumber: _increaseNumber,
                      decreaseNumber: _decreaseNumber,
                      number: newGameSettings['mainSpeakTime'],
                      isTimer: true,
                      varName: 'mainSpeakTime',
                    ),
                    const MyDivider(),
                    RowCounterBox(
                      title: 'تعداد استعلام های بازی',
                      increaseNumber: _increaseNumber,
                      decreaseNumber: _decreaseNumber,
                      number: newGameSettings['inquiry'],
                      isTimer: false,
                      varName: 'inquiry',
                    ),
                    const MyDivider(),
                    RowDropdownBox(
                      title: 'صدای گرداننده بازی (راوی)',
                      options: newGameSettings['narrators'],
                      selectedItem: newGameSettings['narrator'],
                      onSelect: _onItemSelected,
                      varName: 'narrator',
                    ),
                    const MyDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'صدای موزیک بازی در شب',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                newGameSettings['playMusic'] =
                                    !newGameSettings['playMusic'];
                              });
                            },
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              newGameSettings['playMusic']
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_off_rounded,
                              size: 40,
                              color: newGameSettings['playMusic']
                                  ? AppColors.greenColor
                                  : AppColors.redColor,
                            )),
                      ],
                    ),
                    const MyDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'افکت‌های صوتی',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              newGameSettings['soundEffect'] =
                                  !newGameSettings['soundEffect'];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: newGameSettings['soundEffect']
                                      ? AppColors.greenColor
                                      : AppColors.redColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              newGameSettings['soundEffect']
                                  ? "فعال"
                                  : "غیرفعال",
                              style: TextStyle(
                                color: newGameSettings['soundEffect']
                                    ? AppColors.greenColor
                                    : AppColors.redColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        GameSettings.updateSettings(
                            gameSettings!, newGameSettings);
                        // Navigator.pushNamed(context, '/intro_page');
                      },
                      icon: Icon(Icons.plus_one),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 12,
                    child: MyOutlinedButton(
                      text: "بعدی",
                      color: AppColors.greenColor,
                      hasIcon: true,
                      isIconRight: true,
                      onTap: () =>
                          Navigator.pushNamed(context, '/game_settings_page'),
                      icon: Icons.keyboard_arrow_right,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 12,
                      child: MyOutlinedButton(
                        text: "قبلی",
                        hasIcon: true,
                        color: AppColors.redColor,
                        onTap: () => Navigator.pop(context),
                        isIconRight: false,
                        icon: Icons.keyboard_arrow_left,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
