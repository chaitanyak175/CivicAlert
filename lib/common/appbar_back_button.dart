import 'package:civicalert/features/home/view/home_view.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppbarBackButton extends StatefulWidget {
  final Widget backScreen;
  const AppbarBackButton({
    super.key,
    required this.backScreen,
  });

  @override
  State<AppbarBackButton> createState() => _AppbarBackButtonState();
}

class _AppbarBackButtonState extends State<AppbarBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 6,
          blurStyle: BlurStyle.normal,
          color: Color.fromARGB(255, 195, 195, 195),
          offset: Offset(0, 4),
        )
      ]),
      child: IconButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor:
              const WidgetStatePropertyAll(Pallete.backgroundColor),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.backScreen),
            (route) => false,
          );
          setState(() {
            HapticFeedback.heavyImpact();
          });
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}
