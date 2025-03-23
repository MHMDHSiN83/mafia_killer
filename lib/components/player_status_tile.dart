import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';

class PlayerStatusTile extends StatelessWidget {
  const PlayerStatusTile({super.key, required this.player});
  final Player player;

  String getTileIconPath() {
    if (player.playerStatus == PlayerStatus.active) {
      return 'lib/images/icons/target.png';
    } else if (player.playerStatus == PlayerStatus.disable) {
      return 'lib/images/icons/disable.png';
    } else {
      return 'lib/images/icons/skeleton_head.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> roleDetails = player.role!.roleDetails();
    return Opacity(
      opacity: 1,
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
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                        children: roleDetails
                            .map(
                              (text) => Text(
                                text,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 12,
                                ),
                              ),
                            )
                            .toList()),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Image(
                            image: AssetImage(getTileIconPath()),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
