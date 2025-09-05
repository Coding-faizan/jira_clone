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

  Sprint copyWith({
    int? id,
    String? title,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Sprint(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SprintFields.id: id,
      SprintFields.title: title,
      SprintFields.status: status,
      SprintFields.startDate: startDate.toIso8601String(),
      SprintFields.endDate: endDate.toIso8601String(),
    };
  }

  factory Sprint.fromMap(Map<String, dynamic> map) {
    return Sprint(
      id: map[SprintFields.id] != null ? map[SprintFields.id] as int : null,
      title: map[SprintFields.title] as String,
      status: map[SprintFields.status] as String,
      startDate: DateTime.parse(map[SprintFields.startDate] as String),
      endDate: DateTime.parse(map[SprintFields.endDate] as String),
    );
  }
}

class SprintFields {
  static const tableName = 'Sprint';
  static const id = 'id';
  static const title = 'title';
  static const status = 'status';
  static const startDate = 'startDate';
  static const endDate = 'endDate';
  static const adminId = 'admin_id';
}
