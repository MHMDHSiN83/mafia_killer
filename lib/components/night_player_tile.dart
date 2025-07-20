import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/determine_color.dart';

class NightPlayerTile extends StatefulWidget {
  const NightPlayerTile(
      {super.key, required this.player, required this.confirmAction});
  final Player player;
  final VoidCallback confirmAction;

  @override
  State<NightPlayerTile> createState() => _NightPlayerTileState();
}

class _NightPlayerTileState extends State<NightPlayerTile> {
  bool isSelected = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        isSelected = !isSelected;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
        onTap: widget.player.uiPlayerStatus == UIPlayerStatus.targetable 
        // && NightPage.ableToSelectTile
            ? widget.confirmAction
            : () {},
        child: Container(
          color: AppColors.darkBrownColor,
          child: Column(
            children: [
              const Spacer(flex: 1),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
