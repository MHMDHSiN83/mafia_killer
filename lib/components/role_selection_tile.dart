import 'package:flutter/material.dart';
import 'package:mafia_killer/components/role_description_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class RoleSelectionTile extends StatefulWidget {
  RoleSelectionTile({super.key, required this.role, required this.counter});
  Role role;
  int counter;
  @override
  State<RoleSelectionTile> createState() => _RoleSelectionTileState();
}

class _RoleSelectionTileState extends State<RoleSelectionTile> {
  Color determineColor() {
    Color color;
    switch (widget.role.roleSide) {
      case RoleSide.mafia:
        color = AppColors.redColor;
        break;
      case RoleSide.citizen:
        color = AppColors.darkgreenColor;

        break;
      case RoleSide.independant:
        color = const Color(0xFFFEE604);

        break;
    }
    return color;
  }

  void increaseNumber() {
    if (Player.inGamePlayers.length <=
        Scenario.currentScenario.inGameRoles.length) {
      customSnackBar(
          context, 'تعداد نقش‌ها نمی‌تونه از تعداد بازیکن‌ها بیشتر باشه');
      return;
    }
    if (widget.counter == 0 || widget.role is Citizen) {
      setState(() {
        widget.counter++;
      });

      Scenario.addRole(widget.role);
    } else {
      customSnackBar(context,
          'بیشتر از یک ${widget.role.name} نمی‌تواند در بازی وجود داشته باشد');
    }
  }

  void decreaseNumber() {
    if (widget.counter == 0) {
      customSnackBar(context, 'تعداد یک نقش نمی‌تونه از صفر کمتر باشه');
      return;
    }
    setState(() {
      widget.counter--;
    });
    Scenario.removeRole(widget.role);
  }

  @override
  Widget build(BuildContext context) {
    Color color = determineColor();
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: RoleDescriptionTile(role: widget.role),
              );
            });
      },
      child: Container(
        width: 165,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: color,
            width: 2.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 155,
              child: Image(
                image: AssetImage(
                  widget.role.cardImagePath,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Material(
                    color: AppColors.darkgreenColor, // Button color
                    child: InkWell(
                      splashColor: AppColors.hoverGreenColor, // Splash color
                      onTap: increaseNumber,
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Icon(
                          Icons.add,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  Language.toPersian(widget.counter.toString()),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipOval(
                  child: Material(
                    color: AppColors.redColor, // Button color
                    child: InkWell(
                      splashColor: AppColors.hoverRedColor, // Splash color
                      onTap: decreaseNumber,
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Icon(
                          Icons.remove,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
