import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/detective.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/die_hard.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/doctor.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/doctor_lecter.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/joker.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/mayor.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/professional.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/therapist.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/pages/noon_nap_page.dart';

part 'classic_scenario.g.dart';

@JsonSerializable()
class ClassicScenario extends Scenario {
  ClassicScenario() : super();

  factory ClassicScenario.fromJson(Map<String, dynamic> json) =>
      _$ClassicScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClassicScenarioToJson(this);

  @override
  String validateConditions() {
    String error = super.validateConditions();

    if (error != '') {
      return error;
    }

    int mafiaCount = getNumberOfRoleBySide(RoleSide.mafia);
    int citizenCount = getNumberOfRoleBySide(RoleSide.citizen);

    if (citizenCount <= mafiaCount) {
      error = 'تعداد مافیاها باید از شهروندها کمتر باشه';
      return error;
    }

    return error;
  }

  @override
  Iterable<String> callRolesIntroNight({Function? independantBox}) sync* {
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
    Role? matador = getRoleByType(DoctorLecter);
    Role? saulGoodman = getRoleByType(Joker);
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
      if (role is Doctor) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Detective) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Mayor) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is DieHard) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Professional) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Therapist) {
        citizenRoles.add(role);
        break;
      }
    }
    return citizenRoles;
  }

  @override
  void setMafiaTeamAvailablePlayers() {
    resetUIPlayerStatus();
    for (Player player in Player.inGamePlayers) {
      if (player.role! is Godfather) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  Iterable<String> mafiaTeamAction({Function? mafiaChoiceBox}) sync* {
    yield "تیم مافیا از خواب بیدار شه";
    ableToSelectTile = true;
    NightPage.buttonText = '';
    currentPlayerAtNight =
        Player.getPlayersByRoleSide(RoleSide.mafia)!.first; // TODO: wtf
    yield 'تیم مافیا به یکی شلیک کنه'; // TODO: probable move to godfather role(?)
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
      NightPage.buttonText = '';
      currentPlayerAtNight = player;
      player.role!.setAvailablePlayers();
      yield player.role!.awakingRole();
      player.role!.nightAction(NightPage.targetPlayers[0]);
      ableToSelectTile = false;
    }
    NightPage.buttonText = 'خوابید';
    ableToSelectTile = false;
    yield 'تیم مافیا بخوابه';
  }

  @override
  List<String> getMafiaRoleOrder() {
    List<String> constantRoleOrder = ['دکتر لکتر', 'جوکر'];
    return constantRoleOrder;
  }

  @override
  List<String> getOtherRoleOrder() {
    List<String> constantRoleOrder = [
      'دکتر',
      'کارآگاه',
      'شهردار',
      'جان سخت',
      'حرفه‌ای',
      'روان‌پزشک',
    ];
    return constantRoleOrder;
  }

  @override
  Iterable<String> otherRolesAction(
      {Function? noAbilityBox, Function? dieHardBox}) sync* {
    List<String> constantRoleOrder = getOtherRoleOrder();
    NightPage.buttonText = 'خوابید';

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null) {
        continue;
      }

      ableToSelectTile = true;
      resetUIPlayerStatus();
      if (player.hasAbility()) {
        NightPage.buttonText = i <= 1 ? '' : "هیچکس";
        currentPlayerAtNight = player;
        player.role!.setAvailablePlayers();
        if (player.role!.hasMultiSelection()) {
          NightPage.buttonText = "تائید";
        }
        if (player.role! is Detective) {
          NightPage.typeOfConfirmation = 3;
          NightPage.buttonText = "تائید";
        }
        if (player.role! is DieHard) {
          dieHardBox!();
        }
        yield player.role!.awakingRole();
        NightPage.typeOfConfirmation = 0;
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
    final iterator = mafiaTeamAction(mafiaChoiceBox: null).iterator;

    while (iterator.moveNext()) {
      yield iterator.current;
    }

    final otherRolesIterator =
        otherRolesAction(noAbilityBox: noAbilityBox!, dieHardBox: dieHardBox)
            .iterator;

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
    Player? shotByProfessional = getFirstPlayer(NightEvent.shotByProfessional);
    Player? savedByDoctorLecter =
        getFirstPlayer(NightEvent.savedByDoctorLecter);
    Player? silencedByTherapist =
        getFirstPlayer(NightEvent.silencedByTherapist);

    List<Player> savedByDoctor = nightEvents[NightEvent.savedByDoctor] ?? [];
    Player? professional = Player.getPlayerByRoleType(Professional);

    // mafia shot process -> Done
    if (shotByMafia != null) {
      bool isSaved = savedByDoctor.any((p) => p.name == shotByMafia.name);

      if (!isSaved &&
          (shotByMafia.role is! DieHard ||
              (shotByMafia.role is DieHard &&
                  (shotByMafia.role as DieHard).shield <= 0))) {
        shotByMafia.playerStatus = PlayerStatus.dead;
        report.add("${shotByMafia.name} کشته شد.");
      } else if (shotByMafia.role is DieHard &&
          (shotByMafia.role as DieHard).shield > 0) {
        (shotByMafia.role as DieHard).shield--;
      }
    }

    // professional shot process -> Done
    if (shotByProfessional != null) {
      bool isSaved =
          savedByDoctor.any((p) => p.name == shotByProfessional.name);
      if (shotByProfessional.role!.roleSide == RoleSide.citizen) {
        professional!.playerStatus = PlayerStatus.dead;
        report.add("${professional.name} کشته شد.");
      } else if (!isSaved &&
          (savedByDoctorLecter == null ||
              (savedByDoctorLecter.name != shotByProfessional.name))) {
        shotByProfessional.playerStatus = PlayerStatus.dead;
        report.add("${shotByProfessional.name} کشته شد.");
      }
    }

    if (silencedByTherapist != null) {
      silencedPlayerDuringDay = [silencedByTherapist];
      report.add("${silencedByTherapist.name} امروز نمی‌تونه حرف بزنه.");
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

  String getNoonNapChoiceText() {
    List<String> mafiaTeamAct = [
      "تیم مافیا به یک نفر شلیک کنه",
      "پدرخوانده کسی که میخواد امشب سلاخی کنه رو نشون بده و نقششو حدس بزنه",
      "ساول گودمن یک نفر رو خریداره کنه",
    ];
    return mafiaTeamAct[NightPage.mafiaTeamChoice];
  }

  Iterable<String> noonNapAction({Function? mayorChoiceBox}) sync* {
    NoonNapPage.buttonText = 'خوابیدن';
    yield "وقت خواب نیم‌روزی رسیده و همه بخوابن";
    NoonNapPage.buttonText = 'بیدار شد';
    yield "شهردار از خواب بیدار شه";
    mayorChoiceBox!();
    yield "test";
    Player? mayorPlayer = Player.getPlayerByRoleType(Mayor);

    NoonNapPage.buttonText = 'خوابید';
    switch (NoonNapPage.mayorChoice) {
      case 0: // nothing

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
        
    }
    NoonNapPage.isNapOver = true;
    NoonNapPage.buttonText = '';
  }

  // Iterable<String> test({Function? mafiaChoiceBox}) sync* {
  //   yield "تیم مافیا از خواب بیدار شه";
  //   ableToSelectTile = true;
  //   NightPage.buttonText = '';
  //   mafiaChoiceBox!();
  //   yield "تیم مافیا از خواب بیدار شه";
  //   yield getMafiaChoiceText();
  //   NightPage.typeOfConfirmation = 0;
  //   Player? godfatherPlayer = Player.getPlayerByRoleType(Godfather);
  //   Player? saulGoodmanPlayer = Player.getPlayerByRoleType(SaulGoodman);
  //   switch (NightPage.mafiaTeamChoice) {
  //     case 0: // shot
  //       nightEvents[NightEvent.shotByMafia] = [NightPage.targetPlayers[0]];
  //       break;
  //     case 1: // sixth sense
  //       godfatherPlayer?.role!.nightAction(
  //         NightPage.targetPlayers.isEmpty ? null : NightPage.targetPlayers[0],
  //       );
  //       if (NightPage.targetPlayers.isNotEmpty) {
  //         NightPage.targetPlayers[0].playerStatus = PlayerStatus.disable;
  //       }
  //       break;
  //     case 2: // buying
  //       ableToSelectTile = false;
  //       NightPage.buttonText = 'اتمام';
  //       saulGoodmanPlayer?.role!.nightAction(NightPage.targetPlayers[0]);
  //       if (NightPage.targetPlayers[0].role is Citizen) {
  //         NightPage.targetPlayers[0].role = Role.copy(Scenario.currentScenario
  //             .getRoleByType(Mafia, searchInGmaeRoles: false)!);
  //         yield 'خریداری موفقیت آمیز بود. فرد خریداری شده رو بیدار کن تا هم تیمیاشو ببینه';
  //       } else {
  //         yield 'خریداری موفقیت امیز نبود. کمی راه برو و اتمام رو بزن';
  //       }
  //       break;
  //   }
  //   if (Player.getPlayerByRoleType(Matador) == null) {
  //     NightPage.buttonText = 'خوابید';
  //     ableToSelectTile = false;
  //     yield 'تیم مافیا بخوابه';
  //   }
  // }
}
