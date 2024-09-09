import 'package:flutter/material.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/pages/game_settings_page.dart';
import 'package:mafia_killer/pages/intro_page.dart';
import 'package:mafia_killer/pages/loading_page.dart';
import 'package:mafia_killer/pages/players_page.dart';
import 'package:mafia_killer/themes/dark_mode.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // await setDefaultValueToDatabase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppHandler>(create: (context) => AppHandler()),
      ChangeNotifierProvider<Player>(create: (context) => Player.static()),
    ],
    child: Directionality(
      child: MyApp(),
      textDirection: TextDirection.rtl,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      // theme: ThemeData(fontFamily: 'Negar'),
      theme: darkMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/players_page': (context) => PlayersPage(),
        '/game_settings_page': (context) => GameSettingsPage(),
        '/loading_page': (context) => LoadingPage(),
      },
    );
  }
}
