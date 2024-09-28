import 'package:flutter/material.dart';

Widget buildImageLayout(List<String> imageLinks) {
  if (imageLinks.length == 1) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageLinks[0],
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  } else if (imageLinks.length == 2) {
    return SizedBox(
      width: double.infinity,
      height: 150,
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
            // flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageLinks[0],
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            // flex: 1,
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
