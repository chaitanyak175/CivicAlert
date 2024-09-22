import 'dart:io';

import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

var log = Logger();

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Pallete.scaffoldMessengerColor,
    ),
  );
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}

Future<List<File>> imagePicker() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

// log.d('Location Permission denied!');

Future<bool> requestLocationPermission() async {
  PermissionStatus status = await Permission.locationWhenInUse.status;
  if (!status.isGranted) {
    status = await Permission.locationWhenInUse.request();
  }
  return status.isGranted;
}

void showLocationPermissionSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Center(
        child: Text(
          'Location permission is required to submit complaints.',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Pallete.scaffoldMessengerColor,
    ),
  );
}
