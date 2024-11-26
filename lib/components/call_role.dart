import 'package:flutter/material.dart';
import 'package:mafia_killer/pages/night_page.dart';
import 'package:mafia_killer/themes/app_color.dart';

class CallRole extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  const CallRole({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage(
                  'lib/images/backgrounds/wood-plank.png',
                ),
              ),
              Container(
                // margin: const EdgeInsets.only(top: 7),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 368 * 191 / 1140,
                width: 368,
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: AppColors.brownColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (buttonText != '')
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            foregroundColor: AppColors.brownColor,
                            side: const BorderSide(
                              width: 3,
                              color: AppColors.brownColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                          ),
                          onPressed: onPressed,
                          child: Text(buttonText),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
