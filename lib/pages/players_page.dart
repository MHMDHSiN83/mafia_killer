import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
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
  var games = {'number1': 'کلاسیک', 'number2': '2', 'number3': '00:30'};
  final TextEditingController _controller = TextEditingController();

  void _onItemSelected(String? selectedItem, String varName) {
    setState(() {
      games[varName] = selectedItem!;
    });
  }

  void _increaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = games[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes >= 9 && seconds >= 50) {
          return;
        }
        if (seconds >= 50) {
          games[varName] = '0${minutes + 1}:00';
        } else {
          games[varName] = '0$minutes:${seconds + 10}';
        }
      } else {
        if (games[varName] == '9') {
          return;
        }
        games[varName] = (int.parse(games[varName]!) + 1).toString();
      }
    });
  }

  void _decreaseNumber(bool isTimer, String varName) {
    setState(() {
      if (isTimer) {
        final List<String> splitted = games[varName]!.split(':');
        int minutes = int.parse(splitted[0]);
        int seconds = int.parse(splitted[1]);
        if (minutes <= 0 && seconds <= 10) {
          return;
        }
        if (seconds <= 0) {
          games[varName] = '0${minutes - 1}:50';
        } else if (seconds <= 10) {
          games[varName] = '0$minutes:${seconds - 10}0';
        } else {
          games[varName] = '0$minutes:${seconds - 10}';
        }
      } else {
        if (games[varName] == '0') {
          return;
        }
        games[varName] = (int.parse(games[varName]!) - 1).toString();
      }
    });
  }

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
          Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: StreamBuilder<List<Player>>(
                    stream: context.read<Player>().listenToPlayers(),
                    builder: (context, snapshot) => GridView.count(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 8,
                      // mainAxisSpacing: 8,
                      scrollDirection: Axis.horizontal,
                      children: snapshot.hasData
                          ? snapshot.data!.map((player) {
                              return ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  player.name,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                  //     Consumer<Player>(builder: (context, player, child) {
                  //   return ListView.builder(
                  //     itemCount: player.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.symmetric(vertical: 5),
                  //         child: PlayerTile(player: player[index]),
                  //       );
                  //     },
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 100, horizontal: 30),
                  //   );
                  // }),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
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
                              fillColor:
                                  Theme.of(context).colorScheme.inversePrimary,
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

          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 10,
                  child: MyOutlinedButton(
                    text: "بعدی",
                    color: AppColors.greenColor,
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
                    hasIcon: false,
                    color: AppColors.redColor,
                    onTap: () => Navigator.pop(context),
                    //icon: Icons.keyboard_arrow_left,
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
