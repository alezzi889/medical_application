import 'package:flutter/material.dart';
import 'package:medical_application/src/src.dart';


class TaskList extends StatefulWidget {
  final List<Task> displayedTasks;
  final Function deleteTask;

  const TaskList(this.displayedTasks, this.deleteTask, {super.key});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // var done = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var done = widget.displayedTasks[index].taskDone;
            return AnimatedOpacity(
              opacity: !done ? 1 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: Dismissible(
                // Delete task from list
                key: Key(widget.displayedTasks[index].title),
                background: slideLeftBackground(),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                              "هل انت متأكد على حذف ${widget.displayedTasks[index].title}?"),
                          actions: <Widget>[
                            MaterialButton(
                              child: const Text(
                                "الغاء",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: const Text(
                                "حذف",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                // !Delete task here
                                widget.deleteTask(
                                    widget.displayedTasks[index].title);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return false;
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.displayedTasks[index].title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  widget.displayedTasks[index].description,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  widget.displayedTasks[index].time,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: !done
                              ? Icon(
                            Icons.lens_outlined,
                            color: Theme.of(context).primaryColor,
                          )
                              : Icon(
                            Icons.check_circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.displayedTasks[index].taskDone =
                              !widget.displayedTasks[index].taskDone;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: widget.displayedTasks.length,
        ),
      ),
    );
  }
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: const Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            "حذف",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}
