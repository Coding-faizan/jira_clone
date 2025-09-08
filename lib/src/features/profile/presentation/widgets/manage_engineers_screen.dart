import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/confirmation_dialog.dart';
import 'package:jira_clone/src/features/profile/presentation/widgets/engineer_detail_dialog.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineer_detail_controller.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineers_count_state.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';

class ManageEngineersScreen extends ConsumerWidget {
  const ManageEngineersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final engineersAsyncValue = ref.watch(getEngineersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Engineers')),
      floatingActionButton:
          ref.watch(developersProvider).length +
                  ref.watch(testersProvider).length ==
              5
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return EngineerDetailDialog();
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
      body: engineersAsyncValue.when(
        data: (engineers) {
          return engineers.isEmpty
              ? Center(child: Text('No engineers to show'))
              : Column(
                  children: [
                    Text('Engineers: ${engineers.length}/5'),
                    Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: engineers.length,
                        itemBuilder: (context, index) {
                          final engineer = engineers[index];
                          return ListTile(
                            title: Text(engineer.name),
                            subtitle: Text(engineer.role),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EngineerDetailDialog(
                                          engineer: engineer,
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ConfirmationDialog(
                                          title: 'Delete Engineer',
                                          content:
                                              'Are you sure you want to delete this engineer?',
                                          onConfirmation: () {
                                            ref
                                                .read(
                                                  engineerDetailControllerProvider
                                                      .notifier,
                                                )
                                                .deleteEngineer(engineer.id!);
                                            context.pop();
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
