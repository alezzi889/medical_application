class User {
  final int? id;
  final String name;
  final String gender;
  final int age;
  final String photo;
  final String phone;
  final String email;
  final String password;
  final bool isDoctor;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.photo,
    required this.phone,
    required this.email,
    required this.password,
    this.isDoctor = false,
  });

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
      // 'isDoctor': isDoctor ? 1 : 0, // تحويل Boolean إلى Integer لـ SQLite
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
      photo: map['photo'],
      phone: map['phone'].toString(),
      email: map['email'],
      password: map['password'],
      isDoctor: map['isDoctor'] == 1,
    );
  }
}