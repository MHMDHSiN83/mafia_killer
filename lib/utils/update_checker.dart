import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:mafia_killer/utils/app_info.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  static bool isUpdateAvilable = false;
  static void openBazaarPage(BuildContext context) async {
    final url = 'bazaar://details/modal?id=${AppInfo.packageName}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      customSnackBar(
          context, 'اتصال برقرار نشد. از بازار بازی رو آپدیت کن!', true);
    }
  }

  static Future<String?> getLatestVersion(BuildContext context) async {
    final url = Uri.parse('https://mhmdhsin83.github.io/');
    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final h1 = document.querySelector('h1');
        return h1?.text ?? AppInfo.fullVersion;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      return AppInfo.fullVersion;
    }
  }

  static Future<bool> checkUpdate(BuildContext context) async {
    String? version = await getLatestVersion(context);
    if (version == AppInfo.fullVersion) {
      isUpdateAvilable = false;
    } else {
      isUpdateAvilable = true;
    }
    return isUpdateAvilable;
  }
}
