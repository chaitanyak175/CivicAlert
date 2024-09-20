import 'package:civicalert/apis/auth_api.dart';
import 'package:civicalert/apis/user_api.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/view/login_view.dart';
import 'package:civicalert/features/home/view/home_view.dart';
import 'package:civicalert/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;
import 'package:logger/logger.dart';

var logger = Logger();

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authAPI = ref.watch(authAPIProvider);
  final userAPI = ref.watch(userAPIProvider);
  return AuthController(
    authAPI: authAPI,
    userAPI: userAPI,
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  // final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  // logger.d(currentUserId);
  // final userDetails = ref.watch(userDetailProvider(currentUserId));
  // logger.d(userDetails);
  // return userDetails.value;

  final currentUser = ref.watch(currentUserAccountProvider).value;
  if (currentUser == null) {
    return null; // Or handle loading/error state
  }
  final currentUserId = currentUser.$id;
  final userDetails = ref.watch(userDetailProvider(currentUserId));
  return userDetails.value;
});

final userDetailProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authAPI;
  final UserApi _userAPI;
  AuthController({required AuthApi authAPI, required UserApi userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
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
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          address: '',
          uid: r.$id,
          profilePic: '',
          mobileNo: '',
          isVerified: false,
        );
        final re2 = await _userAPI.saveUserDate(userModel);
        re2.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
            showSnackBar(context, 'Account create Please login');
            Navigator.pushAndRemoveUntil(
              context,
              LoginView.route(),
              (route) => false,
            );
          },
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

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    logger.i('document for current user found!');
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
