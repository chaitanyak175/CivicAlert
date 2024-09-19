import 'package:appwrite/appwrite.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appwriteClient = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppwriteConstants.endPoint)
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClient);
  return Account(client);
});
