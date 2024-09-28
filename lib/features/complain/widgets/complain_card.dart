import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class ComplainCard extends ConsumerWidget {
  final ComplainModel complain;
  const ComplainCard({
    super.key,
    required this.complain,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailProvider(complain.uid)).when(
          data: (user) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Mulish',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              timeago.format(
                                complain.complainedAt,
                                locale: 'en_full',
                                allowFromNow: true,
                              ),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 102, 101, 101),
                                fontSize: 13,
                                fontFamily: 'Mulish',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: LoadingPage()),
          ),
        );
  }
}
