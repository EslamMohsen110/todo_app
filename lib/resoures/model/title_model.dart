class TaskModels {
  static const String nameCollection = "task";
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TaskModels({
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  TaskModels.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data["id"] as String,
          title: data["title"] as String,
          description: data["description"] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
          isDone: data["isDone"] as bool,
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}

// class TaskModel {
//   static const String collectionTask = 'Tasks';
//   String id;
//   String title;
//   String description;
//   dynamic dateTime;
//   bool isDone;
//
//   TaskModel({
//     this.id = '',
//     this.isDone = false,
//     required this.title,
//     required this.description,
//     required this.dateTime,
//   });
//   TaskModel.fromJson(Map<String, dynamic> jsonFrom)
//       : this(
//             title: jsonFrom['title'] as String,
//             description: jsonFrom['description'] as String,
//             // dateTime: (jsonFrom['dateTime'] as Timestamp).toDate(),
//             // dateTime:jsonFrom['dateTime'].toDate(),
//             dateTime: DateTime.fromMillisecondsSinceEpoch(jsonFrom['dateTime']),
//             id: jsonFrom['id'] as String,
//             isDone: jsonFrom['isDone'] as bool);
//
//   Map<String, dynamic> jsonTo() {
//     return {
//       'title': title,
//       'id': id,
//       'description': description,
//       'dateTime': dateTime.millisecondsSinceEpoch,
//       'isDone': isDone,
//     };
//   }
// }
