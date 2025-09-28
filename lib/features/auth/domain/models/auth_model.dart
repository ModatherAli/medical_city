class AuthModel {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  // final String createdAt;

  AuthModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
  });

  @override
  String toString() {
    return 'AuthModel{id: $id, name: $name, email: $email, phone: $phone}';
  }
}
