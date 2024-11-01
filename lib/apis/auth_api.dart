import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:civicalert/core/failure.dart';
import 'package:civicalert/core/providers.dart';
import 'package:civicalert/core/type_defs.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthApi(account: account);
});

abstract class IAuthApi {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
  Future<model.User?> currentUserAccount();
  FutureEitherVoid logout();
}

class AuthApi extends IAuthApi {
  final Account _account;
  AuthApi({required Account account}) : _account = account;
  @override
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      String message = 'Something went wrong';
      if (e.code == 409) {
        message = 'Email already exists';
      } else if (e.code == 400) {
        message = 'Invalid email or password format';
      }
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
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
  FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      String message = 'Something went wrong';
      if (e.code == 409) {
        message = 'Email already exists';
      } else if (e.code == 400) {
        message = 'Invalid email or password format';
      }
      return left(
        Failure(
          message,
          stackTrace,
        ),
      );
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
  Future<model.User?> currentUserAccount() async {
    try {
      // Make sure to await the API call properly.
      final user = await _account.get();
      logger.d(user);
      return user;
    } on AppwriteException catch (e) {
      logger.e("AppwriteException: $e");
      return null;
    } catch (e) {
      logger.e("Unexpected error: $e");
      return null;
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      String message = 'Something went wrong';
      if (e.code == 409) {
        message = 'Email already exists';
      } else if (e.code == 400) {
        message = 'Invalid email or password format';
      }
      return left(
        Failure(
          message,
          stackTrace,
        ),
      );
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
