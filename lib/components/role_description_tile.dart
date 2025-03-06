import 'package:flutter/material.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

// ignore: must_be_immutable
class RoleDescriptionTile extends StatelessWidget {
  RoleDescriptionTile({super.key, required this.role});
  Role role;
  Color determineColor() {
    Color color;
    switch (role.roleSide) {
      case RoleSide.mafia:
        color = AppColors.redColor;
        break;
      case RoleSide.citizen:
        color = AppColors.blueColor;

        break;
      case RoleSide.independant:
        color = const Color(0xFFFAF746);

        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    Color color = determineColor();
    return Container(
      width: 320,
      height: 600,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            width: 280,
            child: Image(
              image: AssetImage(
                role.cardImagePath,
              ),
            ),
          ),
          Container(
            height: 120,
            margin: EdgeInsets.fromLTRB(20, 0, 20.0, 0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scrollbar(
                child: ListView(children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      role.description,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (role.roleSide == RoleSide.mafia)
                  ? AppColors.redColor
                  : (role.roleSide == RoleSide.citizen)
                      ? AppColors.blueColor
                      : AppColors.darkYellowColor,
              elevation: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                'متوجه شدم',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
