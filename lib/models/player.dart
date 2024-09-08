import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/models/isar_service.dart';

// dart run build_runner build
part 'player.g.dart';

@collection
class Player extends ChangeNotifier {
  // Player(this._name);
  Player(String name) {
    IsarService();
    _name = name;
  }
  Player.n();
  Id id = Isar.autoIncrement;
  late String _name;
  String get name => _name;
  set name(String? value) {
    if (value != null) {
      _name = value;
    }
    // TODO
    else {
      print("throw null exception");
    }
  }

  bool _doesParticipate = false;
  bool get doesParticipate => _doesParticipate;

  void changeStatus() {
    _doesParticipate = !_doesParticipate;
  }

  Future<void> addPlayer(String name) async {
    final newPlayer = Player(name);
    final isar = await IsarService.db;

    await isar.writeTxnSync(() => isar.players.putSync(newPlayer));
  }

  Stream<List<Player>> listenToPlayers() async* {
    final isar = await IsarService.db;
    yield* isar.players.where().watch(fireImmediately: true);
  }
}
