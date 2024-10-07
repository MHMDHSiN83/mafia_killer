import 'package:isar/isar.dart';
import 'package:mafia_killer/models/role_side.dart';

part 'role.g.dart';

@embedded
class Role {
  late String name;
  late String description;
  late String imagePath;
  @Enumerated(EnumType.ordinal32)
  late RoleSide roleSide;

  // Role(this.name, this.description, this.roleSide, this.counter,
  //     this.imagePath) {
  //   isInGame = false;
  // }
  Role();
  factory Role.copy(Role role) {
    Role newRole = Role();
    newRole.name = role.name;
    newRole.description = role.description;
    newRole.imagePath = role.imagePath;
    newRole.roleSide = role.roleSide;
    return newRole;
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    // return Role(
    //   json['name'],
    //   json['description'],
    //   RoleSide.values
    //       .firstWhere((e) => e.toString().split('.').last == json['roleSide']),
    //   json['counter'],
    //   json['imagePath'],
    // );
    Role role = Role();
    role.name = json['name'];
    role.description = json['description'];
    role.roleSide = RoleSide.values
        .firstWhere((e) => e.toString().split('.').last == json['roleSide']);
    role.imagePath = json['imagePath'];
    return role;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'roleSide': roleSide.toString().split('.').last,
      'imagePath': imagePath,
    };
  }

  void changeRoleStatus(Role role) {}
}
