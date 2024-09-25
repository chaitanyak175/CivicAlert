import 'dart:io';

import 'package:civicalert/apis/complain_api.dart';
import 'package:civicalert/apis/storage_api.dart';
import 'package:civicalert/core/failure.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final complainControllerProvider =
    StateNotifierProvider<ComplainController, bool>((ref) {
  return ComplainController(
    ref: ref,
    complainAPI: ref.watch(complainAPIProvider),
    storageAPI: ref.watch(storageApiProvider),
  );
});

class ComplainController extends StateNotifier<bool> {
  final Ref _ref;
  final ComplainAPI _complainAPI;
  final StorageApi _storageAPI;
  ComplainController(
      {required Ref ref,
      required ComplainAPI complainAPI,
      required StorageApi storageAPI})
      : _ref = ref,
        _complainAPI = complainAPI,
        _storageAPI = storageAPI,
        super(false);

  void shareComplain({
    required String title,
    required String description,
    required String location,
    required String contactNumber,
    required List<File> images,
    required String currentLocation,
    required BuildContext context,
  }) {
    if (title.isEmpty) {
      showSnackBar(context, 'Please Enter the Title');
    }
    if (description.isEmpty) {
      showSnackBar(context, 'Please Enter the Description');
    }
    if (location.isEmpty) {
      showSnackBar(context, 'Please Enter the Location');
    }
    if (contactNumber.isEmpty) {
      showSnackBar(context, 'Please Enter the Contact Number');
    }
    if (images.isEmpty) {
      showSnackBar(context, 'Please Upload Photos');
    } else {
      _shareComplain(
        title: title,
        description: description,
        location: location,
        contactNumber: contactNumber,
        images: images,
        currentLocation: currentLocation,
        context: context,
      );
    }
  }

  void _shareComplain({
    required String title,
    required String description,
    required String location,
    required String contactNumber,
    required List<File> images,
    required String currentLocation,
    required BuildContext context,
  }) async {
    state = true;
    logger.d(_ref.watch(currentUserDetailsProvider).value);
    final user = _ref.watch(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImages(images);
    logger.d(user.uid);
    ComplainModel complain = ComplainModel(
      title: title,
      description: description,
      location: location,
      contactNumber: contactNumber,
      imageLinks: imageLinks,
      currentLocation: currentLocation,
      uid: user.uid,
      complainedAt: DateTime.now(),
      upvotes: [],
      downvotes: [],
      commentIds: [],
      id: '',
      reshareCount: 0,
    );
    final res = await _complainAPI.shareComplain(complain);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }
}
