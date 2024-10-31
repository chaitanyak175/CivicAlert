import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/myComplains/widgets/profile_details.dart';
import 'package:civicalert/features/myComplains/widgets/signout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileView extends ConsumerWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppbarConstants.profileViewAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          const Center(
            child: ProfileDetails(),
          ),
          const SizedBox(height: 80),
          SizedBox(
            height: 50,
            width: 150,
            child: SignoutButton(
              buttonText: 'Sign Out',
              onTap: () =>
                  ref.read(authControllerProvider.notifier).logout(context),
            ),
          ),
        ],
      ),
    );
  }
}
