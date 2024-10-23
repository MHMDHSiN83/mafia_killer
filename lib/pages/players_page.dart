import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  final TextEditingController _controller = TextEditingController();

  void addPlayer() {
    if (_controller.text == "") {
      return;
    }
    // context.read<AppHandler>().addPlayer(_controller.text);
    // _controller.text = '';
    Player.addPlayer(_controller.text);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        isInGame: false,
        pageTitle: "نام بازیکنان",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Player.fetchInGamePlayers();
          Navigator.pushNamed(context, '/game_settings_page');
        },
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: StreamBuilder<List<Player>>(
                  stream: Player.listenToPlayers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitSpinningLines(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: 100.0,
                          lineWidth: 7,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No players available'));
                    } else {
                      final players = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: PlayerTile(
                              player: players[index],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              addPlayer();
                            },
                            icon: const Icon(
                              Icons.person_add_outlined,
                              color: AppColors.greenColor,
                              size: 50,
                            ))),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.inversePrimary,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        hintText: 'نام بازیکن را وارد کنید...',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      controller: _controller,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
