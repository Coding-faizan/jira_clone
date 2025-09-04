class Engineer {
  int? id;
  String name;
  String role;
  int adminId;

  Engineer({
    this.id,
    required this.name,
    required this.role,
    required this.adminId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      EngineerFields.id: id,
      EngineerFields.name: name,
      EngineerFields.role: role,
      EngineerFields.adminId: adminId,
    };
  }

  factory Engineer.fromMap(Map<String, dynamic> map) {
    return Engineer(
      id: map[EngineerFields.id] != null ? map[EngineerFields.id] as int : null,
      name: map[EngineerFields.name] as String,
      role: map[EngineerFields.role] as String,
      adminId: map[EngineerFields.adminId] as int,
    );
  }

  Engineer copyWith({int? id, String? name, String? role, int? adminId}) {
    return Engineer(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      adminId: adminId ?? this.adminId,
    );
  }
}

class EngineerFields {
  static const id = 'id';
  static const name = 'name';
  static const role = 'role';
  static const adminId = 'admin_id';
}
