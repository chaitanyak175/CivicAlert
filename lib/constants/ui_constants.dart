import 'package:civicalert/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UiConstants {
  static AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   AssetsConstants.homeIconFilled,
          //   colorFilter: ColorFilter.mode(
          //     Colors.blue,
          //     BlendMode.src,
          //   ),
          //   height: 30,
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          Text(
            'CivicAlert',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
