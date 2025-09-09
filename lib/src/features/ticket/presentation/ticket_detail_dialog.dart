import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/profile/data/engineer/engineer_repo.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineers_role_based_provider.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/ticket_detail_controller.dart';
import 'package:jira_clone/src/utils/validators.dart';

class TicketDetailDialog extends ConsumerStatefulWidget {
  const TicketDetailDialog({super.key, this.ticket, required this.sprintId});
  final Ticket? ticket;
  final int sprintId;
  @override
  ConsumerState<TicketDetailDialog> createState() => _TicketDetailDialogState();
}

class _TicketDetailDialogState extends ConsumerState<TicketDetailDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TicketStatus _status = TicketStatus.toDo;
  Engineer? _selectedDeveloper;
  Engineer? _selectedTester;

  String engineerRole = '';

  String get ticketTitle => _nameController.text;
  String get ticketDescription => _descriptionController.text;

  bool get isNewTicket => widget.ticket == null;

  final _ticketDetailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (!isNewTicket) {
      _nameController.text = widget.ticket!.title;
      _descriptionController.text = widget.ticket!.description;
      _status = widget.ticket!.status;
      _selectedDeveloper = widget.ticket!.developer;
      _selectedTester = widget.ticket!.tester;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final developers = ref.watch(developersProvider);
    final testers = ref.watch(testersProvider);
    final ticketDetailState = ref.watch(ticketDetailControllerProvider);
    return AlertDialog(
      title: Text('Ticket Details'),
      content: Form(
        key: _ticketDetailFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              controller: _nameController,
              label: 'Title',
              validator: Validators.validateName,
              maxLength: 50,
            ),
            gapH4,
            CustomFormField(
              controller: _descriptionController,
              label: 'Description (optional)',
              maxLength: 100,
            ),
            gapH16,
            DropdownButtonFormField<Engineer>(
              value: _selectedDeveloper,
              decoration: const InputDecoration(
                labelText: 'Assign developer',
                border: OutlineInputBorder(),
              ),
              items: developers
                  .map((d) => DropdownMenuItem(value: d, child: Text(d.name)))
                  .toList(),
              validator: (value) =>
                  value == null ? 'Please select a developer' : null,
              onChanged: (value) {
                _selectedDeveloper = value;
              },
            ),
            gapH16,
            DropdownButtonFormField<Engineer>(
              value: _selectedTester,
              decoration: InputDecoration(
                labelText: 'Assign tester',
                border: OutlineInputBorder(),
              ),
              items: testers
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                  .toList(),
              validator: (value) =>
                  value == null ? 'Please select a tester' : null,
              onChanged: (value) {
                _selectedTester = value!;
              },
            ),
            gapH16,
            if (!isNewTicket)
              DropdownButtonFormField<TicketStatus>(
                value: _status,
                items: TicketStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.name),
                      ),
                    )
                    .toList(),

                onChanged: (value) {
                  _status = value!;
                },
              ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_ticketDetailFormKey.currentState!.validate()) {
              Ticket ticket;
              if (isNewTicket) {
                ticket = Ticket(
                  title: ticketTitle,
                  description: ticketDescription,
                  status: TicketStatus.toDo,
                  developer: _selectedDeveloper!,
                  tester: _selectedTester!,
                  sprintId: widget.sprintId,
                );
              } else {
                ticket = widget.ticket!.copyWith(
                  title: ticketTitle,
                  description: ticketDescription,
                  status: _status,
                  developer: _selectedDeveloper,
                  tester: _selectedTester,
                );
              }
              final ticketDetailController = ref.read(
                ticketDetailControllerProvider.notifier,
              );
              await ticketDetailController.saveTicketDetails(
                ticket,
                isNewTicket,
                prevDev: isNewTicket ? null : widget.ticket!.developer,
                prevTester: isNewTicket ? null : widget.ticket!.tester,
              );
              if (context.mounted) {
                context.pop();
              }
            }
          },
          child: ticketDetailState.isLoading
              ? CircularProgressIndicator()
              : Text('Save'),
        ),
      ],
    );
  }
}
