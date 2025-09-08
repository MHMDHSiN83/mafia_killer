import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/classic/classic_scenario.dart';
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
        for (int i = 0; i < lastMoveCardDistributions[playerCount].length; i++) {
          roleMap[lastMoveCards[i]] = lastMoveCardDistributions[playerCount][i];
        }
        combinedMap[int.parse(playerCount)] = roleMap;
        recommendedScenario[scenario["name"]] = combinedMap;
      });

    }
  }

  static Map<String, int>? getRecommendedScenario() {
    Logger().d(recommendedScenario.length);
    if (Scenario.currentScenario is GodfatherScenario) {
      return recommendedScenario['godfather']![Player.inGamePlayers.length];
    } else if(Scenario.currentScenario is ClassicScenario){
      return recommendedScenario['classic']![Player.inGamePlayers.length]!;
    }
    return null;
  }
  static Map<String, int> generateRecommendedScenario() {
    if (Scenario.currentScenario is GodfatherScenario) {
      int numberOfPlayers = Player.inGamePlayers.length;
      int numberOfMafia = (numberOfPlayers ~/ 3) - 3;
      int numberOfCitizen = numberOfPlayers - numberOfMafia - 8;
      int numberOfHandcuff = numberOfPlayers % 4 == 0 ? (numberOfPlayers ~/ 4) - 2 : (numberOfPlayers ~/ 4) - 1;
      int numberOfSilence = numberOfPlayers % 4 == 3 ? (numberOfPlayers ~/ 4) - 1 : (numberOfPlayers ~/ 4) - 2;
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
      return {};
    }
  }
}
