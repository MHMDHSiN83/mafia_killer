import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

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
