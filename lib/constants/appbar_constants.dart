import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppbarConstants {
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

  static AppBar raiseComplainAppBar() {
    return AppBar(
      shape: const Border(
        bottom: BorderSide(
          color: Pallete.selectionColor,
          width: 0.3,
        ),
      ),
      scrolledUnderElevation: 0.0,
      backgroundColor: Pallete.backgroundColor,
      automaticallyImplyLeading: false,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Raise Complaint',
            style: TextStyle(
              fontFamily: 'Clash',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              wordSpacing: 5,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  static AppBar communityAppbar() {
    return AppBar(
      shape: const Border(
        bottom: BorderSide(
          color: Pallete.selectionColor,
          width: 0.3,
        ),
      ),
      scrolledUnderElevation: 0.0,
      backgroundColor: Pallete.backgroundColor,
      automaticallyImplyLeading: false,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Community',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
