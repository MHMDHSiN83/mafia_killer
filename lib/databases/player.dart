import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:provider/provider.dart';

// dart run build_runner build
part 'player.g.dart';

@collection
class Player extends ChangeNotifier {
  Player(this.name) {
    doesParticipate = false;
  }
  Player.static();

  Id id = Isar.autoIncrement;
  late bool doesParticipate;
  late String name;

  // C R E A T E
  static Future<void> addPlayer(String name) async {
    final newPlayer = Player(name);
    final isar = await IsarService.db;
    isar.writeTxnSync(() => isar.players.putSync(newPlayer));
  }

  // R E A D
  static Stream<List<Player>> listenToPlayers() async* {
    final isar = await IsarService.db;
    yield* isar.players.where().watch(fireImmediately: true);
  }

  // U P D A T E
  static Future<void> editPlayerName(Player player, String newName) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      player.name = newName;
      isar.players.putSync(player);
    });
  }

  static Future<void> changePlayerStatus(Player player) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      player.doesParticipate = !player.doesParticipate;
      isar.players.putSync(player);
    });
  }

  // D E L E T E
  static Future<void> deletePlayer(Player player) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      isar.players.deleteSync(player.id);
    });
  }
}
