class Ticket {
  int? id;
  String title;
  String description;
  String status;
  List<String> developers;
  List<String> testers;
  Ticket({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.developers,
    required this.testers,
  });

  Ticket copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    List<String>? developers,
    List<String>? testers,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      developers: developers ?? this.developers,
      testers: testers ?? this.testers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TicketFields.id: id,
      TicketFields.title: title,
      TicketFields.description: description,
      TicketFields.status: status,
      TicketFields.developers: developers,
      TicketFields.testers: testers,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map[TicketFields.id] != null ? map[TicketFields.id] as int : null,
      title: map[TicketFields.title] as String,
      description: map[TicketFields.description] as String,
      status: map[TicketFields.status] as String,
      developers: List<String>.from(
        (map[TicketFields.developers] as List<String>),
      ),
      testers: List<String>.from((map[TicketFields.testers] as List<String>)),
    );
  }
}

class TicketFields {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const status = 'status';
  static const developers = 'developers';
  static const testers = 'testers';
  static const sprintId = 'sprint_id';
}
