import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/confirmation_dialog.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/profile_controller.dart';
import 'package:jira_clone/src/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:jira_clone/src/routing/app_route.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ProfileActionTile(
          title: 'Manage Engineers',
          onTap: () {
            context.push(AppRoute.manageEngineers);
          },
          icon: Icons.people,
        ),
        ProfileActionTile(
          title: 'Recycle Bin',
          onTap: () {},
          icon: Icons.delete,
        ),
        ProfileActionTile(
          title: 'Delete Profile',
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return ConfirmationDialog(
                title: 'Delete Profile',
                content: 'Are you sure you want to delete your profile?',
                onConfirmation: () async {
                  await ref
                      .read(profileControllerProvider.notifier)
                      .deleteProfile();
                  if (context.mounted) context.go(AppRoute.login);
                },
              );
            },
          ),
          icon: Icons.delete,
        ),
        ProfileActionTile(
          title: 'Logout',
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return ConfirmationDialog(
                title: 'Logout',
                content: 'Are you sure you want to logout?',
                onConfirmation: () {
                  ref.read(profileControllerProvider.notifier).logout();
                  if (context.mounted) context.go(AppRoute.login);
                },
              );
            },
          ),
          icon: Icons.logout,
        ),
      ],
    );
  }
}
