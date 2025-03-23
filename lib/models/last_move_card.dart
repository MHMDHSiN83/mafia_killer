import 'dart:convert';

import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/face_off.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/handcuffs.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/silence_of_the_lambs.dart';

class LastMoveCard {
  late String title;
  late String description;
  late String imagePath;
  late String flippedImagePath;
  late String selectionImagePath;
  bool isUsed = false;

  LastMoveCard();

  factory LastMoveCard.fromJson(Map<String, dynamic> json) {
    switch (json['title']) {
      case "سکوت بره‌ها":
        return SilenceOfTheLambs.fromJson(json);
      case "دستبند":
        return Handcuffs.fromJson(json);
      case "تغییر چهره":
        return FaceOff.fromJson(json);
      case "ذهن زیبا":
        return BeautifulMind.fromJson(json);
      case "افشای هویت":
        return RevealIdentity.fromJson(json);
    }
    throw Exception("salam");
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'selectionImagePath': selectionImagePath,
      'flippedImagePath': flippedImagePath,
      'imagePath': imagePath,
      'isUsed': isUsed,
    };
  }

  factory LastMoveCard.copy(LastMoveCard lastMoveCard) {
    return LastMoveCard.fromJson(jsonDecode(jsonEncode(lastMoveCard.toJson())));
  }

  double titleVerticalPadding() {
    return 15;
  }

  double descriptionVerticalPadding() {
    return 30;
  }

  int titleHorizontalRatio() {
    throw Exception();
  }

  int rightSpaceOfTitleHorizontalRatio() {
    throw Exception();
  }

  // two above methods are related to each other so be aware when you're changing one of them

  int descriptionHorizontalRatio() {
    throw Exception();
  }

  void lastMoveCardAction(List<Player> players) {
    throw Exception("no action defined for last move card!");
  }
}
