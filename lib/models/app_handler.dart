import 'package:flutter/foundation.dart';
import 'package:mafia_killer/models/player.dart';

class AppHandler extends ChangeNotifier {
  // players page stuff
  List<Player> participants = [];
  List<Player> players = [Player('محمد'), Player('mamad'), Player('amin')];
  List<String> scenarios = <String>['کلاسیک', 'پدرخوانده'];
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
