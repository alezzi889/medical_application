import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    var doctors = Provider.of<MedicalProvider>(context).doctors;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(doctor: doctors[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple.shade50,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      leading: FittedBox(
                        child: Stack(
                          alignment: const Alignment(1, 1.1),
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage('assets/images/${doctors[index].photo}'),
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                  minHeight: 15, minWidth: 15,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                // ignore: dead_code
                                color: (false) ? Colors.green : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doctors[index].name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      subtitle: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          doctors[index].specialist,
                          style: const TextStyle(
                            color: (false) ? Colors.black : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
