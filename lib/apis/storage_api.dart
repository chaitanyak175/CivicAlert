import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:civicalert/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageApiProvider = Provider((ref) {
  return StorageApi(storage: ref.watch(appwriteStorageProvider));
});

class StorageApi {
  final Storage _storage;
  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImages(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: AppwriteConstants.imagesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
        ),
      );
      imageLinks.add(
        AppwriteConstants.imageUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }
}
