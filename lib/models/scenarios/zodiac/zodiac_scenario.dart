import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/detective.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/doctor.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/mayor.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/professional.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/alcapone.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/body_guard.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/bomber.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/magician.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/musketeer.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/ocean.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/zodiac.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/pages/noon_nap_page.dart';

part 'zodiac_scenario.g.dart';

/*

 






leon

citizen
*/

@JsonSerializable()
class ZodiacScenario extends Scenario {
  ZodiacScenario() : super();

  // bomb related stuff
  int bombPassword = 0;
  int bodyGuardGuess = 0;
  int playerGuess = 0;
  Player? explodedPlayer;
  // Player? bombedPlayer;

  // ----------------------------

  bool? isRealGun;

  factory ZodiacScenario.fromJson(Map<String, dynamic> json) =>
      _$ZodiacScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ZodiacScenarioToJson(this);

  @override
  Iterable<String> callRolesIntroNight({Function? independantBox}) sync* {
    if (doesIndependantRoleParticipate()) {
      Player zodiacPlayer = Player.getPlayerByRoleType(Zodiac)!;
      yield zodiacPlayer.role!.introAwakingRole();
      yield zodiacPlayer.role!.introSleepRoleText();
    }

    ableToSelectTile = false;
    currentPlayerAtNight = Player.inGamePlayers.first;
    resetUIPlayerStatus();

    List<String> introMafiaTeamAwakingTexts = getIntroMafiaTeamAwakingTexts();
    List<Role> introCitizenTeamRoles = getIntroCitizenTeamRoles();
    IntroNightPage.buttonText = 'بیدار شدند';

    int l = introMafiaTeamAwakingTexts.length;

    // TODO: better implementaion
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
    Role? alcapone = getRoleByType(Godfather);
    Role? bomber = getRoleByType(Bomber);
    Role? magician = getRoleByType(Magician);
    Role? mafia = getRoleByType(Mafia);

    if (alcapone != null) {
      introMafiaTeamAwakingTexts.add(alcapone.introAwakingRole());
    }
    if (bomber != null) {
      introMafiaTeamAwakingTexts.add(bomber.introAwakingRole());
    }
    if (magician != null) {
      introMafiaTeamAwakingTexts.add(magician.introAwakingRole());
    }
    if (mafia != null) {
      introMafiaTeamAwakingTexts.add(mafia.introAwakingRole());
    }
    introMafiaTeamAwakingTexts.add("تیم مافیا بخوابه");
    return introMafiaTeamAwakingTexts;
  }

  @override
  List<Role> getIntroCitizenTeamRoles() {
    List<Role> citizenRoles = [];

    Role? doctor = inGameRoles.whereType<Doctor>().firstOrNull;
    if (doctor != null) {
      citizenRoles.add(doctor);
    }

    Role? detective = inGameRoles.whereType<Detective>().firstOrNull;
    if (detective != null) {
      citizenRoles.add(detective);
    }

    Role? professional = inGameRoles.whereType<Professional>().firstOrNull;
    if (professional != null) {
      citizenRoles.add(professional);
    }

    Role? musketeer = inGameRoles.whereType<Musketeer>().firstOrNull;
    if (musketeer != null) {
      citizenRoles.add(musketeer);
    }

    Role? ocean = inGameRoles.whereType<Ocean>().firstOrNull;
    if (ocean != null) {
      citizenRoles.add(ocean);
    }

    Role? bodyGuard = inGameRoles.whereType<BodyGuard>().firstOrNull;
    if (bodyGuard != null) {
      citizenRoles.add(bodyGuard);
    }

    return citizenRoles;
  }

