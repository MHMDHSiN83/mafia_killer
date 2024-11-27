import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/face_off.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/handcuffs.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/silence_of_the_lambs.dart';

class LastMoveCard {
  late String title;
  late String description;
  late String imagePath;

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
      'imagePath': imagePath,
    };
  }
}
