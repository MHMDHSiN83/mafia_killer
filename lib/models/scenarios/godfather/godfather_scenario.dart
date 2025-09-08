import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/matador.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';

part 'godfather_scenario.g.dart';

@JsonSerializable()
class GodfatherScenario extends Scenario {
  GodfatherScenario() : super();

  factory GodfatherScenario.fromJson(Map<String, dynamic> json) =>
      _$GodfatherScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GodfatherScenarioToJson(this);

  @override
  String validateConditions() {
    String error = super.validateConditions();

    if (error != '') {
      return error;
    }

    int mafiaCount = getNumberOfRoleBySide(RoleSide.mafia);
    int citizenCount = getNumberOfRoleBySide(RoleSide.citizen);
    int independantCount = getNumberOfRoleBySide(RoleSide.independant);

    if (citizenCount + independantCount <= mafiaCount) {
      error = 'تعداد مافیاها باید از مجموع شهروندها و نوستراداموس کمتر باشه';
      return error;
    }

    if (!doesNostradamusParticipate() && doesBeautifulMindParticipate()) {
      error = 'وقتی نوستراداموس توی بازی نیست، کارت ذهن زیبا قابل استفاده نیست';
      return error;
    }
    return error;
  }

  void nostradamusRevealed() {
    for (LastMoveCard lastMoveCard
        in Scenario.currentScenario.inGameLastMoveCards) {
      if (lastMoveCard is BeautifulMind) {
        lastMoveCard.isUsed = true;
      }
    }
  }

  void resetSilencedPlayersBeforeLastMoveCardPage() {
    Scenario.currentScenario.silencedPlayerDuringDay = [];
  }

