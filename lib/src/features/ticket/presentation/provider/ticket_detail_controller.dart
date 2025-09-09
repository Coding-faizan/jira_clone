import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/profile/domain/engineer.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/engineer_detail_controller.dart';
import 'package:jira_clone/src/features/profile/presentation/providers/get_engineers_provider.dart';
import 'package:jira_clone/src/features/ticket/data/ticket_repository.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/get_tickets.dart';

class TicketDetailController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveTicketDetails(
    Ticket ticket,
    bool isNew, {
    Engineer? prevDev,
    Engineer? prevTester,
  }) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);
    final engineerController = ref.read(
      engineerDetailControllerProvider.notifier,
    );
    state = AsyncValue.loading();
    if (isNew) {
      await engineerController.toggleTicketAssignment(ticket.developer);
      await engineerController.toggleTicketAssignment(ticket.tester);
      state = await AsyncValue.guard(
        () => ticketRepository.insertTicket(ticket),
      );
      ref.invalidate(getEngineersProvider);
    } else {
      if (ticket.developer.id != prevDev!.id!) {
        await engineerController.toggleTicketAssignment(prevDev);
        await engineerController.toggleTicketAssignment(ticket.developer);

        ref.invalidate(getEngineersProvider);
      }
      if (ticket.tester.id != prevTester!.id!) {
        await engineerController.toggleTicketAssignment(prevTester);

        ref.invalidate(getEngineersProvider);
      }
      await engineerController.toggleTicketAssignment(ticket.tester);
      state = await AsyncValue.guard(
        () => ticketRepository.updateTicket(ticket),
      );
    }

    ref.invalidate(getTicketsProvider);
  }

  Future<void> deleteTicket(Ticket ticket) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);
    state = AsyncValue.loading();
    final engineerController = ref.read(
      engineerDetailControllerProvider.notifier,
    );
    await engineerController.toggleTicketAssignment(ticket.developer);
    await engineerController.toggleTicketAssignment(ticket.tester);
    ref.invalidate(getEngineersProvider);
    state = await AsyncValue.guard(
      () => ticketRepository.deleteTicket(ticket.id!),
    );
    ref.invalidate(getTicketsProvider);
  }
}

final ticketDetailControllerProvider = AsyncNotifierProvider(
  () => TicketDetailController(),
);
