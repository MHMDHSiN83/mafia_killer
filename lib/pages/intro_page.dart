import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "lib/images/backgrounds/background-image-edited.png"),
                fit: BoxFit.cover),
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 6,
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
                flex: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "مافیا",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 120,
                          fontFamily: 'DigiGaf'),
                    ),
                    const Text(
                      "کُش",
                      style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 120,
                          fontFamily: 'DigiGaf'),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 14,
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.inversePrimary,
                      onTap: () {
                        AudioManager.stopMusic();
                        Navigator.pushNamed(context, '/players_page');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            width: 15,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 240,
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
