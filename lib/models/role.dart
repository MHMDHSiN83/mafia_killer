import 'package:isar/isar.dart';
import 'package:mafia_killer/models/role_side.dart';

class Role {
  late String name;
  late String description;
  late bool isInGame;
  late String imagePath;
  late RoleSide roleSide;
  late int counter;

  Role(this.name, this.description, this.roleSide, this.counter,
      this.imagePath) {
    isInGame = false;
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      json['name'],
      json['description'],
      RoleSide.values
          .firstWhere((e) => e.toString().split('.').last == json['roleSide']),
      json['counter'],
      json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'roleSide': roleSide.toString().split('.').last,
      'counter': counter,
      'imagePath': imagePath,
    };
  }

  void changeRoleStatus(Role role) {}
}
