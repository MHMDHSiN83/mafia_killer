import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/night_event_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_tile.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightEvents extends StatefulWidget {
  const NightEvents({super.key});

  @override
  State<NightEvents> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<NightEvents> {
  late double width;
  late double height;
  void calculateSizeOfImage() {
    width = MediaQuery.of(context).size.width;
    height = 406 * width / 329;
  }

  @override
  Widget build(BuildContext context) {
    calculateSizeOfImage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        pageTitle: "اتفاقات شب",
        leftButtonText: "قبلی",
        rightButtonText: "رای گیری",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () => Navigator.pushNamed(context, '/'),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/backgrounds/letter.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 190 / 329 * width,
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 4,
                          ),
                          Expanded(
                            flex: 12,
                            child: ListView.builder(
                              itemCount: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  const NightEventTile(
                                text: "محمد و مهدی کشته های شب !!!",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.brownColor,
                                elevation: 12.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 0),
                                child: Text(
                                  'استعلام وضعیت',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 4,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
