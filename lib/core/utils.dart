import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Pallete.scaffoldMessengerColor,
    ),
  );
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}
