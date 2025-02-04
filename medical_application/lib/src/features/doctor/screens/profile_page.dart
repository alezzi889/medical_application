import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_application/src/src.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'الملف الشخصي',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 140,
                  child: Image.asset(
                      "assets/images/${Provider.of<MedicalProvider>(context).currentDoctor.photo}"),
                ),

              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25,
                ),
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.deepPurple,
                  ),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.phone, color: Colors.deepPurple),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.phone,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.deepPurple),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.medical_services_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.specialist,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(Icons.recent_actors, color: Colors.deepPurple),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.key,
                    color: Colors.deepPurple,
                  ),
                  title: Consumer<MedicalProvider>(
                    builder: (context, value, child) => Text(
                      value.currentDoctor.password,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 9),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0,
                ),
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        height: 50,
                        child: const Text(
                          'تسجيل الخروج',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const StartedScreen(),
                            ),
                            (route) => false,
                          );
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
