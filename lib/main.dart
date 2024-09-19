import 'dart:developer';

import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/auth/view/signup_view.dart';
import 'package:civicalert/features/home/view/home_view.dart';
import 'package:civicalert/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDisplayMode.setHighRefreshRate().catchError((e) {
    log('Error setting the High Refresh Rate');
  });

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignupView();
            },
            error: (error, stackTrace) {
              return ErrorPage(
                error: error.toString(),
              );
            },
            loading: () => const LoadingPage(),
          ),
    );
  }
}
