import 'package:flutter/material.dart';

void main() => runApp(const SelectTileTestApp());

class SelectTileTestApp extends StatelessWidget {
  const SelectTileTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Player Tile Grid'),
          backgroundColor: Colors.brown.shade700,
        ),
        body: const Padding(
          padding: EdgeInsets.all(12.0),
          child: SelectableTileGrid(),
        ),
      ),
    );
  }
}

class Player {
  final String name;
  final String roleName;
  final String imagePath;
  final String iconPath;

  Player({
    required this.name,
    required this.roleName,
    required this.imagePath,
    required this.iconPath,
  });
}

class SelectableTileGrid extends StatefulWidget {
  const SelectableTileGrid({super.key});

  @override
  State<SelectableTileGrid> createState() => _SelectableTileGridState();
}

class _SelectableTileGridState extends State<SelectableTileGrid> {
  final Set<int> selectedIndexes = {};
  final List<Player> players = List.generate(
    12,
    (index) => Player(
      name: 'Player $index',
      roleName: 'Role $index',
      imagePath: 'lib/images/roles/role_characters/citizen.png', // Replace with your character image path
      iconPath: 'lib/images/icons/target.png',    // Replace with your tile icon path
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: players.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final player = players[index];
        final isSelected = selectedIndexes.contains(index);

        Widget tile = GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedIndexes.remove(index);
              } else {
                selectedIndexes.add(index);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(isSelected ? 1.03 : 1.0),
            decoration: BoxDecoration(
              color: Colors.brown.shade800,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.orangeAccent : Colors.transparent,
                width: 2.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 6,
                  child: Text(
                    player.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    player.roleName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                Expanded(
                  flex: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Image.asset(
                          player.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 25,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            player.iconPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

        return Stack(
          children: [
            tile,
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.orangeAccent.shade200,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
