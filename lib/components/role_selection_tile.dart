import 'package:flutter/material.dart';
import 'package:mafia_killer/components/checkbox.dart';
import 'package:mafia_killer/models/role.dart';

// ignore: must_be_immutable
class RoleSelectionTile extends StatefulWidget {
  RoleSelectionTile({super.key, required this.role, required this.onTap});
  Role role;
  VoidCallback onTap;
  @override
  State<RoleSelectionTile> createState() => _RoleSelectionTileState();
}

class _RoleSelectionTileState extends State<RoleSelectionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      padding: EdgeInsets.zero,
      width: 160,
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.inversePrimary,
        width: 2,
      )),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: MyCheckBox(
            isChecked: widget.role.isInGame,
            onChanged: (example) {},
            scale: 1.1,
          ),
          title: Text(
            widget.role.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
