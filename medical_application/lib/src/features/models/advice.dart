class Advice {
  final int? id;
  final int doctorId;
  final String title;
  final String description;
  final String date;

  Advice({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory Advice.fromMap(Map<String, dynamic> map) {
    return Advice(
      id: map['id'],
      doctorId: map['doctorId'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
}