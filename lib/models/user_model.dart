class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  // final String createdAt;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
  });

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone}';
  }
}
