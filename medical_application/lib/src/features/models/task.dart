class Task {
  final int? id;
  final int doctorId;
  final String title;
  final String description;
  final String date;
  final String time;
  final String tag;
   bool taskDone;

  Task({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.tag,
    this.taskDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'tag': tag,
      'taskDone': taskDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      doctorId: map['doctorId'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      tag: map['tag'],
      taskDone: map['taskDone'] == 1,
    );
  }

  copyWith({required int doctorId}) {}
}