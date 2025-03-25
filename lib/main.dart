import 'package:flutter/material.dart';
import 'package:mafia_killer/pages/defense_voting_page.dart';
import 'package:mafia_killer/pages/end_game_page.dart';
import 'package:mafia_killer/pages/game_settings_page.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/intro_page.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/beautiful_mind_choose_nostradamus_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/face_off_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/faced_off_role_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/handcuffs_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/reveal_identity_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/silence_of_the_lambs_page.dart';
import 'package:mafia_killer/pages/loading_page.dart';
import 'package:mafia_killer/pages/night_events_page.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/pages/players_page.dart';
import 'package:mafia_killer/pages/regular_voting_page.dart';
import 'package:mafia_killer/pages/role_distribution_page.dart';
import 'package:mafia_killer/pages/role_selection_page.dart';
import 'package:mafia_killer/pages/talking_page.dart';
import 'package:mafia_killer/themes/dark_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(
    const Directionality(
      textDirection: TextDirection.rtl,
      child: MyApp(),
    ),
  );
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
        '/defense_talking_page': (context) => const TalkingPage(),
        '/regular_voting_page': (context) => RegularVotingPage(),
        '/defense_voting_page': (context) => DefenseVotingPage(),
        '/night_events_page': (context) => const NightEventsPage(),
        '/night_page': (context) => const NightPage(),
        '/intro_night_page': (context) => const IntroNightPage(),
        '/last_move_card_page': (context) => LastMoveCardPage(),
        '/reveal_identity_page': (context) => RevealIdentityPage(),
        '/face_off_page': (context) => FaceOffPage(),
        '/faced_off_role_page': (context) => FacedOffRolePage(),
        '/handcuffs_page': (context) => HandcuffsPage(),
        '/silence_of_the_lambs_page': (context) => SilenceOfTheLambsPage(),
        '/beautiful_mind_choose_nostradamus_page': (context) =>
            BeautifulMindChooseNostradamusPage(),
        '/end_game_page': (context) => EndGamePage(),
      },
    );
  }
}
