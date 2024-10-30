import 'package:flutter/material.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightPage extends StatefulWidget {
  const NightPage({super.key});
  static late Player? targetPlayer;
  static late int mafiaTeamChoice;
  static String buttonText = 'بیدار شدند';

  @override
  State<NightPage> createState() => _NightPageState();
}

class _NightPageState extends State<NightPage> {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicDialogBox() {
    // show a dialog
    // set mafiaTeamChoic value
    // call setState{iterator.moveNext()}
    // throw UnimplementedError();
  }

  void confirmAction(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationBox(
          onSave: () {
            NightPage.targetPlayer = player;

            Navigator.of(context).pop();
            setState(() {
              if (iterator.moveNext()) {
                text = iterator.current;
              }
            });
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  void initState() {
    NightPage.mafiaTeamChoice = 0;
    iterator = GodfatherScenario.callRolesRegularNight(
            mafiaChoicDialogBox, confirmAction, confirmAction, confirmAction)
        .iterator;
    iterator.moveNext();
    text = iterator.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "شب اول",
        rightButtonText: "بعدی",
        leftButtonText: "قبلی",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () =>
            Navigator.pushNamed(context, '/role_selection_page'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of tiles per row
                      childAspectRatio: 1, // Width/height ratio of tiles
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: Player.inGamePlayers.length,
                    itemBuilder: (context, index) {
                      return NightPlayerTile(
                        player: Player.inGamePlayers[index],
                        confirmAction: () =>
                            confirmAction(Player.inGamePlayers[index]),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const Image(
                            image: AssetImage(
                              'lib/images/backgrounds/wood-plank.png',
                            ),
                          ),
                          Container(
                            // margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 368 * 191 / 1140,
                            width: 368,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: AppColors.brownColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                if (NightPage.buttonText != '')
                                  Expanded(
                                    flex: 1,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        foregroundColor: AppColors.brownColor,
                                        side: const BorderSide(
                                          width: 3,
                                          color: AppColors.brownColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (iterator.moveNext()) {
                                            text = iterator.current;
                                            NightPage.targetPlayer = null;
                                          }
                                        });
                                      },
                                      child: Text(NightPage.buttonText),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: PageFrame(
    //     pageTitle: "تنظیمات این دست",
    //     rightButtonText: "بعدی",
    //     leftButtonText: "قبلی",
    //     leftButtonOnTap: () => Navigator.pop(context),
    //     rightButtonOnTap: () =>
    //         Navigator.pushNamed(context, '/role_selection_page'),
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text(text),
    //           ElevatedButton(
    //               onPressed: () {
    //                 setState(() {
    //                   if (iterator.moveNext()) {
    //                     text = iterator.current;
    //                   }
    //                 });
    //               },
    //               child: const Text("next")),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
