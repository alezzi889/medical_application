import 'package:flutter/material.dart';
import '../../src.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    radius: 82,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                        radius: 78,
                        child: Image.asset(
                          "assets/images/${doctor.photo}",
                          height: 140,
                        )),
                  ),
                ),
              ),
              Center(
                child: Text(
                  doctor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const Divider(height: 3),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'التخصص',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    doctor.specialist,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'نبذة عامة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  doctor.description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height / 3),
            ],
          ),
        ),
        bottomNavigationBar: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.deepPurple,
                  height: 50,
                  child: const Text(
                    'طلــب موعــد',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewTask(doctor),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
