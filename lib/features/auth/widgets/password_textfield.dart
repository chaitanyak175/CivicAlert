import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController controller;
  const PasswordTextfield({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _obscureText = true;
  bool showPasswordIcon = false;

  void toggleShowPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  ImageIcon toggleShowPasswordIcon() {
    if (showPasswordIcon == false) {
      return const ImageIcon(
        AssetImage('assets/icons/eyeIconOpen.png'),
      );
    } else {
      return const ImageIcon(
        AssetImage('assets/icons/eyeIconClosed.png'),
      );
    }
  }

  IconButton showPasswordIconButton() {
    final text = widget.controller.text;
    if (text.characters.isEmpty) {
      return const IconButton(onPressed: null, icon: Icon(null));
    } else {
      return IconButton(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
        enableFeedback: true,
        onPressed: () {
          setState(() {
            showPasswordIcon = !showPasswordIcon;
            toggleShowPassword();
          });
          HapticFeedback.heavyImpact();
        },
        icon: toggleShowPasswordIcon(),
      );
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      style: const TextStyle(
        color: Colors.black,
      ),
      onChanged: (value) {
        setState(() {
          showPasswordIconButton();
        });
      },
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
        suffixIcon: showPasswordIconButton(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            strokeAlign: 5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(194, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
