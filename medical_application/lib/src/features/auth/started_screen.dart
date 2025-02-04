import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({Key? key}) : super(key: key);

  @override
  State<StartedScreen> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              height: size.height / 1.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Image.asset(
                "assets/images/started_logo.png",
                // height: 50,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const Text(
                  //   "كــل المتخصصين في تطبيق واحد",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 24,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 130,
                  //   ),
                  //   child: Text(
                  //     ".ابحث عن طبيبك وحدد موعداً بنقرة واحدة",
                  //     style: TextStyle(
                  //       color: Colors.black38,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),

                  Container(
                    alignment:  Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const GetStartedScreen();
                          })),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            "البدء الان",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
