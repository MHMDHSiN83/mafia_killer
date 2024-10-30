import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightPlayerTile extends StatelessWidget {
  NightPlayerTile({super.key, required this.player, required this.confirmAction});
  Player player;
  VoidCallback confirmAction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  const Expanded(
                    child: Image(
                      image: AssetImage('lib/images/role_characters/doctor.png'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 28,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Image(
                        image: AssetImage(
                          'lib/images/icons/target.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
