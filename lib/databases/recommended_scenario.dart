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
      return recommendedScenario['mafia_nights']![Player.inGamePlayers.length];
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
        "godfather.godfather": 1,
        "godfather.saul_goodman": 1,
        "godfather.matador": 1,
        "godfather.mafia": numberOfMafia,
        "godfather.nostradamus": 1,
        "godfather.doctor_watson": 1,
        "godfather.leon": 1,
        "godfather.citizen_kane": 1,
        "godfather.constantine": 1,
        "godfather.citizen": numberOfCitizen,
        "godfather.beautiful_mind": 1,
        "godfather.face_off": 1,
        "godfather.handcuffs": numberOfHandcuff,
        "godfather.reveal_identity": 1,
        "godfather.silence_of_the_lambs": numberOfSilence,
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
        "mafia_nights.godfather": 1,
        "mafia_nights.doctor_lecter": 1,
        "mafia_nights.joker": 1,
        "mafia_nights.mafia": numberOfMafia,
        "mafia_nights.doctor": 1,
        "mafia_nights.professional": 1,
        "mafia_nights.mayor": 1,
        "mafia_nights.detective": 1,
        "mafia_nights.therapist": 1,
        "mafia_nights.die_hard": 1,
        "mafia_nights.citizen": numberOfCitizen,
        "mafia_nights.insomnia": 1,
        "mafia_nights.vertigo": numberOfVertigo,
        "mafia_nights.red_carpet": numberOfRedCarpet,
        "mafia_nights.green_mile": numberOfGreenMile,
        "mafia_nights.final_shot": 1,
        "mafia_nights.beautiful_mind": 1,
        "mafia_nights.great_lie": numberOfGreatLie,
      };
    }
  }
}
