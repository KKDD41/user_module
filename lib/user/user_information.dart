import 'package:user2/providers/user_database_provider.dart';

class UserInformation {
  String userName;
  double weight;
  double hightM;
  int cycleDay;
  bool _isEmpty = true;

  /// Constructing user's information for the start of using app.
  UserInformation({
    required this.userName,
    required this.weight,
    required this.hightM,
    required this.cycleDay,
  }) {
    _isEmpty = false;
  }

  /// Construct an information after query from DB.
  factory UserInformation.fromMap(Map<dynamic, dynamic> map) {
    final userInfo = UserInformation(
      userName: map['userName'],
      weight: map['weight'],
      hightM: map['hightM'],
      cycleDay: map['cycleDay'],
    );
    if (userInfo.userName != '') {
      userInfo._isEmpty = false;
    }
    return userInfo;
  }

  bool isEmpty() {
    return _isEmpty;
  }

  /// Setting methods for each field which add it to DB.
  void setInfo(
      String userID, String name, double weight, double height, int day) {
    _setName(name);
    _setHight(height);
    _setWeight(weight);
    _setCycleDay(day);
    DatabaseProvider(userID).setInfo(
        userID, {'name': name, 'height': height, 'weight': weight, 'day': day});
  }

  void _setName(String myName) {
    userName = myName;
  }

  void _setWeight(double myWeight) {
    weight = myWeight;
  }

  void _setHight(double myHight) {
    hightM = myHight;
  }

  void _setCycleDay(int myDay) {
    cycleDay = myDay;
  }

  /// Must work with widget, where user chooses today's type of activity.
  void chooseWorkoutTheme(String theme) {}
}
