import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => HomeView());
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: Center(
        child: Text('This is chaitanya karmalkar'),
      ),
    );
  }
}
