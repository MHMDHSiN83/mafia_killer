import 'dart:convert';

import 'package:flutter/services.dart';

class ScenarioGuide {
  static Map<String, String>? scenarioGuides;
  static Future<void> getScenarioGuidesFromDatabase() async {
    final String response =
        await rootBundle.loadString('lib/assets/scenario_guide.json');

    final Map<String, dynamic> data = json.decode(response);

    scenarioGuides = data.map((key, value) => MapEntry(key, value.toString()));
  }
}
