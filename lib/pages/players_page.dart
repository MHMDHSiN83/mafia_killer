import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  void addPlayer() {
    setState(() {
      String text = _controller.text.trim();
      if (text == "") {
        customSnackBar(context, 'اسم وارد شده نمی‌تونه خالی باشه');
      } else if (text.length > 12) {
        customSnackBar(
            context, 'اسم وارد شده نمی‌تونه بیشتر از ۱۲ کاراکتر باشه');
      } else if (Player.doesNameExist(text)) {
        customSnackBar(context, 'اسم وارد شده نمی‌تونه تکراری باشه');
      } else {
        Player.addPlayer(text);
        _controller.text = '';
      }
    });
  }

  void removePlayer(Player player) {
    setState(() {
      Player.deletePlayer(player);
    });
  }

  late AnimationController _textFieldController;
  late Animation _animation;
  final FocusNode _focusNode = FocusNode();
  bool isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _textFieldController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 11.0, end: 11.0).animate(_textFieldController)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      setState(() {
        isTextFieldFocused = _focusNode.hasFocus; // Update focus state
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _textFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Hides the keyboard when tapping outside
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageFrame(
          label: ModalRoute.of(context)!.settings.name!,
          isInGame: false,
          pageTitle: "نام بازیکنان",
          leftButtonText: "صفحه اصلی",
          rightButtonText: "تنظیمات بازی",
          leftButtonOnTap: () => Navigator.pop(context),
          rightButtonOnTap: () {
            Player.fetchInGamePlayers();
            Navigator.pushNamed(context, '/game_settings_page');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                            fontSize: 20,
                          ),
                        ),
                        controller: _controller,
                      ),
                    ),
                  ]),
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: Player.players.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: PlayerTile(
                        player: Player.players.reversed.toList()[index],
                        removePlayer: () => removePlayer(
                            Player.players.reversed.toList()[index]),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: CallRole(text: "text", onPressed: () {}, buttonText: ""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
