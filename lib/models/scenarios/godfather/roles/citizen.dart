import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class Citizen extends Role {
  Citizen() {
    name = "شهروند ساده";
    description =
        "نقش شهروند ساده کمک به هم تیمی های خود در تشخیص مافیا به درستی است و رای دادن با زرنگی به اعضای مافیاست. او در شب نقش خاصی را ایفا نمی‌کند و بیشتر به روند بازی و تیم شهروندی در پیروز شدن کمک می‌کند.";
    roleSide = RoleSide.citizen;
    imagePath = "lib/images/roles/citizen.jpg";
  }
}
