import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_role_card.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class RoleDistributionPage extends StatefulWidget {
  const RoleDistributionPage({super.key});

  @override
  State<RoleDistributionPage> createState() => _RoleDistributionPageState();
}

class _RoleDistributionPageState extends State<RoleDistributionPage> {
  late List<Player> players;
  final ScrollController _controller = ScrollController();
  double circleSize = 22;
  late double padding;
  int inGamePlayersNumber = Player.inGamePlayers.length;
  int arrowCounter = 0;
  int circleCounter = 0;

  double calculateWidth() {
    double width = inGamePlayersNumber * (circleSize + 2 * padding);
    return min(width, MediaQuery.of(context).size.width - 100);
  }

  double calculateSizeOfPadding() {
    double width = MediaQuery.of(context).size.width - 100;
    if (inGamePlayersNumber > 11) {
      padding = (width - 11 * circleSize) / 22;
    } else {
      padding = 3;
    }
    return padding;
  }

  void _moveCircles() {
    setState(() {
      circleCounter++;
      _controller.animateTo(
        (circleSize + 2 * padding) * circleCounter,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void _moveArrow() {
    setState(() {
      arrowCounter++;
    });
  }

  void _scrollRight() {
    int playersLeft = inGamePlayersNumber - arrowCounter - circleCounter;
    if (arrowCounter < 5 || playersLeft <= 6) {
      _moveArrow();
    } else {
      _moveCircles();
    }
  }

  bool _hasEveryoneSeen() {
    if (inGamePlayersNumber == arrowCounter + circleCounter) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    padding = calculateSizeOfPadding();
    return Scaffold(
      body: PageFrame(
        pageTitle: "تقسیم نقش ها",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () {
          for (Player player in Player.inGamePlayers) {
            player.role = null;
            player.seenRole = false;
          }
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (_hasEveryoneSeen()) {
            Player.updateInGamePlayers(players);
            Navigator.pushNamed(context, '/night_page');
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: calculateWidth(),
                    child: ListView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: inGamePlayersNumber,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: padding, right: padding),
                          child: Icon(
                            Icons.circle,
                            size: circleSize,
                            color: (index < arrowCounter + circleCounter)
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedPadding(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.only(
                        left: 51 +
                            (MediaQuery.of(context).size.width -
                                    100 -
                                    calculateWidth()) /
                                2 +
                            (circleSize + 2 * padding) * arrowCounter),
                    child: Transform.scale(
                      scale: 10,
                      child: const Icon(
                        Icons.arrow_drop_up,
                        size: 6,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.redColor,
                  width: 3,
                )),
                child: const Center(
                  child: Text(
                    "روی اسم خودت بزن",
                    style: TextStyle(fontSize: 28, color: AppColors.redColor),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: FutureBuilder(
                  future: Player.distributeRoles(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      players = snapshot.data!;
                      return ListView.builder(
                        itemCount: (players.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          int firstItemIndex = index * 2;
                          int secondItemIndex = firstItemIndex + 1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PlayerRoleCard(
                                  player: players[firstItemIndex],
                                  onTap: _scrollRight,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (secondItemIndex <
                                    players
                                        .length) // Check if second item exists
                                  PlayerRoleCard(
                                    player: players[secondItemIndex],
                                    onTap: _scrollRight,
                                  )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: SpinKitSpinningLines(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: 100.0,
                          lineWidth: 7,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
