import 'package:flutter/material.dart';
import 'package:medical_application/src/features/features.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
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
            child: Form(
              key: formKey  ,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/images/register_user.png",
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
                      height: 15.0,
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
                      validator: (value) =>
                      (value!.isEmpty) ? "اختـر الجنس." : null,
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
                      controller: passwordController,keyboardType:isVisible? TextInputType.visiblePassword : TextInputType.text ,
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
                      keyboardType: isVisible ? TextInputType.visiblePassword : TextInputType.text,
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
                          if (passwordController.text == confirmPasswordController.text  && formKey.currentState!.validate()) {
                            final newDoctor = User(
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
                            );
                            Provider.of<MedicalProvider>(context, listen: false).register(newDoctor);
                            // Provider.of<MedicalProvider>(context, listen: false).currentDoctor = newDoctor;
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: const UserHomeScreen(),
                              ),
                              (route) => false,
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
