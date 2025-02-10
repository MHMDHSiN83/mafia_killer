import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/components/player_status_dialogbox.dart';
import 'package:mafia_killer/components/remove_player_dialogbox.dart';
import 'package:mafia_killer/pages/regular_voting_page.dart';
import 'dart:math' as math;
import 'package:mafia_killer/themes/app_color.dart';

class PageFrame extends StatefulWidget {
  const PageFrame(
      {super.key,
      required this.pageTitle,
      required this.leftButtonText,
      required this.rightButtonText,
      required this.leftButtonOnTap,
      required this.rightButtonOnTap,
      this.isInGame = true,
      this.leftButtonIcon,
      this.rightButtonIcon,
      this.questionOnTap,
      this.child,
      this.reloadContentOfPage});

  final String pageTitle;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback leftButtonOnTap;
  final VoidCallback rightButtonOnTap;
  final Function? questionOnTap; //this shouldn't be nullable
  final IconData? leftButtonIcon;
  final IconData? rightButtonIcon;
  final Widget? child;
  final bool isInGame;
  final Function? reloadContentOfPage;

  @override
  State<PageFrame> createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  final Map<String, double> titleFontsizes = {
    "small": 21,
    "medium": 24,
    "large": 27,
  };

  double determineTitleFontsize() {
    double len = widget.pageTitle.length.toDouble();
    int numberOfWords = widget.pageTitle.split(' ').length;
    if (len <= 12 && numberOfWords <= 2) {
      return titleFontsizes["large"]!;
    } else if ((len > 12 && len <= 14 && numberOfWords <= 2) ||
        (len <= 12 && numberOfWords > 2)) {
      return titleFontsizes["medium"]!;
    } else {
      return titleFontsizes["small"]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage("lib/images/backgrounds/background-image-edited.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //body
              Expanded(
                flex: 23,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 33,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 27.5, 5, 10),
                              padding: const EdgeInsets.only(top: 50),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: widget.child,
                            ),
                          ),
                          if (widget.isInGame)
                            const Spacer(
                              flex: 1,
                            )
                        ],
                      ),
                    ),
                    // page title
                    pageTitleWidget(),

                    // remove player and see status buttons
                    if (widget.isInGame)
                      removePlayerAndStatusButtonWidget(context),
                  ],
                ),
              ),
              // next and previous button
              Expanded(
                flex: 2,
                child: previousAndNextButtonWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitleWidget() {
    return Positioned(
      top: -3,
      left: 0,
      right: 0,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // question mark button on the left
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF111111),
                  radius: 25,
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      size: 35,
                    ),
                    color: const Color(0xFFE01357),
                    onPressed: () {
                      print('Icon Button Pressed');
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.pageTitle,
                    style: TextStyle(
                      fontSize: determineTitleFontsize(),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE01357),
                    ),
                  ),
                ),
              ),
            ),
            // setting button on the right
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF111111),
                  radius: 25,
                  child: Center(
                    child: IconButton(
                      icon: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: const Icon(
                          Icons.question_mark,
                          size: 35,
                          opticalSize: 100,
                        ),
                      ),
                      color: const Color(0xFFE01357),
                      onPressed: () {
                        print('Icon Button Pressed');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget previousAndNextButtonWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 40,
          child: MyOutlinedButton(
            text: widget.rightButtonText,
            color: AppColors.greenColor,
            hasIcon: true,
            isIconRight: true,
            onTap: widget.rightButtonOnTap,
            icon: widget.rightButtonIcon,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 40,
          child: MyOutlinedButton(
            text: widget.leftButtonText,
            hasIcon: true,
            color: AppColors.redColor,
            onTap: widget.leftButtonOnTap,
            isIconRight: false,
            icon: widget.leftButtonIcon,
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget removePlayerAndStatusButtonWidget(BuildContext context) {
    double screenHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top) *
        (30 / 32);
    double buttonHeight = 48;
    return Positioned(
      bottom: screenHeight * (1 / 34) + 12 - buttonHeight / 2,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: buttonHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 32,
              child: MyOutlinedButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                hasIcon: true,
                text: "حذف بازیکن",
                fontSize: 15,
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return RemovePlayerDialogbox(
                          reloadPage: widget.reloadContentOfPage == null
                              ? () {}
                              : widget.reloadContentOfPage!,
                        );
                      });
                },
                icon: FontAwesomeIcons.gun,
                iconSize: 6,
                isIconRight: true,
                textColor: AppColors.redColor,
                backgroundColor: const Color.fromRGBO(40, 7, 7, 1),
                horizontalPadding: 1,
                broderWidth: 4,
                iconFlip: true,
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 32,
              child: MyOutlinedButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                hasIcon: true,
                text: "مشاهده وضعیت",
                fontSize: 15,
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return PlayerStatusDialogbox(
                          reloadPage: widget.reloadContentOfPage == null
                              ? () {}
                              : widget.reloadContentOfPage!,
                        );
                      });
                },
                icon: FontAwesomeIcons.gun,
                iconSize: 6,
                isIconRight: false,
                textColor: AppColors.redColor,
                backgroundColor: const Color.fromRGBO(40, 7, 7, 1),
                horizontalPadding: 1,
                broderWidth: 4,
              ),
            ),
            const Spacer(
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}
