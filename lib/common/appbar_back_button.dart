import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is test screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Pallete.selectionColor,
              offset: Offset(0, 5),
            )
          ]),
          child: IconButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              backgroundColor:
                  const WidgetStatePropertyAll(Pallete.backgroundColor),
            ),
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),
    );
  }
}
