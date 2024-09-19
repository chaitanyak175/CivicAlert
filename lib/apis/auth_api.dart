import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:civicalert/core/failure.dart';
import 'package:civicalert/core/providers.dart';
import 'package:civicalert/core/type_defs.dart';
import 'package:flutter/material.dart';
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
        Failure(
          message: message,
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: stackTrace,
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
          message: message,
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
