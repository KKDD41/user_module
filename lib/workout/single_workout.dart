

class SingleWorkout {
  late String pictureUrl;
  late String nameOfWorkout;

  SingleWorkout({required this.pictureUrl, required this.nameOfWorkout});
  factory SingleWorkout.fromMap(Map<dynamic, dynamic> info) {
    return SingleWorkout(nameOfWorkout: info.keys.first,
        pictureUrl: info[info.keys.first]);
  }

  Map<String, int> setActivity(String userID, String nameOfWorkout) {
    // TODO: create an appropriate algorithm, which will access to DB and build appropriate params for user.
    return {'numberOfSets' : 0, 'numberInSet' : 0};
  }
}
