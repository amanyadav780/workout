class Workout {
  int? id;
  String name;
  int value;
  bool isDone;
  DateTime date;

  Workout({
    this.id,
    required this.name,
    required this.value,
    required this.isDone,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'isDone': isDone ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      isDone: map['isDone'] == 1,
      date: DateTime.parse(map['date']),
    );
  }
}
