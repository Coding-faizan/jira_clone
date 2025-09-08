import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/main_dashboard.dart';
import 'package:jira_clone/src/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:jira_clone/src/features/auth/presentation/screens/login_screen.dart';
import 'package:jira_clone/src/features/auth/presentation/screens/password_reset_screen.dart';
import 'package:jira_clone/src/features/profile/presentation/widgets/manage_engineers_screen.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/sprint/presentation/sprint_detail_screen.dart';
import 'package:jira_clone/src/routing/app_route.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.login,
    routes: [
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
      GoRoute(
        path: AppRoute.mainDashboard,
        builder: (context, state) {
          return const MainDashboard();
        },
      ),
      GoRoute(
        path: AppRoute.manageEngineers,
        builder: (context, state) {
          return const ManageEngineersScreen();
        },
      ),
      GoRoute(
        path: AppRoute.sprintDetail,
        builder: (context, state) {
          final sprint = state.extra as Sprint;
          return SprintDetailScreen(sprint: sprint);
        },
      ),
    ],
  );
});
