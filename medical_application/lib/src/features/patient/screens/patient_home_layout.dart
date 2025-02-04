import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:medical_application/src/src.dart';

class UserHomeLayout extends StatefulWidget {
  const UserHomeLayout({super.key});

  @override
  State<UserHomeLayout> createState() => _UserHomeLayoutState();
}

class _UserHomeLayoutState extends State<UserHomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "مرحباً،",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          Provider.of<MedicalProvider>(context)
                              .currentUser
                              .name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const UserProfilePage(),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage("assets/images/user.png"),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.deepPurple,
                height: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'قائمة الأطباء',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        // width: double.infinity,
        // height: MediaQuery.of(context).size.height / 3,
        const Expanded(
          child: DoctorList(),
        ),
      ],
    );
  }
}
