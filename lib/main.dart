import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/pages/game_settings_page.dart';
import 'package:mafia_killer/pages/intro_page.dart';
import 'package:mafia_killer/pages/loading_page.dart';
import 'package:mafia_killer/pages/players_page.dart';
import 'package:mafia_killer/pages/role_distribution_page.dart';
import 'package:mafia_killer/pages/role_selection_page.dart';
import 'package:mafia_killer/pages/talking_page.dart';
import 'package:mafia_killer/themes/dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppHandler>(create: (context) => AppHandler()),
      ChangeNotifierProvider<Player>(create: (context) => Player.static()),
    ],
    child: const Directionality(
      textDirection: TextDirection.rtl,
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale(
          "fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      // theme: ThemeData(fontFamily: 'Negar'),
      theme: darkMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/players_page': (context) => const PlayersPage(),
        '/game_settings_page': (context) => const GameSettingsPage(),
        '/loading_page': (context) => const LoadingPage(),
        '/role_selection_page': (context) => RoleSelectionPage(),
        '/role_distribution_page': (context) => const RoleDistributionPage(),
        '/talking_page': (context) => const TalkingPage(),
      },
    );
  }
}
