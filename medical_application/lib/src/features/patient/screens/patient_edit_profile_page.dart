import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:provider/provider.dart';

class UserEditProfilePage extends StatelessWidget {
  const UserEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<MedicalProvider>(context).currentUser;
    var name = TextEditingController();
    var phone = TextEditingController();
    var email = TextEditingController();
    var specialist = TextEditingController();
    var bio = TextEditingController();
    var password = TextEditingController();
    name.text = user.name;
    phone.text = user.phone;
    email.text = user.email;
    password.text = user.password;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'تعديل الملف الشخصي',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple,
            ),
          ),
        ),
        backgroundColor: const Color(0xfff6f6f9),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 140,
                  child: Image.asset(
                      "assets/images/${Provider.of<MedicalProvider>(context).currentUser.photo}"),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 25.0,
                ),
                color: Colors.white,
                child: TextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 25.0,
                ),
                color: Colors.white,
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 25.0,
                ),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 25.0,
                ),
                child: TextField(
                  controller: specialist,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.medical_services_outlined,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: TextField(
                  controller: bio,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.recent_actors,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 25.0,
                ),
                child: TextField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.key,
                      size: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        height: 50,
                        child: const Text(
                          'حفظ التغييرات',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () async {
                          final newUser = User(
                            id: null,
                            name: name.text,
                            gender: user.gender,
                            age: user.age,
                            photo: user.photo,
                            phone: phone.text,
                            email: email.text,
                            password: password.text,
                          );
                          Navigator.pop(context);
                          await Provider.of<MedicalProvider>(context, listen: false).editUserProfile(newUser);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
