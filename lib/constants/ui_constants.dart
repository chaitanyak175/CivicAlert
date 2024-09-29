import 'package:civicalert/features/complain/views/complain_view.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainView(),
    Text('notiications'),
    // ComplainSuccessful(),
    Text('Search Screen'),
    // AppbarBackButton(),
    Text('Profile Page')
  ];
}
