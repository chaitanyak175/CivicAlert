import 'dart:io';

import 'package:civicalert/constants/assets_constants.dart';
import 'package:civicalert/features/complain/widgets/buttons/add_more_photos_button.dart';
import 'package:civicalert/features/complain/widgets/custom_painter.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildImageUploadSection(
    List<File> images, GestureTapCallback onPickImages) {
  if (images.isEmpty) {
    return GestureDetector(
      onTap: onPickImages,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        color: Pallete.backgroundColor,
        child: CustomPaint(
          painter: DashedBorderPainter(),
          child: Container(
            width: 350,
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  height: 60,
                  AssetsConstants.imagePicker,
                  colorFilter: const ColorFilter.mode(
                    Pallete.buttonColor,
                    BlendMode.srcIn,
                  ),
                ),
                const Text(
                  'Select Images to Upload',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CarouselView(
            itemSnapping: true,
            backgroundColor: Pallete.coinswtichColor,
            itemExtent: 250,
            children: images.map(
              (file) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        const SizedBox(height: 10),
        AddMorePhotos(
          buttonText: 'Add more Photos',
          onTap: onPickImages,
        ),
      ],
    );
  }
}
