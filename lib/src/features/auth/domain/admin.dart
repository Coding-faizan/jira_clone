//ids nullable due to auto increment

class Admin {
  int? id;
  String email;
  String password;
  Admin({this.id, required this.email, required this.password});

  Admin copyWith({int? id, String? email, String? password}) {
    return Admin(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AdminFields.id: id,
      AdminFields.email: email,
      AdminFields.password: password,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map[AdminFields.id] != null ? map[AdminFields.id] as int : null,
      email: map[AdminFields.email] as String,
      password: map[AdminFields.password] as String,
    );
  }
}

class AdminFields {
  static const id = 'id';
  static const email = 'email';
  static const password = 'password';
}
