import 'dart:convert';
import 'package:flutter/services.dart';

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
      Map<int, Map<String, int>> combinedMap = {};

      roleDistributions.forEach((playerCount, roleCountList) {
        Map<String, int> roleMap = {};
        for (int i = 0; i < roleCountList.length; i++) {
          roleMap[roles[i]] = roleCountList[i];
        }
        combinedMap[int.parse(playerCount)] = roleMap;
        recommendedScenario[scenario["name"]] = combinedMap;
      });
    }
  }
}
