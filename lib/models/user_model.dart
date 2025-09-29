class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final bool isAdmin;
  final DateTime joinAt;
  final DateTime birthDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    this.isAdmin = false,
    required this.joinAt,
    required this.birthDate,
  });

  // Convert UserModel to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'isAdmin': isAdmin,
      'joinAt': joinAt.toIso8601String(),
      'birthDate': birthDate.toIso8601String(),
    };
  }

  // Create UserModel from Map (JSON deserialization)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      isAdmin: map['isAdmin'] ?? false,
      joinAt: DateTime.parse(map['joinAt']),
      birthDate: DateTime.parse(map['birthDate']),
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone, imageUrl: $imageUrl, isAdmin: $isAdmin, joinAt: $joinAt, birthDate: $birthDate}';
  }
}
