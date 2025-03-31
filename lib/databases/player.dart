import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:path_provider/path_provider.dart';

// dart run build_runner build
part 'player.g.dart';

@JsonSerializable()
class Player extends ChangeNotifier {
  Player(this.name);
  Player.static(this.name);

  // Id id = Isar.autoIncrement;
  bool doesParticipate = false;
  String name;
  Role? role;

  // @Enumerated(EnumType.ordinal32)
  UIPlayerStatus uiPlayerStatus = UIPlayerStatus.targetable; // it's for UI

  PlayerStatus playerStatus = PlayerStatus.active;

  // @ignore
  bool seenRole = false;

  static List<Player> players = [];
  static List<Player> inGamePlayers = [];
  static late String filePath;

  factory Player.copy(Player? player) {
    return Player.fromJson(jsonDecode(jsonEncode(player!.toJson())));
  }

  static List<Player> copyList(List<Player> players) {
    return players.map((player) => Player.copy(player)).toList();
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  // Generated method to convert an object to JSON
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/players.json';
  }

  static Future<void> getPlayersFromDatabase() async {
    filePath = await getFilePath();
    final file = File(filePath);
    if (!(await file.exists())) {
      String jsonString =
          await rootBundle.loadString('lib/assets/players.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      players = jsonData.map((player) => Player.fromJson(player)).toList();
      await file.writeAsString(jsonString);
      print('Asset copied to $filePath');
    } else {
      print('File already exists in internal storage');
      String jsonString = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(jsonString);
      try {
        jsonData = jsonDecode(jsonString);
      } catch (e) {
        String jsonString =
            await rootBundle.loadString('lib/assets/scenarios.json');
        jsonData = jsonDecode(jsonString);
      }
      players = jsonData.map((player) => Player.fromJson(player)).toList();
    }
  }

  // C R E A T E
  static Future<void> addPlayer(String name) async {
    players.add(Player(name));
    Database.writePlayersData(players);
  }

  // R E A D

  static Future<void> fetchInGamePlayers() async {
    inGamePlayers = [];
    for (Player player in players) {
      if (player.doesParticipate) {
        inGamePlayers.add(player);
      }
    }
  }

  static List<Player> getAliveInGamePlayers() {
    List<Player> aliveInGamePlayers = [];
    for (Player player in inGamePlayers) {
      if (player.playerStatus != PlayerStatus.dead &&
          player.playerStatus != PlayerStatus.removed) {
        aliveInGamePlayers.add(player);
      }
    }
    return aliveInGamePlayers;
  }

  // U P D A T E
  static Future<void> editPlayerName(Player player, String newName) async {
    for (Player p in players) {
      if (p.name == player.name) {
        p.name = newName;
      }
    }
    Database.writePlayersData(players);
  }

  static Future<void> changePlayerStatus(Player player) async {
    for (Player p in players) {
      if (p.name == player.name) {
        p.doesParticipate = !p.doesParticipate;
      }
    }
    Database.writePlayersData(players);
  }

  // D E L E T E
  static Future<void> deletePlayer(Player player) async {
    for (int i = 0; i < players.length; i++) {
      if (players[i].name == player.name) {
        players.removeAt(i);
      }
    }
    Database.writePlayersData(players);
  }

  static List<Player> distributeRoles() {
    if (inGamePlayers[0].role != null) {
      return inGamePlayers;
    }
    List<Role> roles = Role.copyList(Scenario.currentScenario.inGameRoles);
    roles.shuffle();
    for (int i = 0; i < inGamePlayers.length; i++) {
      inGamePlayers[i].role = roles[i];
    }
    return inGamePlayers;
  }

  static Future<void> updateInGamePlayers(List<Player> newPlayers) async {
    inGamePlayers = newPlayers;
    Database.writePlayersData(players);
  }

  static Future<void> freePlayers() async {
    for (Player player in players) {
      player.role = null;
      player.seenRole = false;
      player.playerStatus = PlayerStatus.active;
      player.uiPlayerStatus = UIPlayerStatus.targetable;
    }
    Database.writePlayersData(players);
  }

  bool hasAbility() {
    return playerStatus == PlayerStatus.active && role!.hasAbility();
  }

  static Player? getPlayerByRoleType(Type type) {
    if (inGamePlayers
        .where((player) => player.role.runtimeType == type)
        .isEmpty) {
      return null;
    }
    return inGamePlayers
        .where((player) => player.role.runtimeType == type)
        .first;
  }

  static List<Player>? getPlayersByRoleSide(RoleSide roleSide) {
    return inGamePlayers
        .where((player) => player.role!.roleSide == roleSide)
        .toList();
  }

  static Player getPlayerByName(String name) {
    return inGamePlayers.where((player) => player.name == name).first;
  }

  static List<Player> getPlayersByName(List<String> names) {
    List<Player> result = [];
    for (Player p in Player.inGamePlayers) {
      for (String name in names) {
        if (p.name == name) {
          result.add(p);
          continue;
        }
      }
    }
    return result;
  }

  static List<String> getPlayerNames(List<Player> players) {
    return players.map((player) => player.name).toList();
  }

  static bool doesNameExist(String name) {
    for (Player player in players) {
      if (name == player.name) {
        return true;
      }
    }
    return false;
  }

  static List<Player> getAlivePlayersExcept(Player player) {
    return Player.inGamePlayers
        .where((p) =>
            (p.playerStatus == PlayerStatus.active && player.name != p.name))
        .toList();
  }
}
