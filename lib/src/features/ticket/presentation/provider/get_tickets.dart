import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/ticket/data/ticket_repository.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';

final getTicketsProvider = FutureProvider.autoDispose.family<List<Ticket>, int>(
  (ref, sprintId) async {
    final repository = ref.watch(ticketRepositoryProvider);
    return await repository.getTickets(sprintId);
  },
);
