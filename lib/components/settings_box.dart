import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class SettingsBox extends StatefulWidget {
  const SettingsBox({super.key, required this.text, this.settingsPage});

  final String text;

  final Function? settingsPage;

  @override
  State<SettingsBox> createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  bool playMusic = false;
  bool playEffect = false;
  Map<String, dynamic> gameSettings =
      GameSettings.currentGameSettings.getSettingsInMap();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: AlertDialog.adaptive(
            backgroundColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            elevation: 10,
            content: CustomPaint(
              painter: SpeechBubblePainter(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                width: MediaQuery.of(context).size.width -
                    60, // Adjust width as needed
                child: Column(
                  children: [
                    if(widget.settingsPage != null)
                      widget.settingsPage!(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'صدای موزیک بازی در شب',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AudioManager.playClickEffect();
                            setState(() {
                              gameSettings['playMusic'] =
                                  !gameSettings['playMusic'];
                              GameSettings.updateSettings(
                                  GameSettings.currentGameSettings,
                                  gameSettings);
                            });
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            gameSettings['playMusic']
                                ? Icons.volume_up_rounded
                                : Icons.volume_off_rounded,
                            size: 40,
                            color: gameSettings['playMusic']
                                ? AppColors.greenColor
                                : AppColors.redColor,
                          ),
                        ),
                      ],
                    ),
                    const MyDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'افکت‌های صوتی',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AudioManager.playClickEffect();

                            setState(() {
                              gameSettings['soundEffect'] =
                                  !gameSettings['soundEffect'];
                              GameSettings.updateSettings(
                                  GameSettings.currentGameSettings,
                                  gameSettings);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: gameSettings['soundEffect']
                                      ? AppColors.greenColor
                                      : AppColors.redColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              gameSettings['soundEffect'] ? "غیرفعال" : "فعال",
                              style: TextStyle(
                                color: gameSettings['soundEffect']
                                    ? AppColors.greenColor
                                    : AppColors.redColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    var borderPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var path = Path();

    double radius = 20.0;
    double tailSize = 30.0;
    double tailX = size.width * 0.03;

    path.moveTo(size.width - radius, 0);
    path.lineTo(size.width - radius - tailX, 0);

    path.lineTo(size.width - radius - tailX + 10, -tailSize);
    path.lineTo(size.width - radius - tailX - tailSize, 0);

    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
