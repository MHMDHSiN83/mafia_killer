import 'package:flutter/material.dart';
import 'package:mafia_killer/models/role.dart';

import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

Color determineColorForPlayerTile(Role role) {
  Color color;
  switch (role.roleSide) {
    case RoleSide.mafia:
      color = AppColors.redColor;
      break;
    case RoleSide.citizen:
      color = const Color.fromARGB(255, 84, 107, 190);

      break;
    case RoleSide.independant:
      color = const Color(0xFFFAF746);

      break;
  }
  return color;
}

Color determineColorForRoleCard(Role role) {
  Color color;
  switch (role.roleSide) {
    case RoleSide.mafia:
      color = AppColors.redColor;
      break;
    case RoleSide.citizen:
      color = AppColors.blueColor;

      break;
    case RoleSide.independant:
      color = AppColors.yellowColor;

      break;
  }
  return color;
}
