import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';

class RemovePlayerTile extends StatelessWidget {
  const RemovePlayerTile(
      {super.key, required this.player, required this.confirmAction});
  final Player player;
  final VoidCallback confirmAction;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: player.uiPlayerStatus == UIPlayerStatus.targetable ? 1 : 0.6,
      child: GestureDetector(
        onTap: confirmAction,
        child: Container(
          color: AppColors.darkBrownColor,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: Text(
                  player.role!.name,
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  player.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Transform.scale(
                        scale: 1,
                        child: Image(
                          image: AssetImage(player.role!.characterImagePath),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 25,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
