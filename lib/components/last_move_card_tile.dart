import 'package:flutter/material.dart';
import 'package:mafia_killer/models/last_move_card.dart';

class LastMoveCardTile extends StatefulWidget {
  LastMoveCardTile(
      {super.key, required this.lastMoveCard, required this.index});

  LastMoveCard lastMoveCard;
  int index; // starts with 0

  static double tileWidth = 400, tileHeight = 150;

  @override
  State<LastMoveCardTile> createState() => _LastMoveCardTileState();
}

class _LastMoveCardTileState extends State<LastMoveCardTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  bool _isFront = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _flipCard() {
    if (!_isFront) {
      _controller.forward();
    } else {
      return;
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  Widget _buildFrontCardForOddIndex() {
    return Transform.scale(
      scaleX: -1,
      child: Container(
        height: LastMoveCardTile.tileHeight,
        width: LastMoveCardTile.tileWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.lastMoveCard.flippedImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: widget.lastMoveCard.titleVerticalPadding(),
            ),
            Row(
              children: [
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: widget.lastMoveCard.titleHorizontalRatio(),
                  child: Text(
                    widget.lastMoveCard.title,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.lastMoveCard.titleVerticalPadding(),
            ),
            Row(
              children: [
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    widget.lastMoveCard.description,
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCardForEvenIndex() {
    return Transform.scale(
      scaleX: -1,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: LastMoveCardTile.tileHeight,
          width: LastMoveCardTile.tileWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.lastMoveCard.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: widget.lastMoveCard.titleVerticalPadding(),
              ),
              Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: widget.lastMoveCard.titleHorizontalRatio(),
                    child: Text(
                      widget.lastMoveCard.title,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: widget.lastMoveCard.titleVerticalPadding(),
              ),
              Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.lastMoveCard.description,
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      height: LastMoveCardTile.tileHeight,
      width: LastMoveCardTile.tileWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('lib/images/last_move_cards/Back_of_LastMoveCard.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Rotate the card
          double angle = _animation.value * 3.14159;
          bool isFrontVisible = _animation.value > 0.5;

          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: isFrontVisible
                    ? (widget.index % 2 == 0)
                        ? _buildFrontCardForEvenIndex()
                        : _buildFrontCardForOddIndex()
                    : _buildBackCard()),
          );
        },
      ),
    );
  }
}
