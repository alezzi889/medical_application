


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
    final List<Task> displayedTasks = Provider.of<MedicalProvider>(context).tasks;
    return Consumer<MedicalProvider>(
      builder: (context, value, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Column(
            children: [
              const Date(),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnimatedOpacity(
                          opacity: !value.tasks[index]
                              .taskDone ? 1 : 0.4,
                          duration: const Duration(milliseconds: 200),
                          child: Dismissible(
                            // Delete task from list
                            key: Key(value.tasks[index].title),
                            background: slideLeftBackground(),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            "هل تؤكـد على حذف ${value.tasks[index].title}?"),
                                        actions: <Widget>[
                                          MaterialButton(
                                            child: const Text(
                                              "الغاء",
                                              style:
                                              TextStyle(color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          MaterialButton(
                                            child: const Text(
                                              "حــذف",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () async {
                                              Task task = value.tasks[index];
                                              await Provider.of<MedicalProvider>(
                                                  context, listen: false).deleteTask(task);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                              return null;
                            },
                            child: Card(
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
                                              value.tasks[index].title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurple,
                                              ),
                                            ),
                                            Text(
                                              value.tasks[index].description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            Text(
                                              value.tasks[index]
                                                  .time,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'تمت المعالجة',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: !value.tasks[index]
                                              .taskDone
                                              ? const Icon(
                                            Icons.lens_outlined,
                                            color: Colors.deepPurple,
                                          )
                                              : const Icon(
                                            Icons.check_circle,
                                            color: Colors.deepPurple,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              setState(() {});
                                              Task task = value.tasks[index];
                                              Provider.of<MedicalProvider>(context, listen: false).updateTask(task);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: value.tasks.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepPurple,
        //   child: const Icon(Icons.add, color: Colors.white),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => NewTask(_addNewTask)),
        //     );
        //   },
        // ),
