import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/components/row_dropdownbox.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:provider/provider.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  Map<String, dynamic> gameSettings = {};
  AppHandler handler = AppHandler();
  @override
  void initState() {
    AppHandler handler = context.read<AppHandler>();
    gameSettings = handler.gameSettings;
    super.initState();
  }

  void _onItemSelected(String? selectedItem, String varName) {
    setState(() {
      gameSettings[varName] = selectedItem!;
    });
  }

  void _increaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = gameSettings[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes >= 9 && seconds >= 50) {
          return;
        }
        if (seconds >= 50) {
          gameSettings[varName] = '0${minutes + 1}:00';
        } else {
          gameSettings[varName] = '0$minutes:${seconds + 10}';
        }
      } else {
        if (gameSettings[varName] == '9') {
          return;
        }
        gameSettings[varName] =
            (int.parse(gameSettings[varName]!) + 1).toString();
      }
    });
  }

  void _decreaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = gameSettings[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes <= 0 && seconds <= 10) {
          return;
        }
        if (seconds <= 0) {
          gameSettings[varName] = '0${minutes - 1}:50';
        } else if (seconds <= 10) {
          gameSettings[varName] = '0$minutes:${seconds - 10}0';
        } else {
          gameSettings[varName] = '0$minutes:${seconds - 10}';
        }
      } else {
        if (gameSettings[varName] == '0') {
          return;
        }
        gameSettings[varName] =
            (int.parse(gameSettings[varName]!) - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "تنظیمات این دست",
        rightButtonText: "بعدی",
        leftButtonText: "قبلی",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () => Navigator.pushNamed(context, '/intro_page'),
        //rightButtonIcon: Icons.keyboard_arrow_down_outlined,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          children: [
            RowDropdownBox(
              title: 'سناریو بازی',
              options: handler.scenarios,
              onSelect: _onItemSelected,
              varName: 'scenario',
            ),
            const MyDivider(),
            RowCounterBox(
              title: 'فرصت صحبت در روز معارفه',
              increaseNumber: _increaseNumber,
              decreaseNumber: _decreaseNumber,
              number: gameSettings['introTime']!,
              isTimer: true,
              varName: 'introTime',
            ),
            const MyDivider(),
            RowCounterBox(
              title: 'فرصت صحبت کردن در روز',
              increaseNumber: _increaseNumber,
              decreaseNumber: _decreaseNumber,
              number: gameSettings['mainSpeakTime']!,
              isTimer: true,
              varName: 'mainSpeakTime',
            ),
            const MyDivider(),
            RowCounterBox(
              title: 'تعداد استعلام های بازی',
              increaseNumber: _increaseNumber,
              decreaseNumber: _decreaseNumber,
              number: gameSettings['inquiry']!,
              isTimer: false,
              varName: 'inquiry',
            ),
            const MyDivider(),
            RowDropdownBox(
              title: 'صدای گرداننده بازی (راوی)',
              options: handler.narrators,
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
                        gameSettings['playMusic'] = !gameSettings['playMusic'];
                      });
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      gameSettings['playMusic']
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      size: 40,
                      color: gameSettings['playMusic']
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
                      gameSettings['soundEffect'] =
                          !gameSettings['soundEffect'];
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: gameSettings['soundEffect']
                              ? AppColors.redColor
                              : AppColors.greenColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(
                      gameSettings['soundEffect'] ? "غیرفعال" : "فعال",
                      style: TextStyle(
                        color: gameSettings['soundEffect']
                            ? AppColors.redColor
                            : AppColors.greenColor,
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
