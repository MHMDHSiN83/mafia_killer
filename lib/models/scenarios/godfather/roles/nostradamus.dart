import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class Nostradamus extends Role {
  Nostradamus() {
    name = "نوستراداموس";
    description =
        "در شب معارفه گرداننده او را بیدار می‌کند. نوستراداموس به انتخاب خود سه بازیکن را به گرداننده نشان می‌دهد. سپس گرداننده به او تعداد مافیاهای موجود در میان این سه را اعلام می‌کند و پیش بینی او مبنی بر پیروزی یکی از دو ساید را از او می‌پرسد. نوستراداموس پیش بینی می‌کند شهروندان برنده خواهند شد یا مافیاها. از پس او برای برنده شدن سایدی که انتخاب کرده است تلاش می‎کند. بدون آنکه دیگر افراد بدانند وی به چه سایدی پیوسته است. اگر ساید مورد انتخابش برنده شد او نیز برنده است و اگر ساید مورد انتخابش بازنده شد او نیز بازنده خواهد شد. شلیک هیچ یک از دو ساید برا او موثر نخواهد بود و در شب کشته نخواهد شد. مگر با حس ششم پدرخوانده اما در روز با رای‌گیری از بازی خارج خواهد شد. استعلام پدرخوانده برای وی شهروندی خواهد بود.";
    roleSide = RoleSide.independant;
    imagePath = "lib/images/roles/nostradamus.jpg";
  }

  int introNightAction(List<Player> players) {
    int result = 0;
    for (Player player in players) {
      if (player.role!.roleSide == RoleSide.mafia &&
          player.role!.name != 'پدرخوانده') {
        result++;
      }
    }
    return result;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'نوستراداموس') {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }
}
