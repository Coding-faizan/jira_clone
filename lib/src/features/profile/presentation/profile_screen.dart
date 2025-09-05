import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:jira_clone/src/routing/app_route.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          onTap: () {},
          icon: Icons.delete,
        ),
        ProfileActionTile(title: 'Logout', onTap: () {}, icon: Icons.logout),
      ],
    );
  }
}
