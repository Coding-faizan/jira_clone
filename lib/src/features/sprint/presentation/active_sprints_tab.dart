import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/extensions.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/get_sprints.dart';
import 'package:jira_clone/src/features/sprint/presentation/sprint_detail_dialog.dart';
import 'package:jira_clone/src/routing/app_route.dart';

class ActiveSprintsTab extends ConsumerWidget {
  const ActiveSprintsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSprints = ref.watch(activeSprintsProvider);
    return Scaffold(
      body: activeSprints.isEmpty
          ? Center(child: Text('No Active Sprints'))
          : ListView.builder(
              itemCount: activeSprints.length,
              itemBuilder: (context, index) {
                final sprint = activeSprints[index];
                return ListTile(
                  title: Text(sprint.title),
                  subtitle: Text(
                    'From ${sprint.startDate.toFormattedString()} to ${sprint.endDate.toFormattedString()}',
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () =>
                      context.push(AppRoute.sprintDetail, extra: sprint),
                );
              },
            ),
      floatingActionButton: activeSprints.length == 2
          ? null
          : FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return SprintDetailDialog();
                },
              ),
              child: Icon(Icons.add),
            ),
    );
  }
}
