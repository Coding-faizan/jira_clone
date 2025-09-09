class Sprint {
  int? id;
  String title;
  bool isActive;
  DateTime startDate;
  DateTime endDate;
  int adminId;
  Sprint({
    this.id,
    required this.title,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.adminId,
  });

  Sprint copyWith({
    int? id,
    String? title,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? adminId,
  }) {
    return Sprint(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SprintFields.id: id,
      SprintFields.title: title,
      SprintFields.isActive: isActive ? 1 : 0,
      SprintFields.startDate: startDate.toIso8601String(),
      SprintFields.endDate: endDate.toIso8601String(),
      SprintFields.adminId: adminId,
    };
  }

  factory Sprint.fromMap(Map<String, dynamic> map) {
    return Sprint(
      id: map[SprintFields.id] != null ? map[SprintFields.id] as int : null,
      title: map[SprintFields.title] as String,
      isActive: map[SprintFields.isActive] == 1,
      startDate: DateTime.parse(map[SprintFields.startDate] as String),
      endDate: DateTime.parse(map[SprintFields.endDate] as String),
      adminId: map[SprintFields.adminId] as int,
    );
  }
}

class SprintFields {
  static const tableName = 'Sprint';
  static const id = 'id';
  static const title = 'title';
  static const isActive = 'isActive';
  static const startDate = 'startDate';
  static const endDate = 'endDate';
  static const adminId = 'admin_id';
}
