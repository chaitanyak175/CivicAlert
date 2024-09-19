import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Pallete.backgroundColor,
    ),
  );
}
