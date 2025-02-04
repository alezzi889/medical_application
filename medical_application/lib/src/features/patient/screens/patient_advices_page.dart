import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:provider/provider.dart';

class UserAdviceLayout extends StatefulWidget {
  const UserAdviceLayout({super.key});

  @override
  State<UserAdviceLayout> createState() => _UserOrderLayoutState();
}

class _UserOrderLayoutState extends State<UserAdviceLayout> {
  @override
  Widget build(BuildContext context) {
    List<Advice> displayedTasks = Provider.of<MedicalProvider>(context).advices;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            // Analysis heading section
            height: 140,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple,
            padding: const EdgeInsets.only(right: 40, top: 35),
            child: const Text(
              'الإرشادات الطبية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            displayedTasks[index].title,
                                            style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            displayedTasks[index].description,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            displayedTasks[index].date,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                    },
                    itemCount: displayedTasks.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
