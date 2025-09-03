class Sprint {
  int? id;
  String title;

  String status;
  DateTime startDate;
  DateTime endDate;
  Sprint({
    this.id,
    required this.title,
    required this.status,
    required this.startDate,
    required this.endDate,
  });
}

class SprintFields {
  static const id = 'id';
  static const title = 'title';
  static const status = 'status';
  static const startDate = 'startDate';
  static const endDate = 'endDate';
  static const adminId = 'admin_id';
}
