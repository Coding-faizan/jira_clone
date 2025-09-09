import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/confirmation_dialog.dart';
import 'package:jira_clone/src/extensions.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/get_sprints.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/sprint_detail_controller.dart';

class CompletedSprintTab extends ConsumerWidget {
  const CompletedSprintTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedSprints = ref.watch(completedSprintsProvider);
    return Scaffold(
      body: completedSprints.isEmpty
          ? Center(child: Text('No Completed Sprints'))
          : ListView.builder(
              itemCount: completedSprints.length,
              itemBuilder: (context, index) {
                final sprint = completedSprints[index];
                return ListTile(
                  title: Text(sprint.title),
                  subtitle: Text(
                    'From ${sprint.startDate.toFormattedString()} to ${sprint.endDate.toFormattedString()}',
                  ),
                  trailing: IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          title: 'Delete Sprint',
                          content:
                              'Are you sure you want to delete this sprint?',
                          onConfirmation: () async {
                            await ref
                                .read(sprintDetailControllerProvider.notifier)
                                .deleteSprint(sprint.id!);
                            if (context.mounted) context.pop();
                          },
                        );
                      },
                    ),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
