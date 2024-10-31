import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;

class ProfileDetails extends ConsumerWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserDetailsProvider).when(
          data: (user) {
            if (user == null) {
              return const Center(child: Text('User not found.'));
            }
            final profileImage = user?.profilePic != null
                ? NetworkImage(user!.profilePic)
                : const AssetImage(AssetsConstants.defaultProfile)
                    as ImageProvider;

            final userName = user?.name ?? 'Unknown User';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                user.isVerified
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 82,
                            height: 82,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Pallete.buttonColor.withOpacity(0.7),
                                  Pallete.buttonColor.withOpacity(0.9),
                                  Pallete.buttonColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Container(
                            width: 76,
                            height: 76,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          // Actual avatar
                          badges.Badge(
                            badgeContent: const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              shape: badges.BadgeShape.twitter,
                              badgeColor: Pallete.buttonColor,
                              padding: EdgeInsets.all(8),
                            ),
                            position:
                                badges.BadgePosition.topEnd(top: -8, end: -4),
                            child: CircleAvatar(
                              backgroundImage: profileImage,
                              radius: 35,
                            ),
                          ),
                        ],
                      )
                    : CircleAvatar(
                        backgroundImage: profileImage,
                        radius: 35,
                      ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return ErrorText(error: error.toString());
          },
          loading: () => const Center(
            child: LoadingPage(),
          ),
        );
  }
}
