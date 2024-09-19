import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextfield({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.black,
      ),
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            strokeAlign: 5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(194, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
