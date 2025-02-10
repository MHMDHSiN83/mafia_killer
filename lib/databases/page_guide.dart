import 'dart:convert';
import 'package:flutter/services.dart';

class PageGuide {
  PageGuide();

  static Map<String, String>? pageGuides;

  static Future<void> getGuidesFromDatabase() async {
    final String response =
        await rootBundle.loadString('lib/assets/guide.json');

    final Map<String, dynamic> data = json.decode(response);

    pageGuides = data.map((key, value) => MapEntry(key, value.toString()));
  }
}