  @override
  Iterable<String> callRolesIntroNight({Function? independantBox}) sync* {
    if (doesNostradamusParticipate()) {
      Player? nostradamusPlayer = Player.getPlayerByRoleType(Nostradamus);
      nostradamusPlayer!.role!.setAvailablePlayers();
      currentPlayerAtNight = nostradamusPlayer;
      while (true) {
        yield nostradamusPlayer.role!.introAwakingRole();
        if (IntroNightPage.targetPlayers.length ==
            (nostradamusPlayer.role as Nostradamus).inquiryNumber) {
          independantBox!(
              resultOfNostradamusGuess(IntroNightPage.targetPlayers));
          break;
        }
      }
      ableToSelectTile = false;
      yield nostradamusPlayer.role!.introSleepRoleText();
    }

    ableToSelectTile = false;
    currentPlayerAtNight = Player.inGamePlayers.first;
    resetUIPlayerStatus();

    List<String> introMafiaTeamAwakingTexts = getIntroMafiaTeamAwakingTexts();
    List<Role> introCitizenTeamRoles = getIntroCitizenTeamRoles();
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

  @override
  List<String> getIntroMafiaTeamAwakingTexts() {
    List<String> introMafiaTeamAwakingTexts = [
      "تیم مافیا بیدار شن و همدیگه رو بشناسن",
    ];
    Role? godfather = getRoleByType(Godfather);
    Role? matador = getRoleByType(Matador);
    Role? saulGoodman = getRoleByType(SaulGoodman);
    Role? theMafia = getRoleByType(Mafia);
    if (godfather != null) {
      introMafiaTeamAwakingTexts.add(godfather.introAwakingRole());
    }
    if (matador != null) {
      introMafiaTeamAwakingTexts.add(matador.introAwakingRole());
    }
    if (saulGoodman != null) {
      introMafiaTeamAwakingTexts.add(saulGoodman.introAwakingRole());
    }
    if (theMafia != null) {
      introMafiaTeamAwakingTexts.add(theMafia.introAwakingRole());
    }
    introMafiaTeamAwakingTexts.add("تیم مافیا بخوابه");
    return introMafiaTeamAwakingTexts;
  }

  @override
  List<Role> getIntroCitizenTeamRoles() {
    List<Role> citizenRoles = [];
    for (Role role in inGameRoles) {
      if (role is DoctorWatson) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Leon) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is CitizenKane) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Constantine) {
        citizenRoles.add(role);
        break;
      }
    }
    return citizenRoles;
  }

  @override
  void setMafiaTeamAvailablePlayers() {
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

  String getMafiaChoiceText() {
    List<String> mafiaTeamAct = [
      "تیم مافیا به یک نفر شلیک کنه",
      "پدرخوانده کسی که میخواد امشب سلاخی کنه رو نشون بده و نقششو حدس بزنه",
      "ساول گودمن یک نفر رو خریداره کنه",
    ];
    return mafiaTeamAct[NightPage.mafiaTeamChoice];
  }

  @override
  Iterable<String> mafiaTeamAction({Function? mafiaChoiceBox, Function? noAbilityBox}) sync* {
    yield "تیم مافیا از خواب بیدار شه";
    ableToSelectTile = true;
    NightPage.buttonText = '';
    mafiaChoiceBox!();
    yield "تیم مافیا از خواب بیدار شه";
    yield getMafiaChoiceText();
    NightPage.typeOfConfirmation = 0;
    Player? godfatherPlayer = Player.getPlayerByRoleType(Godfather);
    Player? saulGoodmanPlayer = Player.getPlayerByRoleType(SaulGoodman);
    switch (NightPage.mafiaTeamChoice) {
      case 0: // shot
        nightEvents[NightEvent.shotByMafia] = [NightPage.targetPlayers[0]];
        break;
      case 1: // sixth sense
        godfatherPlayer?.role!.nightAction(
          NightPage.targetPlayers.isEmpty ? null : NightPage.targetPlayers[0],
        );
        if (NightPage.targetPlayers.isNotEmpty) {
          NightPage.targetPlayers[0].playerStatus = PlayerStatus.disable;
        }
        break;
      case 2: // buying
        ableToSelectTile = false;
        NightPage.buttonText = 'اتمام';
        saulGoodmanPlayer?.role!.nightAction(NightPage.targetPlayers[0]);
        if (NightPage.targetPlayers[0].role is Citizen) {
          NightPage.targetPlayers[0].role = Role.copy(Scenario.currentScenario
              .getRoleByType(Mafia, searchInGmaeRoles: false)!);
          yield 'خریداری موفقیت آمیز بود. فرد خریداری شده رو بیدار کن تا هم تیمیاشو ببینه';
        } else {
          yield 'خریداری موفقیت امیز نبود. کمی راه برو و اتمام رو بزن';
        }
        break;
    }
    if (Player.getPlayerByRoleType(Matador) == null) {
      NightPage.buttonText = 'خوابید';
      ableToSelectTile = false;
      yield 'تیم مافیا بخوابه';
    }
  }

  @override
  List<String> getOtherRoleOrder() {
    List<String> constantRoleOrder = [
      'ماتادور',
      'دکتر واتسون',
      'لئون حرفه‌ای',
      'همشهری کین',
      'کنستانتین'
    ];
    return constantRoleOrder;
  }

  @override
  Iterable<String> otherRolesAction({Function? noAbilityBox}) sync* {
    List<String> constantRoleOrder = getOtherRoleOrder();
    NightPage.buttonText = 'خوابید';

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null) {
        continue;
      }

      ableToSelectTile = true;
      resetUIPlayerStatus();
      player.role!.setAvailablePlayers();
      if (player.hasAbility()) {
        NightPage.buttonText = i <= 1 ? '' : "هیچکس";
        currentPlayerAtNight = player;
        if (player.role!.hasMultiSelection()) {
          NightPage.buttonText = "تائید";
        }
        yield player.role!.awakingRole();
        for (Player p in NightPage.targetPlayers) {
          player.role!.nightAction(p);
        }
        ableToSelectTile = false;
        NightPage.buttonText = "خوابید";
        yield player.role!.sleepRoleText();
      } else {
        setPlayersToUntargetable();
        if (player.playerStatus == PlayerStatus.disable) {
          noAbilityBox!(player.role!.disabledText());
        } else if (!player.role!.hasAbility()) {
          noAbilityBox!(player.role!.ranOutOfAbilityText());
        } else {
          noAbilityBox!(player.role!.deadOrRemovedText());
        }
        yield player.role!.sleepRoleText();
      }
    }
  }

  @override
  Iterable<String> callRolesRegularNight(
      {Function? mafiaChoiceBox,
      Function? noAbilityBox,
      Function? dieHardBox}) sync* {
    Scenario.currentScenario.currentPlayerAtNight = Player.inGamePlayers.first;
    final iterator = mafiaTeamAction(mafiaChoiceBox: mafiaChoiceBox!).iterator;

    while (iterator.moveNext()) {
      yield iterator.current;
    }

    final otherRolesIterator =
        otherRolesAction(noAbilityBox: noAbilityBox!).iterator;

    while (otherRolesIterator.moveNext()) {
      yield otherRolesIterator.current;
    }
    NightPage.isNightOver = true;
    NightPage.buttonText = "";
    yield "همه بیدار شن";
    nightReport();
  }

  @override
  void nightReport() {
    Player? shotByMafia = getFirstPlayer(NightEvent.shotByMafia);
    Player? shotByLeon = getFirstPlayer(NightEvent.shotByLeon);
    Player? revivedByConstantine =
        getFirstPlayer(NightEvent.revivedByConstantine);
    Player? inquiryByCitizenKane =
        getFirstPlayer(NightEvent.inquiryByCitizenKane);
    Player? sixthSensedByGodfather =
        getFirstPlayer(NightEvent.sixthSensedByGodfather);

    List<Player> savedByDoctor = nightEvents[NightEvent.savedByDoctor] ?? [];

    Player? leon = Player.getPlayerByRoleType(Leon);
    Player? citizenKane = Player.getPlayerByRoleType(CitizenKane);

    // mafia shot process -> Done
    if (shotByMafia != null) {
      bool isSaved = savedByDoctor.any((p) => p.name == shotByMafia.name);

      if (!isSaved &&
          (shotByMafia.role is! Leon ||
              (shotByMafia.role is Leon &&
                  (shotByMafia.role as Leon).shield <= 0)) &&
          (shotByMafia.role is! Nostradamus ||
              (shotByMafia.role is Nostradamus &&
                  !(shotByMafia.role as Nostradamus).shield))) {
        shotByMafia.playerStatus = PlayerStatus.dead;
        report.add("${shotByMafia.name} کشته شد.");
      } else if (shotByMafia.role is Leon &&
          (shotByMafia.role as Leon).shield > 0) {
        (shotByMafia.role as Leon).shield--;
      }
    }
    // mafia sixth sense -> Done
    if (sixthSensedByGodfather != null) {
      // if it isn't null it means it succeeded
      sixthSensedByGodfather.playerStatus = PlayerStatus.removed;
      report.add(
          "${sixthSensedByGodfather.name} سلاخی شد و از بازی به طور کامل خارج میشود");
    }

    // leon shot process -> Done
    if (shotByLeon != null) {
      bool isSaved = savedByDoctor.any((p) => p.name == shotByLeon.name);
      if (shotByLeon.role!.roleSide == RoleSide.citizen) {
        leon!.playerStatus = PlayerStatus.dead;
        report.add("${leon.name} کشته شد.");
      } else if (shotByLeon.role is! Nostradamus &&
          (shotByLeon.role is! Godfather ||
              (shotByLeon.role is Godfather &&
                  (shotByLeon.role as Godfather).shield <= 0)) &&
          !isSaved) {
        shotByLeon.playerStatus = PlayerStatus.dead;
        report.add("${shotByLeon.name} کشته شد.");
      } else if (shotByLeon.role is Godfather &&
          (shotByLeon.role as Godfather).shield > 0) {
        (shotByLeon.role as Godfather).shield--;
      }
    }

    // citizen kane inquiry -> player has to die the next day
    if ((citizenKane != null) &&
        (citizenKane.role as CitizenKane).remainingAbility == 0) {
      citizenKane.playerStatus = PlayerStatus.dead;
      report.add("${citizenKane.name} کشته شد.");
    }
    if (inquiryByCitizenKane != null) {
      if (citizenKane!.playerStatus == PlayerStatus.active &&
          inquiryByCitizenKane.playerStatus == PlayerStatus.active) {
        if (inquiryByCitizenKane.role!.roleSide == RoleSide.mafia) {
          report.add("${inquiryByCitizenKane.name} مافیای بازی است");
        }
        (citizenKane.role as CitizenKane).remainingAbility--;
      }
    }
    // constantine reviving
    if (revivedByConstantine != null) {
      revivedByConstantine.playerStatus = PlayerStatus.active;
      report.add("${revivedByConstantine.name} متولد شد.");
    }

    if (report.isEmpty) {
      report.add("توی شبی که گذشت هیچکس کشته نشد!");
    }
  }

  @override
  bool isGameOver() {
    int mafiaCounter = 0, citizenCounter = 0;
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus != PlayerStatus.dead &&
          player.playerStatus != PlayerStatus.removed) {
        if (player.role!.roleSide == RoleSide.mafia) {
          mafiaCounter++;
        } else {
          citizenCounter++;
        }
      }
    }

    if (mafiaCounter == 0 || mafiaCounter >= citizenCounter) {
      return true;
    }
    return false;
  }

  @override
  RoleSide whichTeamWon() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus != PlayerStatus.dead &&
          player.playerStatus != PlayerStatus.removed &&
          player.role!.roleSide == RoleSide.mafia) {
        return RoleSide.mafia;
      }
    }
    return RoleSide.citizen;
  }

  bool ableToSixthSense() {
    Player godfather =
        Player.inGamePlayers.where((player) => player.role is Godfather).first;
    if (godfather.playerStatus == PlayerStatus.active &&
        godfather.hasAbility()) {
      return true;
    }
    return false;
  }

  bool ableToBuying() {
    if (doesSaulGoodmanParticipate()) {
      Player saulGoodman = Player.inGamePlayers
          .where((player) => player.role is SaulGoodman)
          .first;
      if (saulGoodman.playerStatus == PlayerStatus.active &&
          saulGoodman.hasAbility() &&
          isAnyMaifaDead()) {
        return true;
      }
      return false;
    }
    return false;
  }

  bool doesSaulGoodmanParticipate() {
    for (Role role in Scenario.currentScenario.inGameRoles) {
      if (role is SaulGoodman) {
        return true;
      }
    }
    return false;
  }

  bool doesNostradamusParticipate() {
    for (Role role in Scenario.currentScenario.inGameRoles) {
      if (role is Nostradamus) {
        return true;
      }
    }
    return false;
  }

  bool doesBeautifulMindParticipate() {
    for (LastMoveCard lastMoveCard
        in Scenario.currentScenario.inGameLastMoveCards) {
      if (lastMoveCard is BeautifulMind) {
        return true;
      }
    }
    return false;
  }

  int resultOfNostradamusGuess(List<Player> players) {
    int counter = 0;
    for (Player player in players) {
      if (player.role.runtimeType != Godfather &&
          player.role!.roleSide == RoleSide.mafia) {
        counter++;
      }
    }
    return counter;
  }

  @override
  void setRoleAttributes() {
    setNostradamusInquiryNumber();
  }

  void setNostradamusInquiryNumber() {
    Player? nostradamusPlayer = Player.getPlayerByRoleType(Nostradamus);
    if (nostradamusPlayer == null) {
      return;
    }
    (nostradamusPlayer.role! as Nostradamus).setInquiryNumber();
  }
}
