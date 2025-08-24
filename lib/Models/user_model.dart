
class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? token;
  final String? phone;
  final DateTime? createdAt;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.token,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    token: json['token'],
    phone: json['phone'],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'token': token,
    'phone': phone,
    'createdAt': createdAt?.toIso8601String(),
  };

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? token,
    String? phone,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
