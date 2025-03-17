import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

class EndGamePlayerTile extends StatelessWidget {
  const EndGamePlayerTile(
      {super.key, required this.player, required this.roleSide});

  final Player player;
  final RoleSide roleSide;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: (roleSide == RoleSide.citizen)
            ? AppColors.blueColor
            : (roleSide == RoleSide.mafia)
                ? AppColors.redColor
                : AppColors.yellowColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(player.name), Text(player.role!.name)],
      ),
    );
  }
}
