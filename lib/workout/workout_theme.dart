import 'single_workout.dart';

class WorkoutTheme {
  String theme;

  /// Constructor.
  WorkoutTheme({required this.theme});

  /// Setter.
  void setTheme(String newTheme) {
    theme = newTheme;
  }

/// Query to DB that returns a list of available single workouts
/// for current theme.
//List<SingleWorkout> getListOfWorkouts() {}


}