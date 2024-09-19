import 'package:civicalert/apis/auth_api.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/view/login_view.dart';
import 'package:civicalert/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authAPI = ref.watch(authAPIProvider);
  return AuthController(authAPI: authAPI);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authAPI;
  AuthController({required AuthApi authAPI})
      : _authAPI = authAPI,
        super(false);

  void signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) {
        showSnackBar(context, 'Account create Please login');
        Navigator.pushAndRemoveUntil(
          context,
          LoginView.route(),
          (route) => false,
        );
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Navigator.push(
        context,
        HomeView.route(),
      ),
    );
  }

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();
}
