import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

class PlayerRoleCard extends StatefulWidget {
  PlayerRoleCard({
    super.key,
    required this.player,
    required this.onTap,
  });

  Player player;
  final VoidCallback onTap;

  @override
  State<PlayerRoleCard> createState() => _PlayerRoleCardState();
}

class _PlayerRoleCardState extends State<PlayerRoleCard> {
  Color determineColor() {
    Color color;
    switch (widget.player.role!.roleSide) {
      case RoleSide.mafia:
        color = AppColors.redColor;
        break;
      case RoleSide.citizen:
        color = AppColors.darkgreenColor;

        break;
      case RoleSide.independant:
        color = const Color(0xFFFAF746);

        break;
    }
    return color;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = determineColor();
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                child: Container(
                    width: 300,
                    height: 500,

                    //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: color,
                          width: 2.5,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          width: 280,
                          child: Image(
                            image: AssetImage(
                              widget.player.role!.cardImagePath,
                            ),
                          ),
                        ),
                        Text(
                          widget.player.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.onTap();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkgreenColor,
                            elevation: 12.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              'متوجه شدم',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }).then((value) {
          widget.onTap;
          setState(() {
            widget.player.seenRole = true;
          });
        });
      },
      child: Visibility(
        visible: !widget.player.seenRole,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 36, 5, 5),
              border: Border.all(
                color: const Color(0xFF707070),
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage('lib/images/backgrounds/GunBackground.png'),
                fit: BoxFit.cover,
              )),
          child: Center(
            child: Text(
              widget.player.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.redColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
