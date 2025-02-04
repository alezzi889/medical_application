import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final specController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String gender = 'ذكر';
  bool isVisible = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/images/register_doctor.png",
                      height: size.height / 1.8,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل الاسـم." : null,
                      decoration: InputDecoration(
                        labelText: 'الاسـم',
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل رقم الهاتف." : null,
                      decoration: InputDecoration(
                        labelText: 'رقم الهاتف',
                        prefixIcon: const Icon(
                          Icons.smartphone_sharp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    DropdownButtonFormField(
                      value: gender,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: InputDecoration(
                        label: const Text("اختـر الجنس"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>[
                        'ذكر',
                        'أنثى',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: specController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل التخصص." : null,
                      decoration: InputDecoration(
                        labelText: 'التخصص',
                        prefixIcon: const Icon(
                          Icons.medical_services_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل النبذة الشخصية." : null,
                      decoration: InputDecoration(
                        labelText: 'النبذة الشخصية',
                        prefixIcon: const Icon(
                          Icons.recent_actors,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل البريد الالكتروني." : null,
                      decoration: InputDecoration(
                        labelText: 'البريد الالكتروني',
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType:isVisible? TextInputType.visiblePassword : TextInputType.text ,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل الباسورد." : null,
                      decoration: InputDecoration(
                        labelText: 'كلمه السر',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: isVisible? TextInputType.visiblePassword: TextInputType.text,
                      validator: (value) =>
                      (value!.isEmpty) ? "ادخل تأكيد كلمه السر." : null,
                      decoration: InputDecoration(
                        labelText: 'تأكيد كلمه السر',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text && formKey.currentState!.validate()) {
                            final newDoctor = Doctor(
                              id: null,
                              name: nameController.text,
                              gender: gender,
                              age: 25,
                              photo: gender == 'ذكر'
                                  ? 'male_icon.png'
                                  : 'female_icon.png',
                              phone: phoneController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              description: bioController.text,
                              specialist: specController.text,
                            );
                            Provider.of<MedicalProvider>(context, listen: false).currentDoctor = newDoctor;
                            Provider.of<MedicalProvider>(context, listen: false).register(newDoctor, isDoctor: true);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: const DoctorHomePage(),
                            ),
                          );
                          }
                        },
                        child: const Text(
                          'تسجيل',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
