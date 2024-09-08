import 'package:isar/isar.dart';
import 'package:mafia_killer/models/player.dart';
import 'package:path_provider/path_provider.dart';

class PlayerDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PlayerSchema],
      directory: dir.path,
    );
  }

  final List<Player> players = [];

  Future<void> addPlayer(String name) async {
    final newPlayer = Player(name);
    await isar.writeTxn(() => isar.players.put(newPlayer));

  }
}
