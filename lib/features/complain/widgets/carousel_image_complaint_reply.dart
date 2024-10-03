import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:civicalert/features/complain/widgets/full_screen_image_viewer.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;
  const CarouselImage({
    super.key,
    required this.imageLinks,
  });

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;

  void _openFullScreen(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imageLinks.map(
                (link) {
                  return GestureDetector(
                    onTap: () {
                      _openFullScreen(context, link);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          link,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                pageSnapping: true,
                height: 250,
                enlargeCenterPage: true,
                animateToClosest: true,
                viewportFraction: 0.5,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLinks.asMap().entries.map((e) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(
                      _current == e.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        )
      ],
    );
  }
}
