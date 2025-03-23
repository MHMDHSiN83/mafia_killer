import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/components/row_dropdownbox.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  Map<String, dynamic> newGameSettings = {};

  @override
  void initState() {
    newGameSettings = GameSettings.currentGameSettings.getSettingsInMap();
    super.initState();
  }

  void _onItemSelected(String? selectedItem, String varName) {
    setState(() {
      newGameSettings[varName] = selectedItem!;
    });
  }

  void _increaseNumber(bool isTimer, String varName) {
    setState(() {
      AudioManager.playUpCounterEffect();
      if (isTimer) {
        if (newGameSettings[varName] >= 590) {
          return;
        }
        newGameSettings[varName] += 10;
      } else {
        if (newGameSettings[varName] == 9) {
          return;
        }
        newGameSettings[varName]++;
      }
    });
  }

  void _decreaseNumber(bool isTimer, String varName) {
    setState(() {
      AudioManager.playDownCounterEffect();
      if (isTimer) {
        if (newGameSettings[varName] <= 10) {
          customSnackBar(
              context, 'فرصت صحبت نمی‌تونه کمتر از ۱۰ ثانیه باشه', true);
          return;
        }
        newGameSettings[varName] -= 10;
      } else {
        if (newGameSettings[varName] == 1) {
          customSnackBar(context, 'تعداد استعلام‌ها نمی‌تونه صفر باشه', true);
          return;
        }
        newGameSettings[varName]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger().d("build_gamesetting");
    return Scaffold(
      body: PageFrame(
        label: '/game_setting_page',
        isInGame: false,
        pageTitle: "تنظیمات این دست",
        rightButtonText: "انتخاب نقش‌ها",
        leftButtonText: "بازیکنان",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          GameSettings.updateSettings(
              GameSettings.currentGameSettings, newGameSettings);
          Scenario.currentScenario.getRecommendedScenario();
          AudioManager.playNextPageEffect();
          Logger().d("uppush");

          Navigator.pushNamed(context, '/role_selection_page');
          Logger().d("downpush");
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
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
              number: newGameSettings['introTime']!,
              isTimer: true,
              varName: 'introTime',
            ),
            const MyDivider(),
            RowCounterBox(
              title: 'فرصت صحبت کردن در روز',
              increaseNumber: _increaseNumber,
              decreaseNumber: _decreaseNumber,
              number: newGameSettings['mainSpeakTime']!,
              isTimer: true,
              varName: 'mainSpeakTime',
            ),
            const MyDivider(),
            RowCounterBox(
              title: 'تعداد استعلام های بازی',
              increaseNumber: _increaseNumber,
              decreaseNumber: _decreaseNumber,
              number: newGameSettings['inquiry']!,
              isTimer: false,
              varName: 'inquiry',
              fontSize: 20,
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
                  ),
                ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: newGameSettings['soundEffect']
                              ? AppColors.greenColor
                              : AppColors.redColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(
                      newGameSettings['soundEffect'] ? "غیرفعال" : "فعال",
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
          ],
        ),
      ),
    );
  }
}
