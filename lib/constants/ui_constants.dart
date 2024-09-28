import 'package:civicalert/features/complain/widgets/complain_list.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainList(),
    Text('Search Screen'),
    Text('Notification Screen'),
    Text('Profile Page')
  ];
}
