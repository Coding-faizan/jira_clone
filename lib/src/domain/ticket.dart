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
