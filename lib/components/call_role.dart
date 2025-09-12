import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(top: 35, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xFF211938),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15,
                ),
              ),
            ),
            if (buttonText != '')
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    foregroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    side: BorderSide(
                      width: 3,
                      color: Theme.of(context).colorScheme.inversePrimary,
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
    );
  }
}
