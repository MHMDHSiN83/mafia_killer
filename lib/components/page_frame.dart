import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'dart:math' as math;

import 'package:mafia_killer/themes/app_color.dart';

class PageFrame extends StatelessWidget {
  PageFrame({
    super.key,
    required this.pageTitle,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.leftButtonOnTap,
    required this.rightButtonOnTap,
    this.leftButtonIcon,
    this.rightButtonIcon,
    this.questionOnTap,
    this.child,
  });

  final String pageTitle;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback leftButtonOnTap;
  final VoidCallback rightButtonOnTap;
  final Function? questionOnTap; //this shouldn't be nullable
  final IconData? leftButtonIcon;
  final IconData? rightButtonIcon;
  final Widget? child;

  final Map<String, double> TitleFontsizes = {
    "small": 28,
    "medium": 35,
    "large": 39
  };
  double determineTitleFontsize() {
    double len = pageTitle.length.toDouble();
    int numberOfWords = pageTitle.split(' ').length;
    if (len <= 12 && numberOfWords <= 2) {
      return TitleFontsizes["large"]!;
    } else if ((len > 12 && len <= 14 && numberOfWords <= 2) ||
        (len <= 12 && numberOfWords > 2)) {
      return TitleFontsizes["medium"]!;
    } else {
      return TitleFontsizes["small"]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF111111),
            //Color.fromRGBO(17, 7, 7, 1),
            Color.fromRGBO(40, 7, 7, 1),
            Color.fromARGB(255, 52, 0, 0),
          ],
        )),
        child: Column(
          children: [
            //const SizedBox(
            //  height: 50,
            //),
            Expanded(
              flex: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.fromLTRB(5, 35, 5, 10),
                    padding: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: child,
                  ),
                  // page title
                  Positioned(
                    top: -3,
                    left: 0,
                    right: 0,
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
                                color: Colors.white, // Border color
                                width: 3, // Border width
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF111111),
                              radius: 25, // Size of the circular button

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
                        // SizedBox(
                        //   width: 5,
                        // ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            //TODO
                            height: 80,
                            //padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF111111),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                )),
                            child: Center(
                              child: Text(
                                pageTitle,
                                style: TextStyle(
                                  fontSize: determineTitleFontsize(),
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFE01357),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 5,
                        // ),
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
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 12,
                    child: MyOutlinedButton(
                      text: rightButtonText,
                      color: AppColors.greenColor,
                      hasIcon: true,
                      isIconRight: true,
                      onTap: rightButtonOnTap,
                      icon: rightButtonIcon,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 12,
                      child: MyOutlinedButton(
                        text: leftButtonText,
                        hasIcon: true,
                        color: AppColors.redColor,
                        onTap: leftButtonOnTap,
                        isIconRight: false,
                        icon: leftButtonIcon,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
