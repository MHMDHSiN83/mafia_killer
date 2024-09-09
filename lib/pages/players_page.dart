import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/models/app_handler.dart';
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
    context.read<AppHandler>().addPlayer(_controller.text);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        pageTitle: "نام بازیکنان",
        leftButtonText: "صحبت کردن",
        rightButtonText: "دفاعیه",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () =>
            Navigator.pushNamed(context, '/game_settings_page'),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Consumer<AppHandler>(builder: (context, handler, child) {
                return ListView.builder(
                  itemCount: handler.players.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: PlayerTile(player: handler.players[index]),
                    );
                  },
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                );
              }),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.white,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              addPlayer();
                            },
                            icon: Icon(
                              Icons.person_add_outlined,
                              color: Color(0xFF07FFB5),
                              size: 50,
                            ))),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          hintText: 'نام بازیکن را وارد کنید...',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 96, 96, 96),
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
    );
  }
}
