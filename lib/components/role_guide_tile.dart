import 'package:flutter/material.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/utils/determine_color.dart';

class RoleGuideTile extends StatelessWidget {
  const RoleGuideTile({super.key, required this.role});

  final Role role;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: determineColorForRoleCard(role), width: 2)),
      elevation: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image

              // Description and Details
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.name,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: determineColorForRoleCard(role)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      role.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
