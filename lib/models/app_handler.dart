import 'package:flutter/foundation.dart';
import 'package:mafia_killer/models/player.dart';

class AppHandler extends ChangeNotifier {
  // players page stuff
  List<Player> participants = [];
  List<Player> players = [Player('محمد'), Player('mamad'), Player('amin')];
  List<String> _scenarios = <String>[
    'کلاسیک',
    'پدرخوانده',
  ];
  List<String> get scenarios => _scenarios;

  List<String> _narrators = <String>[
    'کامبیز دیرباز',
    'محمدرضا علیمردانی',
  ];
  List<String> get narrators => _narrators;

  Map<String, dynamic> _gameSettings = {
    'scenario': 'کلاسیک',
    'introTime': '00:30',
    'mainSpeakTime': '02:00',
    'inquiry': '2',
    'narrator': 'کامبیز دیرباز',
    'playMusic': true,
    'soundEffect': true,
  };
  Map<String, dynamic> get gameSettings => _gameSettings;

  bool playMusic = true;
  String a = '2';
  void changePlayerStatus(Player player) {
    player.changeStatus();
    notifyListeners();
  }

  void removePlayer(Player player) {
    players.remove(player);
    notifyListeners();
  }

  void editPlayerName(Player player, String newName) {
    player.name = newName;
    notifyListeners();
  }

  void addPlayer(String name) {
    players.add(Player(name));
    notifyListeners();
  }
}
