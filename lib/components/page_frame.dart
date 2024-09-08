import 'package:flutter/material.dart';
import 'dart:math' as math;

class PageFrame extends StatelessWidget {
  PageFrame({super.key, required this.pageTitle, this.child});
  final Widget? child;
  final String pageTitle;

  final Map<String, double> Fontsizes = {
    "small": 28,
    "medium": 35,
    "large": 39
  };
  double determineTitleFontsize() {
    double len = pageTitle.length.toDouble();
    int numberOfWords = pageTitle.split(' ').length;
    if (len <= 12 && numberOfWords <= 2) {
      return Fontsizes["large"]!;
    } else if ((len > 12 && len <= 14 && numberOfWords <= 2) ||
        (len <= 12 && numberOfWords > 2)) {
      return Fontsizes["medium"]!;
    } else {
      return Fontsizes["small"]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(5, 35, 5, 10),
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
                    backgroundColor: Color(0xFF111111),
                    radius: 25, // Size of the circular button

                    child: IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 35,
                      ),
                      color: Color(0xFFE01357),
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
                      color: Color(0xFF111111),
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
                        color: Color(0xFFE01357),
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
                    backgroundColor: Color(0xFF111111),
                    radius: 25,
                    child: Center(
                      child: IconButton(
                        icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Icon(
                            Icons.question_mark,
                            size: 35,
                            opticalSize: 100,
                          ),
                        ),
                        color: Color(0xFFE01357),
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
    );
  }
}
