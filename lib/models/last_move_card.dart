import 'dart:convert';

import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/final_shot.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/great_lie.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/green_mile.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/insomnia.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/red_carpet.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/vertigo.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/beautiful_mind.dart'
    as classic;

import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart'
    as godfather;
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
  late String slug;

  LastMoveCard();

  factory LastMoveCard.fromJson(Map<String, dynamic> json) {
    switch (json['slug']) {
      case "godfather.silence_of_the_lambs":
        return SilenceOfTheLambs.fromJson(json);
      case "godfather.handcuffs":
        return Handcuffs.fromJson(json);
      case "godfather.face_off":
        return FaceOff.fromJson(json);
      case "godfather.beautiful_mind":
        return godfather.BeautifulMind.fromJson(json);
      case "godfather.reveal_identity":
        return RevealIdentity.fromJson(json);

      case "classic.insomnia":
        return Insomnia.fromJson(json);
      case "classic.vertigo":
        return Vertigo.fromJson(json);
      case "classic.red_carpet":
        return RedCarpet.fromJson(json);
      case "classic.green_mile":
        return GreenMile.fromJson(json);
      case "classic.final_shot":
        return FinalShot.fromJson(json);
      case "classic.beautiful_mind":
        return classic.BeautifulMind.fromJson(json);
      case "classic.great_lie":
        return GreatLie.fromJson(json);
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

  static List<LastMoveCard> copyList(List<LastMoveCard> lastMoveCards) {
    return lastMoveCards
        .map((lastMoveCard) => LastMoveCard.copy(lastMoveCard))
        .toList();
  }

  static LastMoveCard getLastMoveCardByTitle(String title) {
    return Scenario.currentScenario.inGameLastMoveCards
        .where((lastMoveCard) => lastMoveCard.title == title)
        .first;
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

  void undoLastMoveCardAction(List<Player> players) {
    throw UnimplementedError();
  }
}
