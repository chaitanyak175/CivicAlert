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
  return ComplainAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class IComplainAPI {
  FutureEither<Document> shareComplain(ComplainModel model);
  Future<List<Document>> getComplains();
  Future<List<Document>> getComplainsByUid(String uid);
  Stream<RealtimeMessage> getLatestComplain();
  FutureEither<Document> upvoteComplain(ComplainModel model);
  FutureEither<Document> downvoteComplain(ComplainModel model);
}

class ComplainAPI implements IComplainAPI {
  final Databases _db;
  final Realtime _realtime;
  ComplainAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;

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

  @override
  Future<List<Document>> getComplains() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.complainCollections,
      queries: [
        Query.orderDesc('complainedAt'),
      ],
    );
    return documents.documents;
  }

  @override
  Future<List<Document>> getComplainsByUid(String uid) async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.complainCollections,
      queries: [
        Query.equal('uid', uid),
        Query.orderDesc('complainedAt'),
      ],
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestComplain() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.complainCollections}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> upvoteComplain(ComplainModel complain) async {
    try {
      final document = await _db.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.complainCollections,
        documentId: complain.id,
        data: {
          'upvotes': complain.upvotes,
        },
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

  @override
  FutureEither<Document> downvoteComplain(ComplainModel complain) async {
    try {
      final document = await _db.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.complainCollections,
        documentId: complain.id,
        data: {
          'downvotes': complain.downvotes,
        },
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
