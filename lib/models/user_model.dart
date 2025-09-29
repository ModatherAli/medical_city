class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final bool isAdmin;
  final bool isActive;
  final String token;
  final DateTime joinAt;
  final DateTime birthDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    this.isAdmin = false,
    this.isActive = false,
    this.token = "",
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
      'isActive': isActive,
      'token': token,
      'joinAt': joinAt.toIso8601String(),
      'birthDate': birthDate.toIso8601String(),
    };
  }

  // For Firestore helper compatibility
  Map<String, dynamic> toJson() => toMap();

  // Create UserModel from Map (JSON deserialization)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      isAdmin: map['isAdmin'] ?? false,
      isActive: map['isActive'] ?? false,
      token: map['token'] ?? '',
      joinAt: DateTime.parse(map['joinAt']),
      birthDate: DateTime.parse(map['birthDate']),
    );
  }

  // Copy with method to create a new instance with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    bool? isAdmin,
    bool? isActive,
    String? token,
    DateTime? joinAt,
    DateTime? birthDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      token: token ?? this.token,
      joinAt: joinAt ?? this.joinAt,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone, imageUrl: $imageUrl, isAdmin: $isAdmin, isActive: $isActive, token: $token, joinAt: $joinAt, birthDate: $birthDate}';
  }
}