  @override
  void setMafiaTeamAvailablePlayers() {
    resetUIPlayerStatus();
    for (Player player in Player.inGamePlayers) {
      if (player.role! is Alcapone) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  Iterable<String> mafiaTeamAction(
      {Function? mafiaChoiceBox, Function? noAbilityBox}) sync* {
    yield "تیم مافیا از خواب بیدار شه";

    ableToSelectTile = true;
    NightPage.buttonText = '';
    currentPlayerAtNight = Player.getPlayersByRoleSide(RoleSide.mafia)!
        .first; // TODO: wtf (wtf is this wtf)
    yield 'تیم مافیا به یکی شلیک کنه'; // TODO: probably should move it to godfather role(?)
    ableToSelectTile = true;
    nightEvents[NightEvent.shotByMafia] = [NightPage.targetPlayers[0]];

    List<String> constantRoleOrder = getMafiaRoleOrder();

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null) {
        continue;
      }

      ableToSelectTile = true;
      resetUIPlayerStatus();
      player.role!.setAvailablePlayers();
      NightPage.buttonText = '';
      currentPlayerAtNight = player;
      if (player.hasAbility()) {
        yield player.role!.awakingRole();
        player.role!.nightAction(NightPage.targetPlayers[0]);
        ableToSelectTile = false;
      } else {
        if (!isAnyTargetable()) {
          noAbilityBox!(player.role!.notAnyTargetableText());
          NightPage.buttonText = 'هیچکس';
          yield player.role!.awakingRole();
        } else {
          setPlayersToUntargetable();
          noAbilityBox!(player.role!.deadOrRemovedText());
          NightPage.buttonText = 'هیچکس';
          yield player.role!.awakingRole();
        }
      }
    }
    NightPage.buttonText = 'خوابید';
    ableToSelectTile = false;
    yield 'تیم مافیا بخوابه';
  }

  @override
  List<String> getMafiaRoleOrder() {
    List<String> constantRoleOrder = ['شعبده باز', 'بمب گذار'];
    return constantRoleOrder;
  }

  @override
  List<String> getOtherRoleOrder() {
    List<String> constantRoleOrder = [
      'دکتر',
      'کارآگاه',
      'حرفه‌ای',
      'تفنگ دار',
      'زودیاک',
      'اوشن',
    ];
    return constantRoleOrder;
  }

  // TODO:  bomber
  @override
  Iterable<String> otherRolesAction(
      {Function? noAbilityBox, Function? musketeerBox}) sync* {
    List<String> constantRoleOrder = getOtherRoleOrder();
    NightPage.buttonText = 'خوابید';

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null ||
          (player.role! is Zodiac &&
              GameStateManager.getCurrentStateNumber() % 2 == 1)) {
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
        if (player.role! is Detective) {
          NightPage.typeOfConfirmation = 3;
          NightPage.buttonText = "تائید";
        }
        if (player.role! is Musketeer) {
          NightPage.typeOfConfirmation = 4;
          NightPage.buttonText = "مافیاکص";
        }
        if (player.role! is Bomber) {
          NightPage.typeOfConfirmation = 5;
          NightPage.buttonText = "کص ممس";
        }

        yield player.role!.awakingRole();

        NightPage.typeOfConfirmation = 0;
        for (Player p in NightPage.targetPlayers) {
          player.role!.nightAction(p, action: (isRealGun!) ? 1 : 0);
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
        } else if (!isAnyTargetable()) {
          noAbilityBox!(player.role!.notAnyTargetableText());
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
    final iterator =
        mafiaTeamAction(mafiaChoiceBox: null, noAbilityBox: noAbilityBox)
            .iterator;

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

  // TODO : who else beside zodiac doesn't get killed by mafia shot (has shield)
  @override
  void nightReport() {
    Player? shotByMafia = getFirstPlayer(NightEvent.shotByMafia);
    Player? shotByProfessional = getFirstPlayer(NightEvent.shotByProfessional);
    Player? shotByZodiac = getFirstPlayer(NightEvent.shotByZodiac);
    Player? bombedByBomber = getFirstPlayer(NightEvent.bombedByBomber);

    List<Player> savedByDoctor = nightEvents[NightEvent.savedByDoctor] ?? [];
    Player? professional = Player.getPlayerByRoleType(Professional);
    Player? zodiac = Player.getPlayerByRoleType(Zodiac);

    // mafia shot process -> Done
    if (shotByMafia != null) {
      bool isSaved = savedByDoctor.any((p) => p.name == shotByMafia.name);

      if (!isSaved && shotByMafia.role is! Zodiac) {
        shotByMafia.playerStatus = PlayerStatus.dead;
        report.add("${shotByMafia.name} کشته شد.");
      }
    }

    // professional shot process -> Done
    if (shotByProfessional != null) {
      bool isSaved =
          savedByDoctor.any((p) => p.name == shotByProfessional.name);
      if (shotByProfessional.role!.roleSide == RoleSide.citizen) {
        professional!.playerStatus = PlayerStatus.dead;
        report.add("${professional.name} کشته شد.");
      } else if (!isSaved && shotByProfessional.role is! Zodiac) {
        shotByProfessional.playerStatus = PlayerStatus.dead;
        report.add("${shotByProfessional.name} کشته شد.");
      }
    }

    // zodiac shot process

    if (shotByZodiac != null) {
      bool isSaved = savedByDoctor.any((p) => p.name == shotByZodiac.name);

      String? deadPlayerName;
      if (shotByZodiac.role is BodyGuard) {
        zodiac!.playerStatus = PlayerStatus.dead;
        deadPlayerName = zodiac.name;
      } else if (!isSaved) {
        shotByZodiac.playerStatus = (PlayerStatus.dead);
        deadPlayerName = (shotByZodiac.name);
      }

      if (deadPlayerName != null) report.add("$deadPlayerName کشته شد.");
    }

    // bomber process
    // TODO: maybe we should announce when the bombed person is dead that they have been bombed before they died
    if (bombedByBomber != null &&
        bombedByBomber.playerStatus != PlayerStatus.dead &&
        bombedByBomber.playerStatus != PlayerStatus.removed) {
      report.add("بمب جلوی ${bombedByBomber.name} قرار گرفت.");
    }

    if (report.isEmpty) {
      report.add("توی شبی که گذشت هیچکس کشته نشد!");
    }
  }

  @override
  bool isGameOver() {
    int mafiaCounter = 0, citizenCounter = 0;
    bool zodiacAlive = false;
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus != PlayerStatus.dead &&
          player.playerStatus != PlayerStatus.removed) {
        if (player.role!.roleSide == RoleSide.mafia) {
          mafiaCounter++;
        } else if (player.role!.roleSide == RoleSide.citizen) {
          citizenCounter++;
        } else {
          zodiacAlive = true;
        }
      }
    }

    if ((!zodiacAlive &&
            (mafiaCounter == 0 || mafiaCounter >= citizenCounter)) ||
        (mafiaCounter + citizenCounter == 1 && zodiacAlive)) {
      return true;
    }
    return false;
  }

