import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/night_event.dart';

class GodfatherScenario extends Scenario {
  GodfatherScenario() : super("پدرخوانده");
  static Map<NightEvent, Player>? nightEvents;
}
