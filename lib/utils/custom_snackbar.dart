import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

void customSnackBar(BuildContext context, String message, isBottom) {
  AudioManager.playSnackBarEffect();
  return AnimatedSnackBar(
    mobileSnackBarPosition: isBottom ? MobileSnackBarPosition.bottom : MobileSnackBarPosition.top,
    duration: Duration(seconds: 5),
    builder: ((context) {
      return MaterialAnimatedSnackBar(
        messageText: message,
        type: AnimatedSnackBarType.info,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.amber,
        messageTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 14,
        ),
      );
    }),
  ).show(context);
}
