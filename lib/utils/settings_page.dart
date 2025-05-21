import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/confirmation_dialogbox.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

Widget? settingsPage(BuildContext context, int l) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'شروع مجدد روز ${GameStateManager.getCurrentStateNumber()}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: () {
              AudioManager.playClickEffect();
              showDialog(
                context: context,
                builder: (context) => ConfirmationDialogbox(
                  onSave: () {
                    AudioManager.playClickEffect();
                    for (int i = 0; i < l; i++) {
                      Navigator.pop(context);
                    }
                    GameStateManager.goToPreviousState();
                  },
                  onCancel: () {
                    AudioManager.playClickEffect();
                    Navigator.pop(context);
                  },
                ),
              );
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.refresh,
              size: 40,
              color: AppColors.redColor,
            ),
          ),
        ],
      ),
      MyDivider(),
    ],
  );
}
