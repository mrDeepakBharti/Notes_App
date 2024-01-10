// ignore: file_names
class UserModel {
  final int? id;
  String name;
  String email;
  String password;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password});

  UserModel.formap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        password = map['password'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
