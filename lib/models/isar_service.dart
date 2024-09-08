import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/models/player.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Future<Isar> db;

  IsarService() {
    db = openDB();
  }
  // Future<void> save(String name) async {
  //   final isar = await db;
  //   isar.wr
  // }
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PlayerSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
