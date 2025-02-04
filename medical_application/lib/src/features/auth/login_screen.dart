import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isDoctor = false;
  bool isVisible = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'تسجيل الدخــول',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/images/login_logo.png",
                      height: size.height / 1.8,
                    ),
                    // const SizedBox(height: 5),
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
                      keyboardType: TextInputType.visiblePassword,
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
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const Text(
                          'هل انت طبيب؟',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Checkbox(
                          value: isDoctor,
                          onChanged: (value) {
                            if (value == null) {
                              isDoctor = false;
                            } else {
                              isDoctor = value;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bool login = await Provider.of<MedicalProvider>(
                              context,
                              listen: false,
                            ).login(
                              emailController.text,
                              passwordController.text,
                              isDoctor: isDoctor,
                            );
                            // print(login.toString());
                            if (login) {
                              Provider.of<MedicalProvider>(
                                context,
                                listen: false,
                              ).getData();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => isDoctor
                                      ? const DoctorHomePage()
                                      : const UserHomeScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: ((BuildContext context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: const Text(
                                        'خطــأ!',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                      ),
                                      content: const Text(
                                        'تأكد من كتابه البريد الالكتروني او كلمه السر بشكل صحيح.',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            emailController.text = '';
                                            passwordController.text = '';
                                          },
                                          child: const Text('حسناً'),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("اذا لاتملك حساباً"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: const GetStartedScreen(),
                                type: PageTransitionType.topToBottom,
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            'سجل الان',
                          ),
                        ),
                      ],
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
