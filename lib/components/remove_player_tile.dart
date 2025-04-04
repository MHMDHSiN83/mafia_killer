import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/determine_color.dart';

class RemovePlayerTile extends StatelessWidget {
  const RemovePlayerTile(
      {super.key, required this.player, required this.confirmAction});
  final Player player;
  final VoidCallback confirmAction;

  @override
  Widget build(BuildContext context) {
    bool isPlayerAlive = (player.playerStatus == PlayerStatus.active ||
        player.playerStatus == PlayerStatus.disable);
    return Opacity(
      opacity: isPlayerAlive ? 1 : 0.6,
      child: GestureDetector(
        onTap: (isPlayerAlive) ? confirmAction : () {},
        child: Container(
          color: AppColors.darkBrownColor,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: AutoSizeText(
                  minFontSize: 10,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  player.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: AutoSizeText(
                  minFontSize: 10,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  player.role!.name,
                  style: TextStyle(
                    color: determineColorForPlayerTile(player.role!),
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
                    if (isPlayerAlive)
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
                    if (!isPlayerAlive)
                      Expanded(
                        flex: 3,
                        child: Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Image(
                                image: AssetImage(
                                    'lib/images/icons/skeleton_head.png'))),
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
