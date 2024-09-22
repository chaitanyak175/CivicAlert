import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateComplainButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  const CreateComplainButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
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
      child: isLoading
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: Pallete.backgroundColor, size: 35.0)
          : Text(
              buttonText,
              style: const TextStyle(
                fontSize: 20,
                color: Pallete.backgroundColor,
                fontFamily: 'Gilroy',
              ),
            ),
    );
  }
}
