import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/complain/widgets/rate_us_on_playstore_button.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class ComplainSuccessful extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => ComplainSuccessful());
  const ComplainSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarConstants.createComplainSuccessfulAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 40,
          // ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset('assets/images/fireworks.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Complaint successfully raised',
            style: TextStyle(
              color: Pallete.buttonColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Mulish',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'We want you to sit back and relax. Resolving your complaint will be out top priority.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.7,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RateUsOnPlaystoreButton(
            buttonText: 'Rate us on Play Store',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
