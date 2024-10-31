import 'package:civicalert/constants/appbar_constants.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarConstants.notificationsViewAppbar(),
      body: Center(
        child: Text(
          "No New Notifications",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
    );
  }
}
