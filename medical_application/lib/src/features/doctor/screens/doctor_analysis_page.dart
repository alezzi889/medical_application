import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';
import 'package:provider/provider.dart';


class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  @override
  Widget build(BuildContext context) {
    List<Task> displayedTasks = Provider.of<MedicalProvider>(context).orders;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              // Analysis heading section
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              padding: const EdgeInsets.only(right: 40, top: 35),
              child: const Text(
                'الطلبات المتاحة',
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
                        var done = displayedTasks[index].taskDone;
                        return AnimatedOpacity(
                          opacity: !done ? 1 : 0.4,
                          duration: const Duration(milliseconds: 200),
                          child: Dismissible(
                            key: Key(displayedTasks[index].title),
                            background: slideLeftBackground(),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            "هل انت متأكد من رفض ${displayedTasks[index].title}?"),
                                        actions: [
                                          MaterialButton(
                                            child: const Text(
                                              "الغاء",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Task task = displayedTasks[index];
                                              Provider.of<MedicalProvider>(
                                                      context)
                                                  .deleteTask(task);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          MaterialButton(
                                            child: const Text(
                                              "رفض",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () async {
                                              Task task = displayedTasks[index];
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
                                              displayedTasks[index].time,
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
                                    Column(
                                      children: [
                                        const Text(
                                          'قبول',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: !done
                                              ? const Icon(
                                                  Icons.lens_outlined,
                                                  color: Colors.deepPurple,
                                                )
                                              : const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.deepPurple,
                                                ),
                                          onPressed: () {
                                              displayedTasks[index].taskDone =
                                                  !displayedTasks[index]
                                                      .taskDone;
                                              setState(() {});
                                              Task task = displayedTasks[index];
                                              Provider.of<MedicalProvider>(context, listen: false).updateTask(task);
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
                      itemCount: displayedTasks.length,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
