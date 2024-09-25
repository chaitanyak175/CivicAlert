class AppwriteConstants {
  static const String databaseId = '66ead9da002783c03acc';
  static const String projectId = '66ead92d0021cb334477';
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  static const String userCollections = '66ed9cdd00310fbefcd7';
  static const String complainCollections = '66f3e087001b34eef8b9';

  static const String imagesBucket = '66f402b7001ee5e848fa';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&project=$projectId&mode=admin';
}
