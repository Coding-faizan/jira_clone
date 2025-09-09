import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/alert_dialogs.dart';
import 'package:jira_clone/src/common_widgets/confirmation_dialog.dart';
import 'package:jira_clone/src/common_widgets/delete_button.dart';
import 'package:jira_clone/src/common_widgets/edit_button.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineers_count_state.dart';
import 'package:jira_clone/src/features/sprint/domain/sprint.dart';
import 'package:jira_clone/src/features/sprint/presentation/providers/sprint_detail_controller.dart';
import 'package:jira_clone/src/features/sprint/presentation/sprint_detail_dialog.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/get_tickets.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/ticket_detail_controller.dart';
import 'package:jira_clone/src/features/ticket/presentation/ticket_detail_dialog.dart';
import 'package:jira_clone/src/routing/app_route.dart';

class SprintDetailScreen extends ConsumerWidget {
  final Sprint sprint;

  const SprintDetailScreen({super.key, required this.sprint});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsProvider = ref.watch(getTicketsProvider(sprint.id!));
    final developers = ref.watch(developersProvider);
    final testers = ref.watch(testersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint Details'),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(sprintDetailControllerProvider.notifier)
                .toggleSprintCompletion(sprint),
            icon: Icon(Icons.check_circle, color: Colors.green),
          ),
          EditButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return SprintDetailDialog(sprint: sprint);
              },
            ),
          ),
          DeleteButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  onConfirmation: () async {
                    await ref
                        .read(sprintDetailControllerProvider.notifier)
                        .deleteSprint(sprint.id!);
                    if (context.mounted) context.go(AppRoute.mainDashboard);
                  },
                  title: 'Delete Sprint',
                  content: 'Are you sure you want to delete this sprint?',
                );
              },
            ),
          ),
        ],
      ),
      body: ticketsProvider.when(
        data: (data) {
          return data.isEmpty
              ? Center(child: Text('No tickets to show'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final ticket = data[index];

                    return ListTile(
                      title: Text(ticket.title),
                      subtitle: Text(ticket.status.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (ticket.status != TicketStatus.done)
                            EditButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return TicketDetailDialog(
                                    ticket: ticket,
                                    sprintId: sprint.id!,
                                  );
                                },
                              ),
                            ),
                          DeleteButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return ConfirmationDialog(
                                  onConfirmation: () {
                                    ref
                                        .read(
                                          ticketDetailControllerProvider
                                              .notifier,
                                        )
                                        .deleteTicket(ticket.id!);
                                    context.pop();
                                  },
                                  title: 'Delete Ticket',
                                  content:
                                      'Are you sure you want to delete this ticket?',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
        error: (error, st) {
          return Center(child: Text('Error: $error'));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (developers.isNotEmpty && testers.isNotEmpty)
            ? () => showDialog(
                context: context,
                builder: (context) {
                  return TicketDetailDialog(sprintId: sprint.id!);
                },
              )
            : () => showAlertDialog(
                context: context,
                title: 'Insufficient Engineers',
                content:
                    'Please add at least one developer and one tester to the board before creating a ticket.',
              ),
        child: Icon(Icons.add),
      ),
    );
  }
}
