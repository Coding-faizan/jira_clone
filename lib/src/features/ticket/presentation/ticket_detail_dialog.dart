import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/common_widgets/custom_form_field.dart';
import 'package:jira_clone/src/constants/app_sizes.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/utils/validators.dart';

class TicketDetailDialog extends ConsumerStatefulWidget {
  const TicketDetailDialog({super.key, this.ticket});
  final Ticket? ticket;

  @override
  ConsumerState<TicketDetailDialog> createState() => _TicketDetailDialogState();
}

class _TicketDetailDialogState extends ConsumerState<TicketDetailDialog> {
  final TextEditingController _nameController = TextEditingController();

  String engineerRole = '';

  String get ticketTitle => _nameController.text;

  bool get isNewTicket => widget.ticket == null;

  final _ticketDetailFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Engineer Details'),
      content: Form(
        key: _ticketDetailFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              controller: _nameController,
              label: 'Name',
              validator: Validators.validateName,
            ),
            gapH8,
          ],
        ),
      ),
      actions: [],
    );
  }
}
