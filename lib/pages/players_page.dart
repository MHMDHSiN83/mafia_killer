import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
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
    context.read<AppHandler>().addPlayer(_controller.text);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
        title: Text(
          "Mafia Killer",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child:
                      Consumer<AppHandler>(builder: (context, handler, child) {
                    return ListView.builder(
                      itemCount: handler.players.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: PlayerTile(player: handler.players[index]),
                        );
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 100, horizontal: 30),
                    );
                  }),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RowDropdownBox(
                      title: 'سناریو بازی',
                      options: context.watch<AppHandler>().scenarios,
                      onSelect: _onItemSelected,
                      varName: 'number1',
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RowCounterBox(
                      title: 'تعداد استعلام‌های بازی',
                      increaseNumber: _increaseNumber,
                      decreaseNumber: _decreaseNumber,
                      number: games['number2']!,
                      isTimer: false,
                      varName: 'number2',
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RowCounterBox(
                      title: 'تعداد استعلام‌های بازی',
                      increaseNumber: _increaseNumber,
                      decreaseNumber: _decreaseNumber,
                      number: games['number3']!,
                      isTimer: true,
                      varName: 'number3',
                    ),
                  ),
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
                    hasIcon: false,
                    color: Color(0xFFE01357),
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
