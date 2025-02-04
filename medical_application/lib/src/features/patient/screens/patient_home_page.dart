import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'الرئيسية',
            style: TextStyle(color: Colors.deepPurple),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.chat_outlined,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ChatsScreen(),
                //   ),
                // );
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            Provider.of<MedicalProvider>(context, listen: false)
                .changeIndex(index);
          },
          selectedIndex: Provider.of<MedicalProvider>(context, listen: false)
              .currentIndex, //cubit.currentIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "",
            ),
            NavigationDestination(
              icon: Icon(Icons.view_timeline_outlined),
              selectedIcon: Icon(Icons.view_timeline_rounded),
              label: "",
            ),
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: "",
            ),
          ],
        ),
        body: SafeArea(
          child: Provider.of<MedicalProvider>(context).patientScreens[
              Provider.of<MedicalProvider>(context).currentIndex],
        ),
      ),
    );
  }
}
