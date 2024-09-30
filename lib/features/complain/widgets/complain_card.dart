import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/complain/controller/complain_controller.dart';
import 'package:civicalert/features/complain/widgets/buttons/complain_icon_button.dart';
import 'package:civicalert/features/complain/widgets/image_layout.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class ComplainCard extends ConsumerStatefulWidget {
  final ComplainModel complain;
  const ComplainCard({
    super.key,
    required this.complain,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComplainCardState();
}

class _ComplainCardState extends ConsumerState<ComplainCard> {
  bool isUpvoted = false;
  bool isDownvoted = false;

  int upvoteCount = 0;
  int downvoteCount = 0;

  @override
  void initState() {
    super.initState();
    upvoteCount = widget.complain.upvotes.length;
    downvoteCount = widget.complain.downvotes.length;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final complainController = ref.read(complainControllerProvider.notifier);

    return currentUser == null
        ? const Loader()
        : ref.watch(userDetailProvider(widget.complain.uid)).when(
              data: (user) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      child: Row(
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
                                        widget.complain.complainedAt,
                                        locale: 'en_full',
                                        allowFromNow: true,
                                      ),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 102, 101, 101),
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
                                      widget.complain.title,
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
                                      widget.complain.description,
                                      style: const TextStyle(
                                        // fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (widget.complain.imageLinks.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: buildImageLayout(
                                          widget.complain.imageLinks),
                                    ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      LikeButton(
                                        size: 26,
                                        isLiked: widget.complain.upvotes
                                            .contains(currentUser.uid),
                                        onTap: (isLiked) async {
                                          setState(() {
                                            isUpvoted = !isLiked;
                                            if (isUpvoted) {
                                              if (isDownvoted) {
                                                downvoteCount--;
                                                isDownvoted = false;
                                                complainController
                                                    .downvoteComplain(
                                                        widget.complain,
                                                        currentUser);
                                              }
                                              upvoteCount++;
                                              complainController.upvoteComplain(
                                                  widget.complain, currentUser);
                                            } else {
                                              upvoteCount--;
                                              complainController.upvoteComplain(
                                                  widget.complain, currentUser);
                                            }
                                            HapticFeedback.mediumImpact();
                                          });
                                          // Call the upvote function in the controller

                                          return isUpvoted;
                                        },
                                        likeCountAnimationDuration:
                                            const Duration(milliseconds: 100),
                                        likeBuilder: (isLiked) {
                                          return isLiked
                                              ? SvgPicture.asset(
                                                  AssetsConstants.upvoteFilled,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    Pallete.buttonColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                )
                                              : SvgPicture.asset(
                                                  AssetsConstants
                                                      .upvoteOutlined,
                                                  height: 25,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Color.fromARGB(255,
                                                              146, 144, 144),
                                                          BlendMode.srcIn),
                                                );
                                        },
                                        likeCount: upvoteCount,
                                        countBuilder:
                                            (likeCount, isLiked, text) {
                                          return Container(
                                            margin: const EdgeInsets.all(3.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: isLiked
                                                    ? Pallete.buttonColor
                                                    : const Color.fromARGB(
                                                        255, 117, 116, 116),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: LikeButton(
                                          size: 26,
                                          isLiked: widget.complain.downvotes
                                              .contains(currentUser.uid),
                                          onTap: (isLiked) async {
                                            setState(() {
                                              isDownvoted = !isLiked;

                                              if (isDownvoted) {
                                                // If user downvotes and upvote was selected, reset upvote
                                                if (isUpvoted) {
                                                  upvoteCount--;
                                                  isUpvoted = false;
                                                  complainController
                                                      .upvoteComplain(
                                                          widget.complain,
                                                          currentUser);
                                                }
                                                downvoteCount++; // Increase downvote count
                                                complainController
                                                    .downvoteComplain(
                                                        widget.complain,
                                                        currentUser);
                                              } else {
                                                downvoteCount--; // Decrease downvote count if un-downvoted
                                                complainController
                                                    .downvoteComplain(
                                                        widget.complain,
                                                        currentUser);
                                              }
                                              HapticFeedback.mediumImpact();
                                            });
                                            return isDownvoted;
                                          },
                                          likeCountAnimationDuration:
                                              const Duration(milliseconds: 100),
                                          likeBuilder: (isLiked) {
                                            return isLiked
                                                ? SvgPicture.asset(
                                                    AssetsConstants
                                                        .downvoteFilled,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      Pallete.buttonColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    AssetsConstants
                                                        .downvoteOutlined,
                                                    height: 25,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      Color.fromARGB(
                                                          255, 146, 144, 144),
                                                      BlendMode.srcIn,
                                                    ),
                                                  );
                                          },
                                          likeCount: downvoteCount,
                                          countBuilder:
                                              (likeCount, isLiked, text) {
                                            // Negate the likeCount to make it negative
                                            int negativeCount =
                                                likeCount != null
                                                    ? -likeCount
                                                    : 0;
                                            return Container(
                                              margin: const EdgeInsets.all(3.0),
                                              child: Text(
                                                '$negativeCount', // Display the negative count
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: isLiked
                                                      ? Pallete.buttonColor
                                                      : const Color.fromARGB(
                                                          255, 117, 116, 116),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      ComplainIconButton(
                                        pathName: AssetsConstants.recomplain,
                                        text: widget.complain.reshareCount
                                            .toString(),
                                        onTap: () {},
                                        height: 27,
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      ComplainIconButton(
                                        pathName: AssetsConstants.comment,
                                        text: widget.complain.commentIds.length
                                            .toString(),
                                        height: 20,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: const Divider(
                        indent: 0,
                        height: 0,
                        thickness: 0.5,
                        color: Color.fromARGB(70, 157, 179, 241),
                      ),
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
