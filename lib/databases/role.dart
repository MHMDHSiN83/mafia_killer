import 'package:isar/isar.dart';

part 'role.g.dart';

@Collection()
class Role {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late bool isInGame;

  Role(this.name, this.description) {
    isInGame = false;
  }

  void changeRoleStatus(Role role) {}
}
