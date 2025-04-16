import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/update_dialogbox.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/update_checker.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    AudioManager.playIntroMusic();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioManager.pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      AudioManager.resumeMusic(); 
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/scenario_guid_page');
                        },
                        icon: const Icon(
                          Icons.menu_book,
                          color: AppColors.redColor,
                          size: 60,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8),
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.settings,
                    //       color: AppColors.redColor,
                    //       size: 60,
                    //     ),
                    //   ),
                    // ),
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
                          fontSize: 130,
                          fontFamily: 'DigiGaf'),
                    ),
                    const Text(
                      "کُش",
                      style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 130,
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
                        //AudioManager.stopMusic();
                        if (UpdateChecker.isUpdateAvilable) {
                          showDialog(
                            context: context,
                            builder: (context) => UpdateDialogbox(
                              onSave: () {
                                UpdateChecker.openBazaarPage(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, '/players_page');
                        }
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
              Spacer(
                flex: 9,
              ),
              // Expanded(
              //   flex: 9,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(right: 8),
              //         child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.attach_money_rounded,
              //             color: AppColors.redColor,
              //             size: 60,
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 8),
              //         child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.shopping_cart_rounded,
              //             color: AppColors.redColor,
              //             size: 60,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
