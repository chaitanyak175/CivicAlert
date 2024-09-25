import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:civicalert/core/failure.dart';
import 'package:civicalert/core/providers.dart';
import 'package:civicalert/core/type_defs.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final complainAPIProvider = Provider((ref) {
  return ComplainAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IComplainAPI {
  FutureEither<Document> shareComplain(ComplainModel model);
}

class ComplainAPI implements IComplainAPI {
  final Databases _db;
  ComplainAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareComplain(ComplainModel complain) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.complainCollections,
        documentId: ID.unique(),
        data: complain.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace,
      ));
    } catch (e, stackTrace) {
      return left(
        Failure(
          e.toString(),
          stackTrace,
        ),
      );
    }
  }
}