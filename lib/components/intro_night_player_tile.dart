import 'package:flutter/material.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class IntroNightPlayerTile extends StatefulWidget {
  const IntroNightPlayerTile({
    super.key,
    required this.player,
    required this.isCheckBoxDisable,
    required this.onChanged,
    required this.selected,
  });

  final Player player;
  final bool isCheckBoxDisable;
  final Function onChanged;
  final bool selected;
  @override
  State<IntroNightPlayerTile> createState() => _IntroNightPlayerTileState();
}

class _IntroNightPlayerTileState extends State<IntroNightPlayerTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage(widget.player.role!.characterImagePath),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Visibility(
                    visible: IntroNightPage.isNostradamusSelecting &&
                        widget.player.role.runtimeType != Nostradamus,
                    child: MyCheckBox(
                      isChecked: widget.selected,
                      onChanged: !widget.isCheckBoxDisable
                          ? (bool? value) {
                              AudioManager().playClickEffect();
                              widget.onChanged(widget.player);
                            }
                          : null,
                      scale: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
