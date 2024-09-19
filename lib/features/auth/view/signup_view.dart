import 'package:civicalert/constants/ui_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/auth/view/login_view.dart';
import 'package:civicalert/features/auth/widgets/email_textfield.dart';
import 'package:civicalert/features/auth/widgets/my_button.dart';
import 'package:civicalert/features/auth/widgets/password_textfield.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignupView());
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  String? passwordErrorMessage;
  bool isloading = false;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  void onSignup() {
    ref.read(authControllerProvider.notifier).signup(
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
    // print('called dispose()');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: UiConstants.appbar(),
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
                  'Sign Up',
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
                  'Sign up now and your journey of being a better Civic.',
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
                buttonText: 'Sign up',
                onPressed: onSignup,
                isLoading: isLoading,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Already have an account?',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: ' Login',
                    style: const TextStyle(
                      color: Pallete.buttonColor,
                      fontSize: 16,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          LoginView.route(),
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
