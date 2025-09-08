class Ticket {
  int? id;
  String title;
  String description;
  TicketStatus status;
  String developer;
  String tester;
  int sprintId;
  Ticket({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.developer,
    required this.tester,
    required this.sprintId,
  });

  Ticket copyWith({
    int? id,
    String? title,
    String? description,
    TicketStatus? status,
    String? developer,
    String? tester,
    int? sprintId,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      developer: developer ?? this.developer,
      tester: tester ?? this.tester,
      sprintId: sprintId ?? this.sprintId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TicketFields.id: id,
      TicketFields.title: title,
      TicketFields.description: description,
      TicketFields.status: status.name,
      TicketFields.developer: developer,
      TicketFields.tester: tester,
      TicketFields.sprintId: sprintId,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map[TicketFields.id] != null ? map[TicketFields.id] as int : null,
      title: map[TicketFields.title] as String,
      description: map[TicketFields.description] as String,
      status: TicketStatus.values.firstWhere(
        (e) => e.name == map[TicketFields.status],
      ),
      developer: map[TicketFields.developer] as String,
      tester: map[TicketFields.tester] as String,
      sprintId: map[TicketFields.sprintId] as int,
    );
  }
}

class TicketFields {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const status = 'status';
  static const developer = 'developer';
  static const tester = 'tester';
  static const sprintId = 'sprint_id';
}

enum TicketStatus {
  toDo('To Do'),
  inProgress('In Progress'),
  testing('Testing'),
  done('Done');

  final String name;

  const TicketStatus(this.name);
}
