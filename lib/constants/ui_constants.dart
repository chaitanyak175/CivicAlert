import 'package:civicalert/common/appbar_back_button.dart';
import 'package:civicalert/features/complain/views/complain_successful.dart';
import 'package:civicalert/features/complain/views/complain_view.dart';
import 'package:civicalert/features/complain/widgets/complain_list.dart';
import 'package:flutter/material.dart';

class UiConstants {
  static List<Widget> bottomTabBarPages = const [
    ComplainView(),
    ComplainSuccessful(),
    // Text('Search Screen'),
    AppbarBackButton(),
    Text('Profile Page')
  ];
}
