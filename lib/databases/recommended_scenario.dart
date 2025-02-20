import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
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

  static Map<String, int> getRecommendedScenario() {
    if (Scenario.currentScenario is GodfatherScenario) {
      return recommendedScenario['godfather']![Player.inGamePlayers.length]!;
    } else {
      return recommendedScenario['godfather']![Player.inGamePlayers.length]!;
    }
  }
}
