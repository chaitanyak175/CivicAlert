import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/complain/controller/comment_controller.dart';
import 'package:civicalert/features/complain/controller/complain_controller.dart';
import 'package:civicalert/features/complain/widgets/buttons/comment_button.dart';
import 'package:civicalert/features/complain/widgets/buttons/complain_icon_button.dart';
import 'package:civicalert/features/complain/widgets/carousel_image_complaint_reply.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart' as badges;

class ComplainReplyViewCard extends ConsumerStatefulWidget {
  static route(ComplainModel complain) => MaterialPageRoute(
      builder: (context) => ComplainReplyViewCard(
            complain: complain,
          ));
  final ComplainModel complain;
  const ComplainReplyViewCard({
    super.key,
    required this.complain,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ComplainReplyViewCardState();
}

class _ComplainReplyViewCardState extends ConsumerState<ComplainReplyViewCard> {
  bool isUpvoted = false;
  bool isDownvoted = false;
  final commentController = TextEditingController();

  int upvoteCount = 0;
  int downvoteCount = 0;

  LatLng getGoogleMapLocation() {
    final googleMapLocation = stringToLatLng(widget.complain.currentLocation);
    return googleMapLocation;
  }

  @override
  void initState() {
    super.initState();
    upvoteCount = widget.complain.upvotes.length;
    downvoteCount = widget.complain.downvotes.length;
  }

  void onComment() {
    ref.watch(commentControllerProvider.notifier).uploadComment(
          commentText: commentController.text,
          context: context,
          repliedTo: widget.complain.id,
        );

    commentController.clear();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final complainController = ref.read(complainControllerProvider.notifier);
    final isLoading = ref.watch(commentControllerProvider);
    final commentCount = ref
        .watch(commentControllerProvider.notifier)
        .fetchReplyCount(widget.complain.id);

    logger.d(commentCount);

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
                          user.isVerified
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Pallete.buttonColor
                                                .withOpacity(0.7),
                                            Pallete.buttonColor
                                                .withOpacity(0.9),
                                            Pallete.buttonColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    badges.Badge(
                                      badgeContent: const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      badgeStyle: const badges.BadgeStyle(
                                        shape: badges.BadgeShape.twitter,
                                        badgeColor: Pallete.buttonColor,
                                        padding: EdgeInsets.all(6),
                                      ),
                                      position: badges.BadgePosition.topEnd(
                                          top: -6, end: -3),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.profilePic),
                                        radius: 22,
                                      ),
                                    ),
                                  ],
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.profilePic),
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
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
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Location :  ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy',
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.complain.location,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy',
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Posting Location :',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (widget.complain.currentLocation !=
                              'Location not available')
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: getGoogleMapLocation(),
                                    zoom: 15,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId('complaint_location'),
                                      position: getGoogleMapLocation(),
                                    ),
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(height: 25),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Images Uploaded :',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (widget.complain.imageLinks.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: CarouselImage(
                                    imageLinks: widget.complain.imageLinks),
                              ),
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
                                        complainController.downvoteComplain(
                                            widget.complain, currentUser);
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

                                  return isUpvoted;
                                },
                                likeCountAnimationDuration:
                                    const Duration(milliseconds: 100),
                                likeBuilder: (isLiked) {
                                  return isLiked
                                      ? SvgPicture.asset(
                                          AssetsConstants.upvoteFilled,
                                          colorFilter: const ColorFilter.mode(
                                            Pallete.buttonColor,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          AssetsConstants.upvoteOutlined,
                                          height: 25,
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 146, 144, 144),
                                              BlendMode.srcIn),
                                        );
                                },
                                likeCount: upvoteCount,
                                countBuilder: (likeCount, isLiked, text) {
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
                                width: 62,
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
                                          complainController.upvoteComplain(
                                              widget.complain, currentUser);
                                        }
                                        downvoteCount++; // Increase downvote count
                                        complainController.downvoteComplain(
                                            widget.complain, currentUser);
                                      } else {
                                        downvoteCount--; // Decrease downvote count if un-downvoted
                                        complainController.downvoteComplain(
                                            widget.complain, currentUser);
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
                                            AssetsConstants.downvoteFilled,
                                            colorFilter: const ColorFilter.mode(
                                              Pallete.buttonColor,
                                              BlendMode.srcIn,
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            AssetsConstants.downvoteOutlined,
                                            height: 25,
                                            colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 146, 144, 144),
                                              BlendMode.srcIn,
                                            ),
                                          );
                                  },
                                  likeCount: downvoteCount,
                                  countBuilder: (likeCount, isLiked, text) {
                                    // Negate the likeCount to make it negative
                                    int negativeCount =
                                        likeCount != null ? -likeCount : 0;
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
                                width: 62,
                              ),
                              FutureBuilder(
                                future: ref
                                    .read(commentControllerProvider.notifier)
                                    .fetchReplyCount(widget.complain.id),
                                builder: (context, snapshot) {
                                  final commentCount = snapshot.data ?? 0;
                                  return ComplainIconButton(
                                    pathName: AssetsConstants.views,
                                    text: (commentCount +
                                            upvoteCount +
                                            downvoteCount)
                                        .toString(),
                                    onTap: () {},
                                    height: 27,
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 62,
                              ),
                              FutureBuilder(
                                future: ref
                                    .read(commentControllerProvider.notifier)
                                    .fetchReplyCount(widget.complain.id),
                                builder: (context, snapshot) {
                                  final commentCount = snapshot.data ?? 0;
                                  return ComplainIconButton(
                                    pathName: AssetsConstants.comment,
                                    text: commentCount.toString(),
                                    height: 20,
                                    onTap: () {
                                      setState(() {
                                        HapticFeedback.mediumImpact();
                                      });
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              Colors.yellow.withOpacity(0.03),
                                              BlendMode.srcATop,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Pallete.backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: 500,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          user.profilePic,
                                                        ),
                                                        radius: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              'Commenting on ',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 15,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${user.name}\'s',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Mulish',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  ' complaint.',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Mulish',
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        height: 35,
                                                        width: 80,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 15),
                                                          child: CommentButton(
                                                            buttonText: 'Post',
                                                            isLoading:
                                                                isLoading,
                                                            onPressed:
                                                                onComment,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 400,
                                                    height: 150,
                                                    child: TextField(
                                                      controller:
                                                          commentController,
                                                      maxLength: 150,
                                                      maxLines: 5,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      onChanged: (value) {
                                                        SchedulerBinding
                                                            .instance
                                                            .addPostFrameCallback(
                                                                (_) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      onTapOutside:
                                                          (PointerDownEvent
                                                              event) {
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Comment you reply',
                                                        hintStyle: TextStyle(
                                                          fontFamily: 'Gilroy',
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        counterText: '',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
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
                    ),
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
