

class SingleWorkout {
  late String pictureUrl;
  late String nameOfWorkout;
  late String description;
  late int complexity;


  SingleWorkout({required this.pictureUrl, required this.nameOfWorkout, required this.description, required this.complexity});
  factory SingleWorkout.fromMap(Map<dynamic, dynamic> info) {
    return SingleWorkout(nameOfWorkout: info.keys.first,
        pictureUrl: info[info.keys.first]['pictureUrl'],
        description: info[info.keys.first]['description'],
        complexity: info[info.keys.first]['complexity'],
    );
  }


}
