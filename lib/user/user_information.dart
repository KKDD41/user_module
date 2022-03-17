import '../workout/workout_theme.dart';

class UserInformation {
  String userName;
  double weight;
  double hightM;
  int cycleDay;
  WorkoutTheme? workoutTheme;

  /// Constructing user's information for the start of using app.
  UserInformation({required this.userName,
    required this.weight,
    required this.hightM,
    required this.cycleDay,
    this.workoutTheme,
  });

  /// Construct an information after query from DB.
  factory UserInformation.fromMap(Map<dynamic, dynamic> map) {
    return UserInformation(userName: map['userName'],
        weight: map['weight'],
        hightM: map['hightM'],
        cycleDay: map['cycleDay'],
        workoutTheme: map['workoutTheme']
    );
  }

  /// Setting methods for each field which add it to DB.
  void setName(String myName) {
    userName = myName;
  }
  void setWeight(double myWeight) {
    weight = myWeight;
  }
  void setHight(double myHight) {
    hightM = myHight;
  }
  void setCycleDay(int myDay) {
    cycleDay = myDay;
  }

  /// Must work with widget, where user chooses today's type of activity.
  void chooseWorkoutTheme(String theme) {

  }
}