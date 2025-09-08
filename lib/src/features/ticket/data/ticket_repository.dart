import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/ticket/data/ticket_data_source.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';

class TicketRepository {
  final TicketDataSource _dataSource;

  TicketRepository({required TicketDataSource dataSource})
    : _dataSource = dataSource;

  Future<List<Ticket>> getTickets() async {
    return await _dataSource.getTickets();
  }

  Future<void> insertTicket(Ticket ticket) async {
    await _dataSource.insertTicket(ticket);
  }

  Future<void> updateTicket(Ticket ticket) async {
    await _dataSource.updateTicket(ticket);
  }

  Future<void> deleteTicket(int id) async {
    await _dataSource.deleteTicket(id);
  }
}

final ticketRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(ticketDataSourceProvider);
  return TicketRepository(dataSource: dataSource);
});
