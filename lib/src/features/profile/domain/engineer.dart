import 'dart:convert';

class Engineer {
  int? id;
  String name;
  String role;
  int adminId;
  bool isTicketAssigned;

  Engineer({
    this.id,
    required this.name,
    required this.role,
    required this.adminId,
    required this.isTicketAssigned,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      EngineerFields.id: id,
      EngineerFields.name: name,
      EngineerFields.role: role,
      EngineerFields.adminId: adminId,
      EngineerFields.isTicketAssigned: isTicketAssigned ? 1 : 0,
    };
  }

  factory Engineer.fromMap(Map<String, dynamic> map) {
    return Engineer(
      id: map[EngineerFields.id] != null ? map[EngineerFields.id] as int : null,
      name: map[EngineerFields.name] as String,
      role: map[EngineerFields.role] as String,
      adminId: map[EngineerFields.adminId] as int,
      isTicketAssigned: map[EngineerFields.isTicketAssigned] == 1,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Engineer.fromJson(String source) =>
      Engineer.fromMap(jsonDecode(source));

  Engineer copyWith({
    int? id,
    String? name,
    String? role,
    int? adminId,
    bool? isTicketAssigned,
  }) {
    return Engineer(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      adminId: adminId ?? this.adminId,
      isTicketAssigned: isTicketAssigned ?? this.isTicketAssigned,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Engineer && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class EngineerFields {
  static const id = 'id';
  static const name = 'name';
  static const role = 'role';
  static const adminId = 'admin_id';
  static const isTicketAssigned = 'is_ticket_assigned';
}
