import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLikeButton extends StatelessWidget {
  final int initialLikeCount;

  const CustomLikeButton({
    Key? key,
    required this.initialLikeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 26,
      likeCount: initialLikeCount,
      countBuilder: (count, isLiked, text) {
        return Container(
          margin: const EdgeInsets.all(3.0),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 15,
              color: isLiked
                  ? Pallete.buttonColor
                  : const Color.fromARGB(255, 117, 116, 116),
            ),
          ),
        );
      },
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
                  Color.fromARGB(255, 146, 144, 144),
                  BlendMode.srcIn,
                ),
              );
      },
      onTap: (isLiked) async {
        // This function will be called when the button is tapped
        // You can implement your logic here to update the like count
        // For example, you might want to call an API to update the like status

        // For demonstration, we'll just return the opposite of current status
        return !isLiked;
      },
      countPostion: CountPostion.right,
    );
  }
}
