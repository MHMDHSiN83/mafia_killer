import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';

class GodfatherScenario extends Scenario {
  GodfatherScenario() : super("پدرخوانده");
  static Map<NightEvent, Player?> nightEvents = {};
  static List<Player> defendingPlayers = [];
  static Iterable<String> callRolesIntroNight() sync* {
    Player nostradamusPlayer = Player.getPlayerByRoleType(Nostradamus);
    yield nostradamusPlayer.role!.introAwakingRole();
    yield nostradamusPlayer.role!.introSleepRoleText();
    List<String> introMafiaTeamAwakingTexts =
        Scenario.currentScenario.getIntroMafiaTeamAwakingTexts();
    List<Role> introCitizenTeamRoles =
        Scenario.currentScenario.getIntroCitizenTeamRoles();
    IntroNightPage.buttonText = 'بیدار شدند';

    int l = introMafiaTeamAwakingTexts.length;
    for (int i = 0; i < l; i++) {
      yield introMafiaTeamAwakingTexts[i];
      if (i == l - 2) {
        IntroNightPage.buttonText = 'خوابیدند';
      } else {
        IntroNightPage.buttonText = 'نشون داد';
      }
    }
    for (int i = 0; i < introCitizenTeamRoles.length; i++) {
      yield introCitizenTeamRoles[i].introAwakingRole();
      yield introCitizenTeamRoles[i].introSleepRoleText();
    }
    IntroNightPage.isNightOver = true;
    IntroNightPage.buttonText = "";
    yield "همه بیدار شن";
  }

