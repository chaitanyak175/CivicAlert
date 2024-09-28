import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RateUsOnPlaystoreButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const RateUsOnPlaystoreButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        onPressed();
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        backgroundColor: const WidgetStatePropertyAll(Pallete.buttonColor),
        // overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        // shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        splashFactory: InkRipple.splashFactory,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 20,
          color: Pallete.backgroundColor,
          fontFamily: 'Mulish',
        ),
      ),
    );
  }
}
