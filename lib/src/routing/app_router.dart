import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/main.dart';
import 'package:jira_clone/src/features/presentation/screens/forgot_password_screen.dart';
import 'package:jira_clone/src/features/presentation/screens/login_screen.dart';
import 'package:jira_clone/src/features/presentation/screens/password_reset_screen.dart';
import 'package:jira_clone/src/routing/app_route.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.login,
    routes: [
      GoRoute(
        path: AppRoute.home,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoute.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoute.forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordScreen();
        },
      ),
      GoRoute(
        path: AppRoute.resetPassword,
        builder: (context, state) {
          final email = state.extra as String;
          return PasswordResetScreen(email: email);
        },
      ),
    ],
  );
});
