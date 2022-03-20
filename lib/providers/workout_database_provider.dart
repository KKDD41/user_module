import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../workout/single_workout.dart';

class WorkoutDatabaseProvider {
  static final _database = FirebaseDatabase(
      databaseURL:
      "https://user-2-5b71e-default-rtdb.europe-west1.firebasedatabase.app")
      .ref()
      .child('workouts/');
  late StreamSubscription<SingleWorkout> _subscription;

  static Future<List<SingleWorkout>> returnWorkouts(String theme) async {
    var result = List<SingleWorkout>.from([], growable: true);
    _database.child(theme).onValue.listen((event) {
      if (event.snapshot.value != null) {
        result.add(SingleWorkout.fromMap(event.snapshot.value as Map));
      }
    });
    return result;
  }
}