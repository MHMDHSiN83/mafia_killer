import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/determine_color.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = determineColorForRoleCard(widget.player.role!);
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
                        AutoSizeText(
                          minFontSize: 8,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.player.name,
                          style: TextStyle(
                            fontSize: 23,
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
                            backgroundColor:
                                (widget.player.role!.roleSide == RoleSide.mafia)
                                    ? AppColors.redColor
                                    : (widget.player.role!.roleSide ==
                                            RoleSide.citizen)
                                        ? AppColors.blueColor
                                        : AppColors.darkYellowColor,
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
            child: AutoSizeText(
              minFontSize: 10,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
