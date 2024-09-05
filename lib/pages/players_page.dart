import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/components/row_dropdownbox.dart';
import 'package:mafia_killer/models/app_handler.dart';
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
      backgroundColor: Color(0xFF111111),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 12,
            child: PageFrame(
              pageTitle: "نقش های بازی",
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                hintText: 'نام بازیکن را وارد کنید...',
                                hintStyle: TextStyle(
                                    color: Color(0xFFD2CAD8),
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
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 10,
                  child: MyOutlinedButton(
                    text: "بعدی",
                    color: Color(0xFF07FFB5),
                    hasIcon: true,
                    isIconRight: true,
                    onTap: () => Navigator.pushNamed(context, '/intro_page'),
                    icon: Icons.keyboard_arrow_right,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 10,
                  child: MyOutlinedButton(
                    text: "قبلی",
                    hasIcon: true,
                    color: Color(0xFFE01357),
                    onTap: () => Navigator.pop(context),
                    isIconRight: false,
                    icon: Icons.keyboard_arrow_left,
                  ),
                )
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
