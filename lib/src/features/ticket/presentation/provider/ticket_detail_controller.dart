import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/ticket/data/ticket_repository.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/get_tickets.dart';

class TicketDetailController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveTicketDetails(Ticket ticket, bool isNew) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);
    state = AsyncValue.loading();
    if (isNew) {
      state = await AsyncValue.guard(
        () => ticketRepository.insertTicket(ticket),
      );
    } else {
      state = await AsyncValue.guard(
        () => ticketRepository.updateTicket(ticket),
      );
    }

    ref.invalidate(getTicketsProvider);
  }
}

final ticketDetailControllerProvider = AsyncNotifierProvider(
  () => TicketDetailController(),
);
