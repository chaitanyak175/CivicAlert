import 'package:appwrite/appwrite.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:civicalert/core/failure.dart';
import 'package:civicalert/core/providers.dart';
import 'package:civicalert/core/type_defs.dart';
import 'package:civicalert/models/user_model.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return UserApi(db: db);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserDate(UserModel usermodel);
  Future<model.Document> getUserData(String uid);
}

class UserApi extends IUserAPI {
  final Databases _db;
  UserApi({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserDate(UserModel usermodel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollections,
        documentId: usermodel.uid,
        data: usermodel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollections,
      documentId: uid,
    );
  }
}
