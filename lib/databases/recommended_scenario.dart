import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/mafia_nights_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class RecommendedScenario {
  RecommendedScenario();

  static Map<String, Map<int, Map<String, int>>> recommendedScenario = {};

  static Future<void> getRecommendedScenariosFromDatabase() async {
    final String response =
        await rootBundle.loadString('lib/assets/recommended_scenario.json');

    final data = json.decode(response);
    for (var scenario in data) {
      var roles = scenario['roles'];
      var roleDistributions = scenario['role_distributions'];
      var lastMoveCards = scenario['last_move_cards'];
      var lastMoveCardDistributions = scenario['last_move_card_distributions'];

      Map<int, Map<String, int>> combinedMap = {};

      roleDistributions.forEach((playerCount, roleCountList) {
        Map<String, int> roleMap = {};
        for (int i = 0; i < roleCountList.length; i++) {
          roleMap[roles[i]] = roleCountList[i];
        }
        for (int i = 0;
            i < lastMoveCardDistributions[playerCount].length;
            i++) {
          roleMap[lastMoveCards[i]] = lastMoveCardDistributions[playerCount][i];
        }
        combinedMap[int.parse(playerCount)] = roleMap;
        recommendedScenario[scenario["name"]] = combinedMap;
      });
    }
  }

  static Map<String, int>? getRecommendedScenario() {
    if (Scenario.currentScenario is GodfatherScenario) {
      return recommendedScenario['godfather']![Player.inGamePlayers.length];
    } else if (Scenario.currentScenario is MafiaNightsScenario) {
      return recommendedScenario['mafia_nights']![Player.inGamePlayers.length]!;
    }
    return null;
  }

  static Map<String, int> generateRecommendedScenario() {
    if (Scenario.currentScenario is GodfatherScenario) {
      int numberOfPlayers = Player.inGamePlayers.length;
      int numberOfMafia = (numberOfPlayers ~/ 3) - 3;
      int numberOfCitizen = numberOfPlayers - numberOfMafia - 8;
      int numberOfHandcuff = numberOfPlayers % 4 == 0
          ? (numberOfPlayers ~/ 4) - 2
          : (numberOfPlayers ~/ 4) - 1;
      int numberOfSilence = numberOfPlayers % 4 == 3
          ? (numberOfPlayers ~/ 4) - 1
          : (numberOfPlayers ~/ 4) - 2;
      return {
        "godfather": 1,
        "saul_goodman": 1,
        "matador": 1,
        "mafia": numberOfMafia,
        "nostradamus": 1,
        "doctor_watson": 1,
        "leon": 1,
        "citizen_kane": 1,
        "constantine": 1,
        "citizen": numberOfCitizen,
        "beautiful_mind": 1,
        "face_off": 1,
        "handcuffs": numberOfHandcuff,
        "reveal_identity": 1,
        "silence_of_the_lambs": numberOfSilence,
      };
    } else {
      int numberOfPlayers = Player.inGamePlayers.length;
      int numberOfMafia = (numberOfPlayers ~/ 3) - 3;
      int numberOfCitizen = numberOfPlayers - numberOfMafia - 9;
      int numberOfVertigo = (numberOfPlayers + 4) ~/ 8;
      int numberOfRedCarpet = (numberOfPlayers + 2) ~/ 8;
      int numberOfGreenMile = (numberOfPlayers) ~/ 8;
      int numberOfGreatLie = (numberOfPlayers - 2) ~/ 8;

      return {
        "godfather": 1,
        "doctor_lecter": 1,
        "joker": 1,
        "mafia": numberOfMafia,
        "doctor": 1,
        "professional": 1,
        "mayor": 1,
        "detective": 1,
        "therapist": 1,
        "die_hard": 1,
        "citizen": numberOfCitizen,
        "insomnia": 1,
        "vertigo": numberOfVertigo,
        "red_carpet": numberOfRedCarpet,
        "green_mile": numberOfGreenMile,
        "final_shot": 1,
        "beautiful_mind": 1,
        "great_lie": numberOfGreatLie,
      };
    }
  }
}
