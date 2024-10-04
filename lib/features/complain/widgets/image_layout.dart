import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildImageLayout(List<String> imageLinks) {
  Widget shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  if (imageLinks.length == 1) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageLinks[0],
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return shimmerWidget();
          }
        },
      ),
    );
  } else if (imageLinks.length == 2) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Row(
        children: imageLinks
            .take(2)
            .map(
              (imageUrl) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      height: 150,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return shimmerWidget();
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  } else {
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageLinks[0],
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return shimmerWidget();
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageLinks[1],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return shimmerWidget();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageLinks[2],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return shimmerWidget();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
