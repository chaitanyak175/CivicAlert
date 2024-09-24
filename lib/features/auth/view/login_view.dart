import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/auth/view/signup_view.dart';
import 'package:civicalert/features/auth/widgets/email_textfield.dart';
import 'package:civicalert/features/auth/widgets/my_button.dart';
import 'package:civicalert/features/auth/widgets/password_textfield.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginView());
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  String? passwordErrorMessage;
  bool isloading = false;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
          context: context,
        );
  }

  @override
  void initState() {
    super.initState();
    passwordTextEditingController.addListener(() {
      setState(() {
        passwordErrorMessage = passwordTextEditingController.text.length < 8 &&
                passwordTextEditingController.text.isNotEmpty
            ? "Password should be at least 8 characters."
            : null;
      });
    });
  }

  @override
  void dispose() {
    passwordTextEditingController.removeListener(() {});
    emailTextEditingController.dispose();
    // passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarConstants.appbar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: GoogleFonts.inter(
                    color: Pallete.buttonColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login now and start your journey of being a better Civic.',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EmailTextfield(controller: emailTextEditingController),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  PasswordTextfield(controller: passwordTextEditingController),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 25,
              child: passwordErrorMessage != null
                  ? Text(
                      passwordErrorMessage!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 181, 57, 48),
                        fontFamily: 'Gilroy',
                      ),
                    )
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              width: 370,
              child: MyButton(
                buttonText: 'Login',
                onPressed: () {
                  setState(() {
                    onLogin();
                    isLoading;
                  });
                },
                isLoading: isLoading,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: ' Signup',
                    style: const TextStyle(
                      color: Pallete.buttonColor,
                      fontSize: 16,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          SignupView.route(),
                          (route) => false,
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