  static void resetUIPlayerStatus() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.active ||
          player.playerStatus == PlayerStatus.disable) {
        player.uiPlayerStatus = UIPlayerStatus.targetable;
      } else {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  static void resetPlayerStatus() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.disable) {
        player.playerStatus = PlayerStatus.active;
      }
    }
  }

  static void setPlayersToUntargetable() {
    for (Player player in Player.inGamePlayers) {
      player.uiPlayerStatus = UIPlayerStatus.untargetable;
    }
  }

  static void setMafiaTeamAvailablePlayers() {
    resetUIPlayerStatus();
    switch (NightPage.mafiaTeamChoice) {
      case 0:
        for (Player player in Player.inGamePlayers) {
          if (player.role! is Godfather) {
            player.uiPlayerStatus = UIPlayerStatus.untargetable;
          }
        }
        break;
      case 1:
        Player player = Player.inGamePlayers
            .where((player) => player.role is Godfather)
            .first;
        player.role!.setAvailablePlayers();
        break;
      case 2:
        Player player = Player.inGamePlayers
            .where((player) => player.role is SaulGoodman)
            .first;
        player.role!.setAvailablePlayers();
        break;
    }
  }

  static String setMafiaChoiceText() {
    List<String> mafiaTeamAct = [
      "تیم مافیا به یک نفر شلیک کنه",
      "پدرخوانده کسی که میخواد امشب سلاخی کنه رو نشون بده و نقششو حدس بزنه",
      "ساول گودمن یک نفر رو خریداره کنه",
    ];
    return mafiaTeamAct[NightPage.mafiaTeamChoice];
  }

  static Iterable<String> mafiaTeamAction(
    Function mafiaChoiceBox,
  ) sync* {
    List<String> mafiaTeamAct = [
      "تیم مافیا به یک نفر شلیک کنه",
      "پدرخوانده کسی که میخواد امشب سلاخی کنه رو نشون بده و نقششو حدس بزنه",
      "ساول گودمن یک نفر رو خریداره کنه"
    ];

    yield "تیم مافیا از خواب بیدار شه";
    NightPage.ableToSelectTile = true;
    NightPage.buttonText = '';
    mafiaChoiceBox();
    yield mafiaTeamAct[NightPage.mafiaTeamChoice];
    NightPage.typeOfConfirmation = 0;
    switch (NightPage.mafiaTeamChoice) {
      case 0: // shot
        nightEvents[NightEvent.shotByMafia] = NightPage.targetPlayer;
        break;
      case 1:
        nightEvents[NightEvent.sixthSensedByGodfather] = NightPage.targetPlayer;
        if (NightPage.targetPlayer != null) {
          NightPage.targetPlayer!.playerStatus = PlayerStatus.disable;
        }
        break;
      case 2: // buying
        NightPage.ableToSelectTile = false;
        NightPage.buttonText = 'اتمام';
        if (NightPage.targetPlayer!.role is Citizen) {
          nightEvents[NightEvent.boughtBySaulGoodman] = NightPage.targetPlayer;
          yield 'خریداری موفقیت آمیز بود. فرد خریداری شده رو بیدار کن تا هم تیمیاشو ببینه';
        } else {
          yield 'خریداری موفقیت امیز نبود. کمی راه برو و اتمام رو بزن';
        }
        break;
    }
  }

  static Iterable<String> otherRolesAction(
    Function noAbilityBox,
  ) sync* {
    List<String> constantRoleOrder =
        Scenario.currentScenario.getConstantRoleOrder();
    NightPage.buttonText = 'خوابید';
    for (int i = 0; i < constantRoleOrder.length; i++) {
      for (Player player in Player.inGamePlayers) {
        if (player.role!.name == constantRoleOrder[i]) {
          NightPage.ableToSelectTile = true;
          resetUIPlayerStatus();
          if (player.hasAbility()) {
            NightPage.buttonText = i <= 1 ? '' : "هیچکس";
            player.role!.setAvailablePlayers();
            yield player.role!.awakingRole();
            player.role!.nightAction(NightPage.targetPlayer);
            NightPage.ableToSelectTile = false;
            NightPage.buttonText = "خوابید";
            yield player.role!.sleepRoleText();
          } else {
            setPlayersToUntargetable();
            if (player.playerStatus == PlayerStatus.disable) {
              noAbilityBox(player.role!.disabledText());
            } else if (!player.role!.hasAbility()) {
              noAbilityBox(player.role!.ranOutOfAbilityText());
            } else {
              noAbilityBox(player.role!.deadOrRemovedText());
            }
            yield player.role!.sleepRoleText();
          }
          break;
        }
      }
    }
  }

  static Iterable<String> callRolesRegularNight(
    Function mafiaChoiceBox,
    Function noAbilityBox,
  ) sync* {
    final iterator = mafiaTeamAction(mafiaChoiceBox).iterator;

    while (iterator.moveNext()) {
      yield iterator.current;
    }

    final otherRolesIterator = otherRolesAction(noAbilityBox).iterator;

    while (otherRolesIterator.moveNext()) {
      yield otherRolesIterator.current;
    }
    NightPage.isNightOver = true;
    NightPage.buttonText = "";
    yield "همه بیدار شن";
    print(nightEvents);
    print(nightReport());
  }

  static String nightReport() {
    String report = "";

    Player? shotByMafia = nightEvents[NightEvent.shotByMafia];
    Player? savedByDoctor = nightEvents[NightEvent.savedByDoctor]!;
    Player? shotByLeon = nightEvents[NightEvent.shotByLeon];
    Player? revivedByConstantine = nightEvents[NightEvent.revivedByConstantine];
    Player? inquiryByCitizenKane = nightEvents[NightEvent.inquiryByCitizenKane];
    Player? sixthSensedByGodfather =
        nightEvents[NightEvent.sixthSensedByGodfather];

    Player leon =
        Player.inGamePlayers.where((player) => player.role is Leon).first;
    Player citizenKane = Player.inGamePlayers
        .where((player) => player.role is CitizenKane)
        .first;

    // mafia shot process -> Done
    if (shotByMafia != null) {
      if (savedByDoctor.name != shotByMafia.name &&
          (shotByMafia.role is! Leon ||
              (shotByMafia.role is Leon &&
                  (shotByMafia.role as Leon).shield <= 0)) &&
          shotByMafia.role is! Nostradamus) {
        shotByMafia.playerStatus = PlayerStatus.dead;
        report += "${shotByMafia.name} کشته شد.\n";
      } else if (shotByMafia.role is Leon &&
          (shotByMafia.role as Leon).shield == 1) {
        (shotByMafia.role as Leon).shield--;
      }
    }

    // mafia sixth sense -> Done
    if (sixthSensedByGodfather != null) {
      // if it isn't null it means it succeeded
      report +=
          "${sixthSensedByGodfather.name} سلاخی شد و از بازی به طور کامل خارج میشود\n";
    }

    // leon shot process -> Done
    if (shotByLeon != null) {
      if (shotByLeon.role!.roleSide == RoleSide.citizen) {
        leon.playerStatus = PlayerStatus.dead;
        report += "${leon.name} کشته شد.\n";
      } else if (shotByLeon.role is! Nostradamus &&
          (shotByLeon.role is! Godfather ||
              (shotByLeon.role is Godfather &&
                  (shotByLeon.role as Godfather).shield <= 0)) &&
          shotByLeon.name != savedByDoctor.name) {
        shotByLeon.playerStatus = PlayerStatus.dead;
        report += "${shotByLeon.name} کشته شد.\n";
      } else if (shotByLeon.role is Godfather &&
          (shotByLeon.role as Godfather).shield == 1) {
        (shotByLeon.role as Godfather).shield--;
      }
    }

    // citizen kane inquiry -> player has to die the next day
    if ((citizenKane.role as CitizenKane).remainingAbility == 0) {
      citizenKane.playerStatus = PlayerStatus.dead;
      report += "${citizenKane.name} کشته شد.\n";
    }
    if (inquiryByCitizenKane != null) {
      if (citizenKane.playerStatus == PlayerStatus.active &&
          inquiryByCitizenKane.playerStatus == PlayerStatus.active) {
        if (inquiryByCitizenKane.role!.roleSide == RoleSide.mafia) {
          report += "${inquiryByCitizenKane.name} مافیای بازی است\n";
        }
        (citizenKane.role as CitizenKane).remainingAbility--;
      }
    }
    // constantine reviving
    if (revivedByConstantine != null) {
      revivedByConstantine.playerStatus = PlayerStatus.active;
      report += "${revivedByConstantine.name} متولد شد.";
    }
    return report;
  }

  static bool ableToSixthSense() {
    Player godfather =
        Player.inGamePlayers.where((player) => player.role is Godfather).first;
    if (godfather.playerStatus == PlayerStatus.active &&
        godfather.hasAbility()) {
      return true;
    }
    return false;
  }

  static bool ableToBuying() {
    if (doesSaulGoodmanParticipate()) {
      Player saulGoodman = Player.inGamePlayers
          .where((player) => player.role is SaulGoodman)
          .first;
      if (saulGoodman.playerStatus == PlayerStatus.active &&
          saulGoodman.hasAbility()) {
        return true;
      }
      return false;
    }
    return false;
  }

  static bool doesSaulGoodmanParticipate() {
    for (Role role in Scenario.currentScenario.inGameRoles) {
      if (role is SaulGoodman) {
        return true;
      }
    }
    return false;
  }

  static int resultOfNostradamusGuess(List<Player> players) {
    int counter = 0;
    for (Player player in players) {
      if (player.role.runtimeType != Godfather &&
          player.role!.roleSide == RoleSide.mafia) {
        counter++;
      }
    }
    return counter;
  }

  static void storeDefendingPlayers(List<Player> players) {
    defendingPlayers = players;
  }
}
