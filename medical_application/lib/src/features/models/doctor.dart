import 'models.dart';

class Doctor extends User {
  final String description;
  final String specialist;

  Doctor({
    required super.id,
    required super.name,
    required super.gender,
    required super.age,
    required super.photo,
    required super.phone,
    required super.email,
    required super.password,
    required this.description,
    required this.specialist,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'photo': photo,
      'phone': phone,
      'email': email,
      'password': password,
      'description': description,
      'specialist': specialist,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
      photo: map['photo'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
      description: map['description'],
      specialist: map['specialist'],
    );
  }
}
