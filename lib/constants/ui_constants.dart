import 'package:civicalert/features/complain/views/complain_view.dart';
import 'package:civicalert/features/myComplains/view/my_complaints_view.dart';
import 'package:civicalert/features/myComplains/view/my_profile_view.dart';
import 'package:civicalert/features/myComplains/view/notifications.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainView(),
    MyComplaintsView(),
    Notifications(),
    // Text('Search Screen'),
    // AppbarBackButton(),
    MyProfileView(),
  ];
}
