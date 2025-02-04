import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class NewAdvice extends StatefulWidget {
  final Doctor doctor;
  const NewAdvice({super.key, required this.doctor});

  @override
  _NewAdviceState createState() => _NewAdviceState();
}

class _NewAdviceState extends State<NewAdvice> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(icon: const Icon(Icons.done), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // History heading section
                height: 140,
                width: MediaQuery.of(context).size.width,
                color: Colors.deepPurple,
                padding: const EdgeInsets.only(right: 40, top: 35),
                child: const Text(
                  'نشر جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'العنوان',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: descController,
                      decoration: const InputDecoration(
                        labelText: 'الوصف',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Advice newAdvice =  Advice(
                                id: null,
                                doctorId: widget.doctor.id!,
                                title: titleController.text,
                                description: descController.text,
                                date: DateTime.now().toString(),
                          );
                          Provider.of<MedicalProvider>(context, listen: false).addAdvice(newAdvice);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 100),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            Colors.deepPurple,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'نـشـر',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
