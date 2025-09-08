import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class PlayerTile extends StatefulWidget {
  final Player player;
  final VoidCallback removePlayer;
  final VoidCallback updateInGame;
  const PlayerTile(
      {super.key,
      required this.player,
      required this.removePlayer,
      required this.updateInGame});

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void onChanged(bool? value) async {
    setState(() {
      Player.changePlayerStatus(widget.player);
      AudioManager.playClickEffect();
    });
    widget.updateInGame();
  }

  void editPlayerName() {
    setState(() {
      String text = controller.text.trim();
      if (text == "") {
        customSnackBar(context, 'اسم وارد شده نمی‌تونه خالی باشه', false);
      } else if (text.length > 12) {
        customSnackBar(
            context, 'اسم وارد شده نمی‌تونه بیشتر از ۱۲ کاراکتر باشه', false);
      } else if (widget.player.name != text && Player.doesNameExist(text)) {
        customSnackBar(context, 'اسم وارد شده نمی‌تونه تکراری باشه', false);
      } else {
        Player.editPlayerName(widget.player, text);
      }
      Navigator.of(context).pop();
    });
  }

  void showEditDialog() {
    controller.text = widget.player.name;
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          onSave: editPlayerName,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(true);
      },
      child: Opacity(
        opacity: widget.player.doesParticipate ? 1.0 : 0.6,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF211C37),
              border: Border.all(color: AppColors.redColor, width: 2),
              borderRadius: BorderRadius.circular(15)),
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: MyCheckBox(
                      //     isChecked: widget.player.doesParticipate,
                      //     onChanged: onChanged,
                      //     scale: 1.3,
                      //   ),
                      // ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.player.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: showEditDialog,
                        icon: Icon(
                          Icons.edit,
                          size: 35,
                          color: AppColors.greenColor,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: widget.removePlayer,
                        icon: const Icon(
                          Icons.delete,
                          size: 35,
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
