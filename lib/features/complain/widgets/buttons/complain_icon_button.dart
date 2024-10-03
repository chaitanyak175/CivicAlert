import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComplainIconButton extends StatelessWidget {
  final String pathName;
  final String text;
  final VoidCallback onTap;
  final double height;
  const ComplainIconButton({
    super.key,
    required this.pathName,
    required this.text,
    required this.onTap,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            pathName,
            height: height,
            colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 146, 144, 144), BlendMode.srcIn),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 117, 116, 116),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
