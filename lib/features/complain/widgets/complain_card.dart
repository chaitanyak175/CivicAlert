import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/complain/widgets/image_layout.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 22,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  fontSize: 16,
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
                                  fontSize: 12,
                                  fontFamily: 'Mulish',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                complain.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Mulish',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(
                                complain.description,
                                style: const TextStyle(
                                  // fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (complain.imageLinks.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: buildImageLayout(complain.imageLinks),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  indent: 0,
                  height: 0,
                  thickness: 0.5,
                  color: Pallete.buttonColor,
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
