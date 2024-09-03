import 'package:flutter/material.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/components/row_dropdownbox.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:provider/provider.dart';

class GameSettingsPage extends StatefulWidget {
  GameSettingsPage({super.key});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  var games = {'number1': 'کلاسیک', 'number2': '2', 'number3': '00:30'};

  void _onItemSelected(String? selectedItem, String varName) {
    setState(() {
      games[varName] = selectedItem!;
    });
  }

  void _increaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = games[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes >= 9 && seconds >= 50) {
          return;
        }
        if (seconds >= 50) {
          games[varName] = '0${minutes + 1}:00';
        } else {
          games[varName] = '0$minutes:${seconds + 10}';
        }
      } else {
        if (games[varName] == '9') {
          return;
        }
        games[varName] = (int.parse(games[varName]!) + 1).toString();
      }
    });
  }

  void _decreaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = games[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes <= 0 && seconds <= 10) {
          return;
        }
        if (seconds <= 0) {
          games[varName] = '0${minutes - 1}:50';
        } else if (seconds <= 10) {
          games[varName] = '0$minutes:${seconds - 10}0';
        } else {
          games[varName] = '0$minutes:${seconds - 10}';
        }
      } else {
        if (games[varName] == '0') {
          return;
        }
        games[varName] = (int.parse(games[varName]!) - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mafia Killer",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: RowDropdownBox(
                title: 'سناریو بازی',
                options: context.watch<AppHandler>().scenarios,
                onSelect: _onItemSelected,
                varName: 'number1',
              ),
            ),
            Expanded(
              flex: 1,
              child: RowCounterBox(
                title: 'فرصت صحبت در روز معارفه',
                increaseNumber: _increaseNumber,
                decreaseNumber: _decreaseNumber,
                number: games['number2']!,
                isTimer: true,
                varName: 'number2',
              ),
            ),
            Expanded(
              flex: 1,
              child: RowCounterBox(
                title: 'فرصت صحبت کردن در روز',
                increaseNumber: _increaseNumber,
                decreaseNumber: _decreaseNumber,
                number: games['number3']!,
                isTimer: true,
                varName: 'number3',
              ),
            ),
            Expanded(
              flex: 1,
              child: RowCounterBox(
                title: 'تعداد استعلام های بازی',
                increaseNumber: _increaseNumber,
                decreaseNumber: _decreaseNumber,
                number: games['number3']!,
                isTimer: true,
                varName: 'number4',
              ),
            ),
            Expanded(
              flex: 1,
              child: RowDropdownBox(
                title: 'صدای گرداننده بازی (راوی)',
                options: context.watch<AppHandler>().scenarios,
                onSelect: _onItemSelected,
                varName: 'number1',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