  @override
  RoleSide whichTeamWon() {
    List<Player> alivePlayers = Player.getAliveInGamePlayers();
    bool zodiacAlive =
        alivePlayers.any((p) => p.role!.roleSide == RoleSide.independant);
    bool mafiaAlive =
        alivePlayers.any((p) => p.role!.roleSide == RoleSide.mafia);

    return (zodiacAlive)
        ? RoleSide.independant
        : (mafiaAlive)
            ? RoleSide.mafia
            : RoleSide.citizen;
  }

  
  // TODO
  Iterable<String> noonNapAction({Function? bodyGuardChoiceBox}) sync* {
    NoonNapPage.buttonText = 'خوابیدن';
    yield "وقت خواب نیم‌روزی رسیده و همه بخوابن";
    NoonNapPage.buttonText = 'بیدار شد';
    yield "محافظ از خواب بیدار شه";
    bodyGuardChoiceBox!();
    yield "محافظ از خواب بیدار شه";
    Player? mayorPlayer = Player.getPlayerByRoleType(Mayor);

    NoonNapPage.buttonText = 'خوابید';
    switch (NoonNapPage.mayorChoice) {
      case 0: // nothing
        yield 'شهردار تصمیم گرفت هیچ‌کاری نکنه، شهردار بخوابه';
        break;
      case 1: // veto
        mayorPlayer?.role!.nightAction(null);
        Scenario.currentScenario.killedInDayPlayer = null;
        yield 'شهردار رای‌گیری رو ملغی کرد، شهردار بخوابه';
        break;
      case 2: // killPlayer
        NoonNapPage.buttonText = 'انتخاب کرد';
        yield 'شهردار کسی که میخواد از بازی بره بیرون رو انتخاب کنه';
        mayorPlayer?.role!.nightAction(NoonNapPage.targetPlayers[0]);
        NoonNapPage.buttonText = 'خوابید';
        yield 'شهردار بخوابه';
    }
    NoonNapPage.isNapOver = true;
    NoonNapPage.buttonText = '';
  }

  // TODO
  bool doesMayorHaveAbility() {
    Player? mayorPlayer = Player.getPlayerByRoleType(Mayor);
    if (mayorPlayer == null) {
      return false;
    }
    return mayorPlayer.hasAbility();
  }

  @override
  List<Player> getPlayersForRegularVoting() {
    return Player.getAliveInGamePlayers();
  }

  @override
  void storeDefendingPlayers(List<Player> players) {
    defendingPlayers = players;
  }

  @override
  String getInquiryText() {
    return "${Language.toPersian(Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.citizen).toString())} شهروند | ${Language.toPersian(Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.mafia).toString())} مافیا | ${Language.toPersian(Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.independant).toString())} زودیاک \n از بازی خارج شدند.";
  }
}
