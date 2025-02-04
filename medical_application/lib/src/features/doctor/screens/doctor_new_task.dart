import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import '../../../src.dart';

class NewTask extends StatefulWidget {
  final Doctor doctor;
  const NewTask(this.doctor, {super.key}); // addNewTask from task_page.dart

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedTag = 'medicine';
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(Provider.of<MedicalProvider>(context, listen: false).currentUser.id);
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
                  'موعد جديد',
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
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'العنوان',
                      ),
                    ),
                    TextField(
                      controller: dateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                        ).then(
                          (value) {
                            dateController.text =
                                intl.DateFormat.yMMMd().format(value!);
                          },
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'التاريخ',
                      ),
                    ),
                    TextField(
                      controller: timeController,
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          timeController.text = value!.format(context);
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'الوقت',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      maxLines: 3,
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'الوصف',
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.white,
                      value: _selectedTag,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (newTag) {
                        setState(() {
                          _selectedTag = newTag!;
                        });
                      },
                      items: [
                        'medicine',
                        'exercise',
                        'diet',
                        'other',
                      ].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Task newOrder = Task(
                            id: null,
                            doctorId: widget.doctor.id!,
                            title: _titleController.text,
                            description: _descController.text,
                            date: dateController.text,
                            time: timeController.text,
                            tag: _selectedTag,
                          );

                          Provider.of<MedicalProvider>(context, listen: false).addTask(newOrder);
                          Navigator.pop(context);

                        },
                        style: ButtonStyle(
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
                          'اضافة موعد',
                          style: TextStyle(color: Colors.white),
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
