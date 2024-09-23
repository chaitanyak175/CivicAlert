import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddMorePhotos extends StatelessWidget {
  final String buttonText;
  final GestureTapCallback onTap;
  const AddMorePhotos({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        onTap();
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
          fontSize: 15,
          color: Pallete.backgroundColor,
          fontFamily: 'Gilroy',
        ),
      ),
    );
  }
}
