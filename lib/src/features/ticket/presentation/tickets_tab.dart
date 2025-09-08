import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jira_clone/src/features/ticket/presentation/provider/get_tickets.dart';

class TicketsTab extends ConsumerWidget {
  const TicketsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(getTicketsProvider);

    return Scaffold(
      body: tickets.when(
        data: (tickets) {
          return tickets.isEmpty
              ? Center(child: Text('No tickets found'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return ListTile(
                        title: Text(ticket.title),
                        subtitle: Text(ticket.description),
                      );
                    },
                  ),
                );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle ticket creation
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
