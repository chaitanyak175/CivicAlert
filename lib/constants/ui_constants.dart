import 'package:civicalert/common/shimmer.dart';
import 'package:civicalert/features/complain/views/complain_view.dart';
import 'package:civicalert/features/myComplains/view/my_complaints_view.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainView(),
    MyComplaintsView(),
    Text('notiications'),
    // Text('Search Screen'),
    // AppbarBackButton(),
    Text('Profile Page')
  ];
}
