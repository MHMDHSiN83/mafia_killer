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
        color = AppColors.darkgreenColor;

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
      width: 300,
      height: 700,
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
          ListView(children: [
            SizedBox(
              height: 50,
              child: Text(
                role.description,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
