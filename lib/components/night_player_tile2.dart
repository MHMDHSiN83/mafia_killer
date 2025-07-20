import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/determine_color.dart';

class IntroNightPlayerTile2 extends StatefulWidget {
  const IntroNightPlayerTile2({
    super.key,
    required this.player,
    required this.isCheckBoxDisable,
    required this.onChanged,
    required this.selected,
    required this.confirmAction,
  });

  final Player player;
  final bool isCheckBoxDisable;
  final Function onChanged;
  final bool selected;
  final VoidCallback confirmAction;

  @override
  State<IntroNightPlayerTile2> createState() => _IntroNightPlayerTile2State();
}

class _IntroNightPlayerTile2State extends State<IntroNightPlayerTile2> {
  String getTileIconPath() {
    if (widget.player.uiPlayerStatus == UIPlayerStatus.targetable) {
      return 'lib/images/icons/target.png';
    } else if (widget.player.playerStatus == PlayerStatus.active ||
        widget.player.playerStatus == PlayerStatus.disable) {
      return 'lib/images/icons/disable.png';
    } else {
      return 'lib/images/icons/skeleton_head.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity:
          widget.player.uiPlayerStatus == UIPlayerStatus.targetable ? 1 : 0.6,
      child: GestureDetector(
        // onTap: widget.player.uiPlayerStatus == UIPlayerStatus.targetable
        // && NightPage.ableToSelectTile
        // ? widget.confirmAction
        // : () {},
        onTap: !widget.isCheckBoxDisable &&
                widget.player.uiPlayerStatus == UIPlayerStatus.targetable &&
                Scenario.currentScenario.ableToSelectTile
            ? () {
                if (Scenario.currentScenario.currentPlayerAtNight!.role!
                    .hasMultiSelection()) {
                  AudioManager.playClickEffect();
                  widget.onChanged(widget.player);
                } else {
                  Logger().d("here");
                  widget.confirmAction();
                }
              }
            : () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              widget.selected ? -4.0 : 0.0,
            ),
          decoration: BoxDecoration(
            color: widget.selected
                ? const Color.fromARGB(255, 40, 50, 86)
                : AppColors.darkBrownColor,
            borderRadius: BorderRadius.circular(12),
          ),
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
                  widget.player.name,
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
                  widget.player.role!.name,
                  style: TextStyle(
                    color: determineColorForPlayerTile(widget.player.role!),
                    fontSize: 11,
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
                      child: Container(
                        height: 25,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Image(
                          image: AssetImage(getTileIconPath()),
                        ),
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
