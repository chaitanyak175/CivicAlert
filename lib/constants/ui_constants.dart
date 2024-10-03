import 'package:civicalert/features/complain/views/complain_view.dart';
import 'package:civicalert/features/myComplains/view/my_complaints_view.dart';
import 'package:civicalert/features/myComplains/widgets/my_complains_list.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainView(),

    MyComplaintsView(),
    // Text('notiications'),
    // ComplainSuccessful(),
    Text('Search Screen'),
    // AppbarBackButton(),
    Text('Profile Page')
  ];
}
