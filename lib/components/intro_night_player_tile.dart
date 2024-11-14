import 'package:flutter/material.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';

class IntroNightPlayerTile extends StatefulWidget {
  const IntroNightPlayerTile(
      {super.key, required this.player, required this.confirmAction});
  final Player player;
  final VoidCallback confirmAction;

  @override
  State<IntroNightPlayerTile> createState() => _IntroNightPlayerTileState();
}

class _IntroNightPlayerTileState extends State<IntroNightPlayerTile> {
  bool seleted = false;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity:
          widget.player.uiPlayerStatus == UIPlayerStatus.targetable ? 1 : 0.6,
      child: GestureDetector(
        onTap: widget.player.uiPlayerStatus == UIPlayerStatus.targetable &&
                NightPage.ableToSelectTile
            ? widget.confirmAction
            : () {},
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
                  widget.player.role!.name,
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  widget.player.name,
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
                          image: AssetImage(
                              widget.player.role!.characterImagePath),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: MyCheckBox(
                        isChecked: seleted,
                        onChanged: (bool? value) {
                          setState(() {
                            seleted = !seleted;
                            if(seleted) {
                              IntroNightPage.targetPlayers.add(widget.player);
                            } else {
                              IntroNightPage.targetPlayers.remove(widget.player);
                            }
                          });
                        },
                        scale: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
