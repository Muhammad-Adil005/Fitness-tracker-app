class Workout {
  int? id;
  String title;
  String description;
  String type; // New property
  DateTime date; // New property
  int duration;

  Workout({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'date': date.toIso8601String(), // Convert DateTime to string
      'duration': duration,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: map['type'],
      date: DateTime.parse(map['date']), // Parse string back to DateTime
      duration: map['duration'],
    );
  }
}
