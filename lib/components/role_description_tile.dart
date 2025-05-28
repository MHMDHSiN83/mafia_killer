import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/determine_color.dart';

class RoleDescriptionTile extends StatefulWidget {
  RoleDescriptionTile({super.key, required this.role});
  Role role;
  @override
  State<RoleDescriptionTile> createState() => _RoleDescriptionTileState();
}

class _RoleDescriptionTileState extends State<RoleDescriptionTile> {
  late Color color;
  Map<String, int> options = {};
  List<MapEntry<String, int>> entries = [];
  @override
  void initState() {
    color = determineColorForRoleCard(widget.role);
    options = widget.role.roleAbilities();
    entries = options.entries.toList();
    super.initState();
  }

  void increase(String key) {
    setState(() {
      options[key] = options[key]! + 1;
      saveChanges();
    });
  }

  void decrease(String key) {
    setState(() {
      if (options[key]! > 0) {
        options[key] = options[key]! - 1;
        saveChanges();
      }
    });
  }

  void saveChanges() {
    widget.role.saveAbilities(options);
    entries = options.entries.toList();
    Scenario.applyChangesToAllRoles(widget.role);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 600,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
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
              vertical: 0,
            ),
            width: 240,
            child: Image(
              image: AssetImage(
                widget.role.cardImagePath,
              ),
            ),
          ),
          Container(
            height: 120,
            margin: EdgeInsets.fromLTRB(20, 0, 20.0, 0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.role.description,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            height: (40 * entries.length).toDouble(),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
              primary: false,
              itemCount: entries.length,
              itemBuilder: (context, index) {
                String key = entries[index].key;
                int value = entries[index].value;
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        key,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color: AppColors.darkgreenColor, // Button color
                              child: InkWell(
                                splashColor:
                                    AppColors.hoverGreenColor, // Splash color
                                onTap: () => increase(key),
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
                            Language.toPersian(value.toString()),
                            style: const TextStyle(
                              fontSize: 25,
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
                                splashColor:
                                    AppColors.hoverRedColor, // Splash color
                                onTap: () => decrease(key),
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
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (widget.role.roleSide == RoleSide.mafia)
                  ? AppColors.redColor
                  : (widget.role.roleSide == RoleSide.citizen)
                      ? AppColors.blueColor
                      : AppColors.darkYellowColor,
              elevation: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                'متوجه شدم',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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