import 'package:intl/intl.dart';
import 'package:user2/providers/user_database_provider.dart';
import 'package:user2/user/cycle_notifier.dart';

class UserInformation {
  String userName;
  int weight;
  int hightM;
  CycleNotifier cycleNotifier;
  bool _isEmpty = true;

  /// Constructing user's information for the start of using app.
  UserInformation({
    required this.userName,
    required this.weight,
    required this.hightM,
    required this.cycleNotifier,
  }) {
    print('Simple constructor works correctly');
    _isEmpty = false;
  }
  /// Construct an information after query from DB.
  factory UserInformation.fromMap(Map<dynamic, dynamic> map) {
    print('fromMap begins');
    final userInfo = UserInformation(
        userName: map['userName'],
        weight: map['weight'],
        hightM: map['hightM'],
        cycleNotifier: CycleNotifier(
          cycleDay: map['cycleNotifier']['cycleDay'],
          cycleLength: map['cycleNotifier']['cycleLength'],
          currentDate : CycleNotifier.fromString(map['cycleNotifier']['currentDate']),
        )
    );
    userInfo._isEmpty = false;
    print('userInfo from map works correctly');
    return userInfo;
  }
  bool isEmpty() {
    return _isEmpty;
  }

  /// Updating information separately.
  Future setName(String myName, String userID) async {
    userName = myName;
    await DatabaseProvider.setInfo(userID, {'userName': myName});
  }

  Future setWeight(int myWeight, String userID) async {
    weight = myWeight;
    await DatabaseProvider.setInfo(userID, {'weight': myWeight});
  }

  Future setHight(int myHight, String userID) async {
    hightM = myHight;
    await DatabaseProvider.setInfo(userID, {'hightM': myHight});
  }

  Future setCycleDay(int myCycleDay, String userID) async {
    cycleNotifier.cycleDay = myCycleDay;
    await DatabaseProvider.setInfo(userID, {
      'cycleNotifier': {
        'cycleDay': cycleNotifier.cycleDay.toString(),
      }
    });
  }

  Future setCycleLength(int myCycleLength, String userID) async {
    cycleNotifier.cycleLength = myCycleLength;
    await DatabaseProvider.setInfo(userID, {
      'cycleNotifier': {
        'cycleLength': cycleNotifier.cycleLength.toString(),
      }
    });
  }

  @override
  String toString() {
    return '''weight : $weight, \n 
              userName : $userName, \n 
              hightM : $hightM, \n 
              cycleNotifier : \n 
                  - 'cycleDay' : ${cycleNotifier.cycleDay}, \n 
                  - 'cycleLength' : ${cycleNotifier.cycleLength}, \n 
                  - 'currentDate' : ${DateFormat('yyyy-MM-dd')
                                      .format(cycleNotifier
                                      .currentDate)}
              ''';
  }
}