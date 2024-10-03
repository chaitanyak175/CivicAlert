import 'package:civicalert/common/appbar_back_button.dart';
import 'package:civicalert/features/home/view/home_view.dart';
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

  static AppBar complainViewAppbar() {
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
            'Complaints',
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

  static AppBar myComplaintsViewAppbar() {
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
            'My Complaints',
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

  static AppBar complaintReplyViewAppbar() {
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
            'Complaint',
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

  static AppBar createComplainSuccessfulAppbar() {
    return AppBar(
      toolbarHeight: 60,
      leading: const SizedBox(
        width: 55, // Increased width to accommodate the back button
        child: Row(
          children: [
            SizedBox(width: 15),
            SizedBox(
              height: 40,
              width: 40,
              child: AppbarBackButton(backScreen: HomeView()),
            ),
          ],
        ),
      ),
      scrolledUnderElevation: 0.0,
      backgroundColor: Pallete.backgroundColor,
      automaticallyImplyLeading: false,
      title: const Text(
        'Success',
        style: TextStyle(
          fontFamily: 'Clash',
          fontSize: 26,
          fontWeight: FontWeight.w500,
          wordSpacing: 5,
        ),
      ),
      centerTitle: true,
      leadingWidth: 55, // Add this line to adjust the leading width
    );
  }
}
