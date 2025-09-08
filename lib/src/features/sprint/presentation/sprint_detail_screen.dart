import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/sprint_detail_controller.dart';
import 'package:jira_clone/src/features/sprint/presentation/sprint_detail_dialog.dart';
import 'package:jira_clone/src/routing/app_route.dart';

class SprintDetailScreen extends ConsumerWidget {
  final Sprint sprint;

  const SprintDetailScreen({super.key, required this.sprint});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_circle, color: Colors.green),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return SprintDetailDialog(sprint: sprint);
              },
            ),
          ),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete Sprint'),
                  content: Text('Are you sure you want to delete this sprint?'),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(sprintDetailControllerProvider.notifier)
                            .deleteSprint(sprint.id!);
                        if (context.mounted) context.go(AppRoute.mainDashboard);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                );
              },
            ),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(child: Text('No tickets to show')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
