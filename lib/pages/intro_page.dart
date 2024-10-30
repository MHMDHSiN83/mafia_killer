import 'package:flutter/material.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/themes/app_color.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<NightEvent, String?> map = {NightEvent.ShotByLeon: null};
    // if (map[NightEvent.ShotByLeon] == null) {
    //   print("object");
    // }
  
    // IsarService();
    Database();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF111111),
              Color.fromRGBO(40, 7, 7, 1),
              Color.fromARGB(255, 52, 0, 0),
              Color.fromRGBO(40, 7, 7, 1),
              Color(0xFF111111),
            ],
          )),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.redColor,
                          size: 60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: AppColors.redColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "مافیا",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 100,
                      ),
                    ),
                    const Text(
                      "کش",
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 32,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Transform.scale(
                    scale: 1.35,
                    child: const Image(
                      image: AssetImage(
                        'lib/images/IntroBackgroundImage.png',
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              Expanded(
                flex: 22,
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.inversePrimary,
                      onTap: () =>
                          Navigator.pushNamed(context, '/players_page'),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            width: 12,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 190,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_money_rounded,
                          color: AppColors.redColor,
                          size: 60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_rounded,
                          color: AppColors.redColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
