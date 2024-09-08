import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/models/app_handler.dart';
import 'package:mafia_killer/models/player.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:provider/provider.dart';

class PlayersPage extends StatefulWidget {
  PlayersPage({super.key});

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
    context.read<Player>().addPlayer(_controller.text);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 18,
            child: PageFrame(
              pageTitle: "نام بازیکنان",
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Consumer<AppHandler>(
                        builder: (context, handler, child) {
                      return ListView.builder(
                        itemCount: handler.players.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: PlayerTile(player: handler.players[index]),
                          );
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 5),
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                              ),
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    addPlayer();
                                  },
                                  icon: Icon(
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
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
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
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            controller: _controller,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // next and previous button
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 12,
                  child: MyOutlinedButton(
                    text: "بعدی",
                    color: AppColors.greenColor,
                    hasIcon: true,
                    isIconRight: true,
                    onTap: () =>
                        Navigator.pushNamed(context, '/game_settings_page'),
                    icon: Icons.keyboard_arrow_right,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 12,
                    child: MyOutlinedButton(
                      text: "قبلی",
                      hasIcon: true,
                      color: AppColors.redColor,
                      onTap: () => Navigator.pop(context),
                      isIconRight: false,
                      icon: Icons.keyboard_arrow_left,
                    )),
              ],
            ),
          ),
          // Expanded(
          //   // child: DropdownBox(),
          // ),
        ],
      ),
    );
  }
}
