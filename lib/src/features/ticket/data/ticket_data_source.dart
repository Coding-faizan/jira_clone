import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/core/service/database_service.dart';
import 'package:jira_clone/src/features/ticket/domain/ticket.dart';
import 'package:sqflite/sqlite_api.dart';

class TicketDataSource {
  final Database _database;

  TicketDataSource({required Database database}) : _database = database;

  Future<List<Ticket>> getTickets(int sprintId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'Ticket',
      where: '${TicketFields.sprintId} = ?',
      whereArgs: [sprintId],
    );
    debugPrint('Fetched Tickets: $maps');
    return maps.map((map) => Ticket.fromMap(map)).toList();
  }

  Future<void> insertTicket(Ticket ticket) async {
    await _database.insert('Ticket', ticket.toMap());
  }

  Future<void> updateTicket(Ticket ticket) async {
    await _database.update(
      'Ticket',
      ticket.toMap(),
      where: '${TicketFields.id} = ?',
      whereArgs: [ticket.id],
    );
  }

  Future<void> deleteTicket(int id) async {
    await _database.delete(
      'Ticket',
      where: '${TicketFields.id} = ?',
      whereArgs: [id],
    );
  }
}

final ticketDataSourceProvider = Provider((ref) {
  final database = ref.read(dataBaseProvider);
  return TicketDataSource(database: database);
});
