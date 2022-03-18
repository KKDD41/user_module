import 'package:user2/providers/user_database_provider.dart';

class UserInformation {
  String userName;
  int weight;
  int hightM;
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
    userInfo._isEmpty = false;
    return userInfo;
  }

  bool isEmpty() {
    return _isEmpty;
  }

  /// Updating information separately.
  /// Works correct only if directory 'user/userID' exists.
  Future setName(String myName, String userID) async {
    userName = myName;
    await DatabaseProvider().setInfo(userID, {'userName': myName});
  }

  Future setWeight(int myWeight, String userID) async {
    weight = myWeight;
    await DatabaseProvider().setInfo(userID, {'weight': myWeight});
  }

  Future setHight(int myHight, String userID) async {
    hightM = myHight;
    await DatabaseProvider().setInfo(userID, {'hightM': myHight});
  }

  Future setCycleDay(int myDay, String userID) async {
    cycleDay = myDay;
    await DatabaseProvider().setInfo(userID, {'cycleDay': myDay});
  }

  @override
  String toString() {
    return 'weight : $weight, \n userName : $userName, \n hightM : $hightM, \n cycleDay : $cycleDay';
  }
}
