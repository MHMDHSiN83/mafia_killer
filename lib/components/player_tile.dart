import 'package:flutter/material.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/components/dialogbox.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class PlayerTile extends StatefulWidget {
  Player player;
  PlayerTile({super.key, required this.player});

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  TextEditingController controller = TextEditingController();
  void onChanged(bool? value) async {
    await Player.changePlayerStatus(widget.player);
  }

  void removePlayer() {
    Player.deletePlayer(widget.player);
  }

  void editPlayerName() {
    if (controller.text == "") {
      return;
    }
    // context.read<AppHandler>().editPlayerName(widget.player, controller.text);
    Player.editPlayerName(widget.player, controller.text);
    Navigator.of(context).pop();
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
    return Container(
      decoration: BoxDecoration(
          // color: const Color(0xFF382E2E),
          // border: Border.all(color: Color(0xFF707070), width: 3),
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 3),
          borderRadius: BorderRadius.circular(5)),
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyCheckBox(
                  isChecked: widget.player.doesParticipate,
                  onChanged: onChanged,
                  scale: 1.3,
                ),
                Center(
                  child: Text(
                    widget.player.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 27,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: showEditDialog,
                  icon: Icon(
                    Icons.edit,
                    size: 35,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: removePlayer,
                  icon: const Icon(
                    Icons.delete,
                    size: 35,
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
