import 'package:user2/providers/workout_database_provider.dart';
import 'package:user2/workout/single_workout.dart';

class WorkoutTheme {
  String theme;

  /// Constructor.
  WorkoutTheme({required this.theme});

  /// Query to DB that returns a list of available single workouts
  /// for current theme.
  Future<List<SingleWorkout>> returnListOfWorkouts() async {
    return await WorkoutDatabaseProvider.returnWorkouts(theme);
  }


}