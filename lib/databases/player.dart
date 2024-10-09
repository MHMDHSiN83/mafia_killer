import 'package:deep_collection/deep_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/role.dart';

// dart run build_runner build
part 'player.g.dart';

@collection
class Player extends ChangeNotifier {
  Player(this.name);
  Player.static(this.name);

  Id id = Isar.autoIncrement;
  bool doesParticipate = false;
  String name;
  Role? role;

  @ignore
  bool seenRole = false;

  static List<Player> players = [];
  static List<Player> inGamePlayers = [];
  // C R E A T E
  static Future<void> addPlayer(String name) async {
    final newPlayer = Player(name);
    final isar = await IsarService.db;
    isar.writeTxnSync(() => isar.players.putSync(newPlayer));
    fetchPlayers();
  }

  // R E A D
  static Stream<List<Player>> listenToPlayers() async* {
    fetchPlayers();
    freePlayers();
    final isar = await IsarService.db;
    yield* isar.players.where().watch(fireImmediately: true);
  }

  static Future<void> fetchPlayers() async {
    final isar = await IsarService.db;
    List<Player> fetchedPlayers = isar.players.where().findAllSync();
    players.clear();
    players.addAll(fetchedPlayers);
  }

  static Future<void> fetchInGamePlayers() async {
    final isar = await IsarService.db;
    List<Player> fetchedPlayers =
        isar.players.filter().doesParticipateEqualTo(true).findAllSync();
    inGamePlayers.clear();
    inGamePlayers.addAll(fetchedPlayers);
  }

  // U P D A T E
  static Future<void> editPlayerName(Player player, String newName) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      player.name = newName;
      isar.players.putSync(player);
    });
    fetchPlayers();
  }

  static Future<void> changePlayerStatus(Player player) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      player.doesParticipate = !player.doesParticipate;
      isar.players.putSync(player);
    });
    fetchPlayers();
  }

  // D E L E T E
  static Future<void> deletePlayer(Player player) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      isar.players.deleteSync(player.id);
    });
    fetchPlayers();
  }

  static Future<List<Player>> distributeRoles() async {
    if (inGamePlayers[0].role != null) {
      return inGamePlayers;
    }
    List<Role> roles = Scenario.currentScenario.inGameRoles.deepCopy();
    roles.shuffle();
    for (int i = 0; i < inGamePlayers.length; i++) {
      inGamePlayers[i].role = roles[i];
    }
    return inGamePlayers;
  }

  static Future<void> updateInGamePlayers(List<Player> newPlayers) async {
    inGamePlayers = newPlayers;
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      isar.players.putAllSync(newPlayers);
    });
  }

  static Future<void> freePlayers() async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      for (Player player in players) {
        player.role = null;
      }
      isar.players.putAllSync(players);
    });
  }
}
